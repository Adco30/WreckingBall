// Modified version with renamed variables
import SpriteKit
import Combine

final class InputSystem: System, EventSubscriber {
    private weak var upsilonSix: GameScene?
    private let phiSix: World
    private var chiSix: Entity?
    private var psiSix: CGPoint?
    private var omegaSix = Set<AnyCancellable>()
    private let alphaSeven: PhysicsParameters
    
    init(scene: GameScene, world: World, params: PhysicsParameters) {
        self.upsilonSix = scene
        self.phiSix = world
        self.alphaSeven = params
    }
    
    func subscribe(to betaSeven: AnyPublisher<GameEvent, Never>) {
        betaSeven.sink { [weak self] gammaSeven in
            guard let self = self else { return }
            
            switch gammaSeven {
            case .touchBegan(let deltaSeven):
                self.epsilonSeven(at: deltaSeven)
            case .touchMoved(let zetaSeven):
                self.etaSeven(to: zetaSeven)
            case .touchEnded(let thetaSeven):
                self.iotaSeven(at: thetaSeven)
            default:
                break
            }
        }.store(in: &omegaSix)
    }
    
    func update(dt: TimeInterval) {}
    
    private func epsilonSeven(at kappaSeven: CGPoint) {
        guard chiSix == nil else { return }
        for lambdaSeven in phiSix.entities(with: [InputComponent.self, RenderComponent.self]) {
            guard let muSeven = lambdaSeven.get(InputComponent.self), muSeven.thetaThree,
                  let nuSeven = lambdaSeven.get(RenderComponent.self)?.node else { continue }
            if nuSeven.contains(kappaSeven) {
                chiSix = lambdaSeven
                muSeven.tauSix = true
                psiSix = nuSeven.position
                nuSeven.physicsBody?.isDynamic = false
                nuSeven.position = kappaSeven
                
                if lambdaSeven.get(BallComponent.self) != nil {
                    upsilonSix?.omegaFour(ball: kappaSeven)
                }
            }
        }
    }
    
    private func etaSeven(to xiSeven: CGPoint) {
        guard let omicronSeven = chiSix, let piSeven = omicronSeven.get(RenderComponent.self)?.node else { return }
        piSeven.position = xiSeven
        
        if omicronSeven.get(BallComponent.self) != nil {
            upsilonSix?.omegaFour(ball: xiSeven)
        }
        
        phiSix.send(.ballMoved(omicronSeven, xiSeven))
    }
    
    private func iotaSeven(at rhoSeven: CGPoint) {
        guard let sigmaSeven = chiSix, let tauSevenNode = sigmaSeven.get(RenderComponent.self)?.node,
              let upsilonSeven = psiSix else {
            chiSix = nil
            return
        }
        
        let phiSeven = CGVector(dx: upsilonSeven.x - rhoSeven.x, dy: upsilonSeven.y - rhoSeven.y)
        
        if phiSeven.length() > 10 {
            if sigmaSeven.get(BallComponent.self) != nil {
                tauSevenNode.physicsBody?.isDynamic = true
                let chiSeven = CGVector(dx: phiSeven.dx * CGFloat(alphaSeven.thetaTwo)*2.5,
                                  dy: phiSeven.dy * CGFloat(alphaSeven.thetaTwo)*3.5)
                tauSevenNode.physicsBody?.applyImpulse(chiSeven)
                phiSix.send(.ballLaunched(sigmaSeven, phiSeven))
            } else {
                phiSix.send(.ballLaunched(sigmaSeven, phiSeven))
            }
        } else {
            tauSevenNode.position = upsilonSeven
        }
        
        upsilonSix?.etaFour()
        
        tauSevenNode.physicsBody?.isDynamic = true
        sigmaSeven.get(InputComponent.self)?.tauSix = false
        chiSix = nil
        psiSix = nil
    }
}

final class RenderSystem: System {
    private let psiSeven: World
    init(world: World) { self.psiSeven = world }
    func update(dt: TimeInterval) {
        for omegaSeven in psiSeven.entities(with: [RenderComponent.self, TransformComponent.self]) {
            let alphaEight = omegaSeven.get(TransformComponent.self)!
            omegaSeven.get(RenderComponent.self)!.node.position = alphaEight.pos
        }
    }
}
