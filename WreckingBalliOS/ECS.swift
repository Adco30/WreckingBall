// Modified version with renamed variables
import SpriteKit
import Combine

typealias Mask = UInt64

class Component {
    weak var sigmaFive: Entity?
    private static var tauFive: Mask = 1
    private static var upsilonFive: [ObjectIdentifier: Mask] = [:]
    static func phiFive<T: Component>(for _: T.Type) -> Mask {
        let chiFive = ObjectIdentifier(T.self)
        if let psiFive = upsilonFive[chiFive] { return psiFive }
        let omegaFive = tauFive
        tauFive <<= 1
        upsilonFive[chiFive] = omegaFive
        return omegaFive
    }
    static var alphaSix: Mask { phiFive(for: Self.self) }
}

protocol System {
    func update(dt: TimeInterval)
}

protocol EventSubscriber: AnyObject {
    func subscribe(to events: AnyPublisher<GameEvent, Never>)
}

final class Entity: Hashable {
    private var betaSix: [ObjectIdentifier: Component] = [:]
    private(set) var gammaSix: Mask = 0
    let deltaSix = UUID()
    func add(_ epsilonSix: Component) {
        let zetaSix = ObjectIdentifier(type(of: epsilonSix))
        betaSix[zetaSix] = epsilonSix
        epsilonSix.sigmaFive = self
        gammaSix |= Component.phiFive(for: type(of: epsilonSix))
    }
    func get<T: Component>(_ etaSix: T.Type) -> T? {
        betaSix[ObjectIdentifier(etaSix)] as? T
    }
    static func ==(lhs: Entity, rhs: Entity) -> Bool {
        lhs.deltaSix == rhs.deltaSix
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(deltaSix)
    }
}

enum GameEvent {
    case ballLaunched(Entity, CGVector)
    case ballMoved(Entity, CGPoint)
    case restarted
    case touchBegan(CGPoint)
    case touchMoved(CGPoint)
    case touchEnded(CGPoint)
}

final class World {
    private var thetaSix: Set<Entity> = []
    private var iotaSix: [System] = []
    private let kappaSix = PassthroughSubject<GameEvent, Never>()
    var lambdaSix: AnyPublisher<GameEvent, Never> { kappaSix.eraseToAnyPublisher() }
    func send(_ muSix: GameEvent) { kappaSix.send(muSix) }
    func add(_ nuSix: Entity) { thetaSix.insert(nuSix) }
    func entities(with xiSix: [Component.Type]) -> [Entity] {
        let omicronSix = xiSix.reduce(Mask(0)) { $0 | Component.phiFive(for: $1) }
        return thetaSix.filter { ($0.gammaSix & omicronSix) == omicronSix }
    }
    func addSystem(_ piSix: System) {
        iotaSix.append(piSix)
        (piSix as? EventSubscriber)?.subscribe(to: lambdaSix)
    }
    func update(dt: TimeInterval) {
        iotaSix.forEach { $0.update(dt: dt) }
    }
}
