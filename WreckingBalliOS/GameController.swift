import SpriteKit
import Combine

final class GameController: ObservableObject {
    let world = World()
    private let params: PhysicsParameters
    private weak var scene: GameScene?
    private var cancellables = Set<AnyCancellable>()
    private var ball: Entity?
    private var blocks: [Entity] = []
    private var returnScheduled = false

    init(scene: GameScene, params: PhysicsParameters){
        self.scene = scene
        self.params = params
        setup()
    }

    private func setup(){
        let renderSys = RenderSystem(world: world)
        scene.map { world.addSystem(InputSystem(scene: $0, world: world)) }
        world.addSystem(renderSys)

        params.$slingshotX.sink    { [weak self] _ in self?.updateSlingshot() }.store(in:&cancellables)
        params.$stackX.sink        { [weak self] _ in self?.updateBlocks()   }.store(in:&cancellables)
        params.$slingHeight.sink   { [weak self] _ in self?.updateSlingshot() }.store(in:&cancellables)

        NotificationCenter.default
            .publisher(for: .restartGame)
            .sink { [weak self] _ in
                self?.updateSlingshot()
            }
            .store(in: &cancellables)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.updateSlingshot()
            self?.updateBlocks()
        }
    }

    private func createBall(){
        guard let s = scene else { return }
        let e = Entity()
        let node = SKShapeNode(circleOfRadius: 20)
        node.name = "ball"
        node.fillColor = .gray
        node.strokeColor = .black
        let body = SKPhysicsBody(circleOfRadius: 20)
        body.isDynamic = false
        body.mass = params.ballMass
        body.restitution = params.ballRestitution
        body.friction = params.ballFriction
        node.physicsBody = body
        node.position = s.slingshotTop()
        e.add(RenderComponent(node: node))
        e.add(TransformComponent(node.position))
        let input = InputComponent()
        input.draggable = true
        e.add(input)
        e.add(PhysicsComponent())
        e.add(BallComponent())
        world.add(e)
        s.addChild(node)
        ball = e
    }

    private func createBlocks(){
        guard let s = scene else { return }
        blocks.forEach {
            $0.get(RenderComponent.self)?.node.removeFromParent()
            world.send(.restarted)
        }
        blocks.removeAll()
        let base = s.size.width * params.stackX
        let size: CGFloat = 40
        let positions = [
            CGPoint(x: base - size,    y: s.slingshotTop().y),
            CGPoint(x: base,           y: s.slingshotTop().y),
            CGPoint(x: base + size,    y: s.slingshotTop().y),
            CGPoint(x: base - size/2,  y: s.slingshotTop().y + size),
            CGPoint(x: base + size/2,  y: s.slingshotTop().y + size),
            CGPoint(x: base,           y: s.slingshotTop().y + size*2)
        ]
        for p in positions {
            let e = Entity()
            let node = SKSpriteNode(color: .brown, size: CGSize(width: size, height: size))
            node.position = p
            let body = SKPhysicsBody(rectangleOf: node.size)
            body.mass = params.blockMass
            body.restitution = params.blockRestitution
            body.friction = params.blockFriction
            node.physicsBody = body
            e.add(RenderComponent(node: node))
            e.add(TransformComponent(p))
            e.add(PhysicsComponent())
            e.add(BlockComponent())
            world.add(e)
            s.addChild(node)
            blocks.append(e)
        }
    }

    private func updateSlingshot(){
        scene?.createSlingshot()
        guard let node = ball?.get(RenderComponent.self)?.node else {
            createBall()
            return
        }
        let top = scene?.slingshotTop() ?? .zero
        node.physicsBody?.velocity = .zero
        node.physicsBody?.isDynamic = false
        node.position = top
        ball?.get(TransformComponent.self)?.pos = top
        returnScheduled = false
    }

    private func updateBlocks(){
        createBlocks()
    }

    func tick(dt: TimeInterval){
        world.update(dt: dt)
        guard
            let s = scene,
            let node = ball?.get(RenderComponent.self)?.node,
            let body = node.physicsBody,
            body.isDynamic,
            !returnScheduled,
            node.position.y <= s.groundHeight + 1
        else { return }
        returnScheduled = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self, let s = self.scene, let node = self.ball?.get(RenderComponent.self)?.node else { return }
            node.physicsBody?.velocity = .zero
            node.physicsBody?.isDynamic = false
            let top = s.slingshotTop()
            node.position = top
            self.ball?.get(TransformComponent.self)?.pos = top
            s.resetBands()
        }
    }
}
