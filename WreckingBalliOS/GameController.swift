// Modified version with renamed variables
import SpriteKit
import Combine

final class GameController: ObservableObject {
    private let nuTwo: World
    private let xiTwo: PhysicsParameters
    unowned let omicronTwo: GameScene?
    private var piTwo = Set<AnyCancellable>()
    private var rhoTwo: Entity?
    private var sigmaTwo: [Entity] = []
    private var tauTwo = false

    init(scene: GameScene, params: PhysicsParameters){
        self.omicronTwo = scene
        self.xiTwo = params
        self.nuTwo = scene.upsilonTwo
        phiTwo()
    }

    private func phiTwo(){
        let chiTwo = RenderSystem(world: nuTwo)
        omicronTwo.map { nuTwo.addSystem(InputSystem(scene: $0, world: nuTwo, params: xiTwo)) }
        nuTwo.addSystem(chiTwo)

        xiTwo.$theta.sink    { [weak self] _ in self?.psiTwo() }.store(in:&piTwo)
        xiTwo.$iota.sink        { [weak self] _ in self?.omegaTwo()   }.store(in:&piTwo)
        xiTwo.$kappa.sink   { [weak self] _ in self?.psiTwo() }.store(in:&piTwo)

        NotificationCenter.default
            .publisher(for: .restartGame)
            .sink { [weak self] _ in
                self?.psiTwo()
            }
            .store(in: &piTwo)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.psiTwo()
            self?.omegaTwo()
        }
    }

    private func alphaThree(){
        guard let betaThree = omicronTwo else { return }
        let gammaThree = Entity()
        let deltaThree = SKShapeNode(circleOfRadius: 20)
        deltaThree.name = "ball"
        deltaThree.fillColor = .gray
        deltaThree.strokeColor = .black
        let epsilonThree = SKPhysicsBody(circleOfRadius: 20)
        epsilonThree.isDynamic = false
        epsilonThree.mass = xiTwo.omega
        epsilonThree.restitution = xiTwo.alphaTwo
        epsilonThree.friction = xiTwo.gammaTwo
        deltaThree.physicsBody = epsilonThree
        deltaThree.position = betaThree.zetaThree()
        gammaThree.add(RenderComponent(node: deltaThree))
        gammaThree.add(TransformComponent(deltaThree.position))
        let etaThree = InputComponent()
        etaThree.thetaThree = true
        gammaThree.add(etaThree)
        gammaThree.add(PhysicsComponent())
        gammaThree.add(BallComponent())
        nuTwo.add(gammaThree)
        betaThree.addChild(deltaThree)
        rhoTwo = gammaThree
    }

    private func iotaThree(at kappaThree: CGPoint) -> Entity {
        let lambdaThree = Entity()
        let muThree = SKSpriteNode(color: .brown, size: CGSize(width: 40, height: 40))
        muThree.position = kappaThree
        let nuThree = SKPhysicsBody(rectangleOf: muThree.size)
        nuThree.mass        = xiTwo.deltaTwo
        nuThree.restitution = xiTwo.epsilonTwo
        nuThree.friction    = xiTwo.zetaTwo
        muThree.physicsBody = nuThree

        lambdaThree.add(RenderComponent(node: muThree))
        lambdaThree.add(TransformComponent(kappaThree))
        lambdaThree.add(PhysicsComponent())
        lambdaThree.add(BlockComponent())

        omicronTwo?.addChild(muThree)
        return lambdaThree
    }

    private func xiThree() {
        guard let omicronThree = omicronTwo else { return }

        sigmaTwo.forEach { $0.get(RenderComponent.self)?.node.removeFromParent() }
        nuTwo.send(.restarted)
        sigmaTwo.removeAll()

        let piThree   = omicronThree.size.width * xiTwo.iota
        let rhoThree: CGFloat = 40
        let sigmaTHree = [
            CGPoint(x: piThree - rhoThree,    y: omicronThree.zetaThree().y),
            CGPoint(x: piThree,           y: omicronThree.zetaThree().y),
            CGPoint(x: piThree + rhoThree,    y: omicronThree.zetaThree().y),
            CGPoint(x: piThree - rhoThree/2,  y: omicronThree.zetaThree().y + rhoThree),
            CGPoint(x: piThree + rhoThree/2,  y: omicronThree.zetaThree().y + rhoThree),
            CGPoint(x: piThree,           y: omicronThree.zetaThree().y + rhoThree * 2)
        ]

        sigmaTwo = sigmaTHree.map { tauThree in
            let upsilonThree = iotaThree(at: tauThree)
            nuTwo.add(upsilonThree)
            return upsilonThree
        }
    }

    private func psiTwo(){
        omicronTwo?.phiThree()
        guard let chiThree = rhoTwo?.get(RenderComponent.self)?.node else {
            alphaThree()
            return
        }
        let psiThree = omicronTwo?.zetaThree() ?? .zero
        chiThree.physicsBody?.velocity = .zero
        chiThree.physicsBody?.isDynamic = false
        chiThree.position = psiThree
        rhoTwo?.get(TransformComponent.self)?.pos = psiThree
        tauTwo = false
    }

    private func omegaTwo(){
        xiThree()
    }

    func tick(dt: TimeInterval){
        nuTwo.update(dt: dt)
        guard
            let omegaThree = omicronTwo,
            let alphaFour = rhoTwo?.get(RenderComponent.self)?.node,
            let betaFour = alphaFour.physicsBody,
            betaFour.isDynamic,
            !tauTwo,
            alphaFour.position.y <= omegaThree.gammaFour + 1
        else { return }
        tauTwo = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self, let deltaFour = self.omicronTwo, let epsilonFour = self.rhoTwo?.get(RenderComponent.self)?.node else { return }
            epsilonFour.physicsBody?.velocity = .zero
            epsilonFour.physicsBody?.isDynamic = false
            let zetaFour = deltaFour.zetaThree()
            epsilonFour.position = zetaFour
            self.rhoTwo?.get(TransformComponent.self)?.pos = zetaFour
            deltaFour.etaFour()
        }
    }
}
