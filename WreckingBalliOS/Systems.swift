import SpriteKit
import Combine

final class InputSystem: System, EventSubscriber {
    private weak var scene: SKScene?
    private let world: World
    private var drag: Entity?
    init(scene: SKScene, world: World) {
        self.scene = scene
        self.world = world
    }
    func subscribe(to events: AnyPublisher<GameEvent, Never>) {}
    func update(dt: TimeInterval) {}
    func began(at p: CGPoint) {
        guard drag == nil else { return }
        for e in world.entities(with: [InputComponent.self, RenderComponent.self]) {
            guard let input = e.get(InputComponent.self), input.draggable,
                  let node = e.get(RenderComponent.self)?.node else { continue }
            if node.contains(p) {
                drag = e
                input.dragging = true
                node.physicsBody?.isDynamic = false
                node.position = p
            }
        }
    }
    func moved(to p: CGPoint) {
        guard let e = drag, let node = e.get(RenderComponent.self)?.node else { return }
        node.position = p
        world.send(.ballMoved(e, p))
    }
    func ended(at p: CGPoint) {
        guard let e = drag, let node = e.get(RenderComponent.self)?.node else {
            drag = nil
            return
        }
        if let start = e.get(TransformComponent.self)?.pos {
            let v = CGVector(dx: start.x - p.x, dy: start.y - p.y)
            if v.length() > 10 {
                world.send(.ballLaunched(e, v))
            } else {
                node.position = start
            }
        }
        node.physicsBody?.isDynamic = true
        e.get(InputComponent.self)?.dragging = false
        drag = nil
    }
}

final class RenderSystem: System {
    private let world: World
    init(world: World) { self.world = world }
    func update(dt: TimeInterval) {
        for e in world.entities(with: [RenderComponent.self, TransformComponent.self]) {
            let t = e.get(TransformComponent.self)!
            e.get(RenderComponent.self)!.node.position = t.pos
        }
    }
}
