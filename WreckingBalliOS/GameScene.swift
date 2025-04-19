import SpriteKit

final class GameScene: SKScene, SKPhysicsContactDelegate {
    private let params: PhysicsParameters
    let world: World
    private let coord: Coordinate
    private var slingshotNode: SKNode?
    private var bands: [SKShapeNode] = []
    private var draggingBall: SKShapeNode?
    private var ballStartPos: CGPoint?
    var slingshotHeight: CGFloat { CGFloat(params.slingHeight) }
    var groundHeight: CGFloat { coord.groundHeight }

    init(size: CGSize, params: PhysicsParameters, world: World) {
        self.params = params
        self.world = world
        self.coord = Coordinate(screen: size)
        super.init(size: size)
        scaleMode = .resizeFill
    }

    required init?(coder: NSCoder) { fatalError() }

    override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector(dx: 0, dy: -params.gravity)
        physicsWorld.contactDelegate = self
        backgroundColor = .black
        addChild(coord.groundNode)
        createSlingshot()
    }

    override func didChangeSize(_ oldSize: CGSize) {
        coord.resize(size: size)
    }

    func createSlingshot() {
        slingshotNode?.removeFromParent()
        let basePos = coord.slingshotPos(xp: CGFloat(params.slingshotX))
        let sling = SKNode()
        sling.position = basePos
        let left = SKSpriteNode(color: .brown, size: CGSize(width: 10, height: slingshotHeight))
        left.position = CGPoint(x: -25, y: slingshotHeight / 2)
        let right = SKSpriteNode(color: .brown, size: CGSize(width: 10, height: slingshotHeight))
        right.position = CGPoint(x: 25, y: slingshotHeight / 2)
        let base = SKSpriteNode(color: .darkGray, size: CGSize(width: 60, height: 10))
        base.position = CGPoint(x: 0, y: 5)
        sling.addChild(left)
        sling.addChild(right)
        sling.addChild(base)
        bands = [SKShapeNode(), SKShapeNode()]
        for b in bands {
            b.strokeColor = .red
            b.lineWidth = 4
            sling.addChild(b)
        }
        addChild(sling)
        slingshotNode = sling
    }

    func slingshotTop() -> CGPoint {
        guard let s = slingshotNode else { return .zero }
        return CGPoint(x: s.position.x, y: coord.groundHeight + slingshotHeight)
    }

    func stackBase(xp: CGFloat) -> CGPoint {
        coord.stackBase(xp: xp)
    }

    func updateBands(ball: CGPoint) {
        guard bands.count == 2, let sling = slingshotNode else { return }
        let local = sling.convert(ball, from: self)
        let a = CGPoint(x: -25, y: slingshotHeight)
        let b = CGPoint(x: 25, y: slingshotHeight)
        let p1 = CGMutablePath(); p1.move(to: a); p1.addLine(to: local); bands[0].path = p1
        let p2 = CGMutablePath(); p2.move(to: b); p2.addLine(to: local); bands[1].path = p2
    }

    func resetBands() {
        bands.forEach { $0.path = nil }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let t = touches.first else { return }
        let loc = t.location(in: self)
        if let ball = childNode(withName: "ball") as? SKShapeNode, ball.contains(loc) {
            draggingBall = ball
            ballStartPos = ball.position
            ball.physicsBody?.isDynamic = false
            updateBands(ball: loc)
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let t = touches.first, let ball = draggingBall else { return }
        let loc = t.location(in: self)
        ball.position = loc
        updateBands(ball: loc)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let t = touches.first, let ball = draggingBall, let start = ballStartPos else { return }
        let loc = t.location(in: self)
        let v = CGVector(dx: start.x - loc.x, dy: start.y - loc.y)
        if v.length() > 10 {
            ball.physicsBody?.isDynamic = true
            let imp = CGVector(dx: v.dx * CGFloat(params.impulse)*2.5, dy: v.dy * CGFloat(params.impulse)*3.5)
            ball.physicsBody?.applyImpulse(imp)
        } else {
            ball.position = start
        }
        resetBands()
        draggingBall = nil
        ballStartPos = nil
    }
}
