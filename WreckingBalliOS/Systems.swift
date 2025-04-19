import SpriteKit
import Combine

final class InputSystem: System, EventSubscriber {
    private weak var scene: GameScene?
    private let world: World
    private var drag: Entity?
    private var ballStartPos: CGPoint?
    private var cancellables = Set<AnyCancellable>()
    private let params: PhysicsParameters
    
    init(scene: GameScene, world: World, params: PhysicsParameters) {
        self.scene = scene
        self.world = world
        self.params = params
    }
    
    func subscribe(to events: AnyPublisher<GameEvent, Never>) {
        events.sink { [weak self] event in
            guard let self = self else { return }
            
            switch event {
            case .touchBegan(let point):
                self.handleTouchBegan(at: point)
            case .touchMoved(let point):
                self.handleTouchMoved(to: point)
            case .touchEnded(let point):
                self.handleTouchEnded(at: point)
            default:
                break
            }
        }.store(in: &cancellables)
    }
    
    func update(dt: TimeInterval) {}
    
    private func handleTouchBegan(at p: CGPoint) {
        guard drag == nil else { return }
        for e in world.entities(with: [InputComponent.self, RenderComponent.self]) {
            guard let input = e.get(InputComponent.self), input.draggable,
                  let node = e.get(RenderComponent.self)?.node else { continue }
            if node.contains(p) {
                drag = e
                input.dragging = true
                ballStartPos = node.position
                node.physicsBody?.isDynamic = false
                node.position = p
                
                if e.get(BallComponent.self) != nil {
                    scene?.updateBands(ball: p)
                }
            }
        }
    }
    
    private func handleTouchMoved(to p: CGPoint) {
        guard let e = drag, let node = e.get(RenderComponent.self)?.node else { return }
        node.position = p
        
        if e.get(BallComponent.self) != nil {
            scene?.updateBands(ball: p)
        }
        
        world.send(.ballMoved(e, p))
    }
    
    private func handleTouchEnded(at p: CGPoint) {
        guard let e = drag, let node = e.get(RenderComponent.self)?.node,
              let start = ballStartPos else {
            drag = nil
            return
        }
        
        let v = CGVector(dx: start.x - p.x, dy: start.y - p.y)
        
        if v.length() > 10 {
            if e.get(BallComponent.self) != nil {
                node.physicsBody?.isDynamic = true
                let imp = CGVector(dx: v.dx * CGFloat(params.impulse)*2.5,
                                  dy: v.dy * CGFloat(params.impulse)*3.5)
                node.physicsBody?.applyImpulse(imp)
                world.send(.ballLaunched(e, v))
            } else {
                world.send(.ballLaunched(e, v))
            }
        } else {
            node.position = start
        }
        
        scene?.resetBands()
        
        node.physicsBody?.isDynamic = true
        e.get(InputComponent.self)?.dragging = false
        drag = nil
        ballStartPos = nil
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
