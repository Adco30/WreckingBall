import SpriteKit
import Combine

typealias Mask = UInt64

class Component {
    weak var entity: Entity?
    private static var next: Mask = 1
    private static var types: [ObjectIdentifier: Mask] = [:]
    static func mask<T: Component>(for _: T.Type) -> Mask {
        let id = ObjectIdentifier(T.self)
        if let m = types[id] { return m }
        let m = next
        next <<= 1
        types[id] = m
        return m
    }
    static var typeMask: Mask { mask(for: Self.self) }
}

protocol System {
    func update(dt: TimeInterval)
}

protocol EventSubscriber: AnyObject {
    func subscribe(to events: AnyPublisher<GameEvent, Never>)
}

final class Entity: Hashable {
    private var comps: [ObjectIdentifier: Component] = [:]
    private(set) var mask: Mask = 0
    let id = UUID()
    func add(_ c: Component) {
        let id = ObjectIdentifier(type(of: c))
        comps[id] = c
        c.entity = self
        mask |= Component.mask(for: type(of: c))
    }
    func get<T: Component>(_ t: T.Type) -> T? {
        comps[ObjectIdentifier(t)] as? T
    }
    static func ==(lhs: Entity, rhs: Entity) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

enum GameEvent {
    case ballLaunched(Entity, CGVector)
    case ballMoved(Entity, CGPoint)
    case restarted
}

final class World {
    private var entities: Set<Entity> = []
    private var systems: [System] = []
    private let bus = PassthroughSubject<GameEvent, Never>()
    var events: AnyPublisher<GameEvent, Never> { bus.eraseToAnyPublisher() }
    func send(_ e: GameEvent) { bus.send(e) }
    func add(_ e: Entity) { entities.insert(e) }
    func entities(with types: [Component.Type]) -> [Entity] {
        let m = types.reduce(Mask(0)) { $0 | Component.mask(for: $1) }
        return entities.filter { ($0.mask & m) == m }
    }
    func addSystem(_ s: System) {
        systems.append(s)
        (s as? EventSubscriber)?.subscribe(to: events)
    }
    func update(dt: TimeInterval) {
        systems.forEach { $0.update(dt: dt) }
    }
}
