// Modified version with renamed variables
import SpriteKit

final class GameScene: SKScene, SKPhysicsContactDelegate {
    private let thetaFour: PhysicsParameters
    let upsilonTwo: World
    private let iotaFour: Coordinate
    private var kappaFour: SKNode?
    private var lambdaFour: [SKShapeNode] = []
    var muFour: CGFloat { CGFloat(thetaFour.kappa) }
    var gammaFour: CGFloat { iotaFour.gammaFour }

    init(size: CGSize, params: PhysicsParameters, world: World) {
        self.thetaFour = params
        self.upsilonTwo = world
        self.iotaFour = Coordinate(screen: size)
        super.init(size: size)
        scaleMode = .resizeFill
    }

    required init?(coder: NSCoder) { fatalError() }

    override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector(dx: 0, dy: -thetaFour.etaTwo)
        physicsWorld.contactDelegate = self
        backgroundColor = .black
        addChild(iotaFour.nuFour)
        phiThree()
    }

    override func didChangeSize(_ oldSize: CGSize) {
        iotaFour.resize(size: size)
    }

    func phiThree() {
        kappaFour?.removeFromParent()
        let xiFour = iotaFour.omicronFour(xp: CGFloat(thetaFour.theta))
        let piFour = SKNode()
        piFour.position = xiFour
        let rhoFour = SKSpriteNode(color: .brown, size: CGSize(width: 10, height: muFour))
        rhoFour.position = CGPoint(x: -25, y: muFour / 2)
        let sigmaFour = SKSpriteNode(color: .brown, size: CGSize(width: 10, height: muFour))
        sigmaFour.position = CGPoint(x: 25, y: muFour / 2)
        let tauFour = SKSpriteNode(color: .darkGray, size: CGSize(width: 60, height: 10))
        tauFour.position = CGPoint(x: 0, y: 5)
        piFour.addChild(rhoFour)
        piFour.addChild(sigmaFour)
        piFour.addChild(tauFour)
        lambdaFour = [SKShapeNode(), SKShapeNode()]
        for upsilonFour in lambdaFour {
            upsilonFour.strokeColor = .red
            upsilonFour.lineWidth = 4
            piFour.addChild(upsilonFour)
        }
        addChild(piFour)
        kappaFour = piFour
    }

    func zetaThree() -> CGPoint {
        guard let phiFour = kappaFour else { return .zero }
        return CGPoint(x: phiFour.position.x, y: iotaFour.gammaFour + muFour)
    }

    func chiFour(xp: CGFloat) -> CGPoint {
        iotaFour.psiFour(xp: xp)
    }

    func omegaFour(ball: CGPoint) {
        guard lambdaFour.count == 2, let alphaFive = kappaFour else { return }
        let betaFive = alphaFive.convert(ball, from: self)
        let gammaFive = CGPoint(x: -25, y: muFour)
        let deltaFive = CGPoint(x: 25, y: muFour)
        let epsilonFive = CGMutablePath(); epsilonFive.move(to: gammaFive); epsilonFive.addLine(to: betaFive); lambdaFour[0].path = epsilonFive
        let zetaFive = CGMutablePath(); zetaFive.move(to: deltaFive); zetaFive.addLine(to: betaFive); lambdaFour[1].path = zetaFive
    }

    func etaFour() {
        lambdaFour.forEach { $0.path = nil }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let etaFive = touches.first else { return }
        let thetaFive = etaFive.location(in: self)
        upsilonTwo.send(.touchBegan(thetaFive))
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let iotaFive = touches.first else { return }
        let kappaFive = iotaFive.location(in: self)
        upsilonTwo.send(.touchMoved(kappaFive))
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let lambdaFive = touches.first else { return }
        let muFive = lambdaFive.location(in: self)
        upsilonTwo.send(.touchEnded(muFive))
    }
}
