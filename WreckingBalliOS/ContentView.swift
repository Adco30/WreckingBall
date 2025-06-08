// Modified version with renamed variables
import SwiftUI
import SpriteKit

extension Notification.Name {
    static let restartGame = Notification.Name("restartGame")
}

struct ContentView: View {
    @EnvironmentObject var beta: ParametersStore
    @State private var gamma = true

    var body: some View {
        GeometryReader { delta in
            if delta.size.width > delta.size.height {
                HStack(spacing: 0) {
                    GameView(epsilon: beta.zeta)
                    if gamma {
                        ControlPanel(eta: beta.zeta)
                            .frame(width: 300)
                    }
                }
            } else {
                VStack(spacing: 0) {
                    GameView(epsilon: beta.zeta)
                    if gamma {
                        ControlPanel(eta: beta.zeta)
                            .frame(height: 300)
                    }
                }
            }
        }
        .overlay(
            HStack(spacing: 16) {
                Button {
                    gamma.toggle()
                } label: {
                    Image(systemName: gamma ? "sidebar.left" : "sidebar.right")
                        .font(.title2)
                }
                Button {
                    beta.zeta.theta  = 0.30
                    beta.zeta.iota      = 0.80
                    beta.zeta.kappa = 120
                    NotificationCenter.default.post(name: .restartGame, object: nil)
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.title2)
                }
            }
            .padding(),
            alignment: .topTrailing
        )
    }
}


struct GameView: UIViewRepresentable {
    let epsilon: PhysicsParameters
    static let lambda = World()
    
    func makeUIView(context: Context) -> SKView {
        let mu = SKView()
        let nu = GameScene(size: mu.bounds.size, params: epsilon, world: GameView.lambda)
        mu.presentScene(nu)
        let xi = GameController(scene: nu, params: epsilon)
        nu.userData = ["controller": xi]
        mu.showsFPS = true
        mu.showsNodeCount = true
        return mu
    }
    
    func updateUIView(_ omicron: SKView, context: Context) {
        if let pi = omicron.scene as? GameScene,
           let rho = pi.userData?["controller"] as? GameController {
            pi.didChangeSize(omicron.bounds.size)
            rho.tick(dt: 1/60)
        }
    }
}

struct ControlPanel: View {
    @ObservedObject var eta: PhysicsParameters
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Position").bold()
                sigma("Slingshot", tau: $eta.theta, upsilon: 0...1, phi: { chi($0) })
                sigma("Stack", tau: $eta.iota, upsilon: 0...1, phi: { chi($0) })
                sigma("Height", tau: $eta.kappa, upsilon: 50...200, phi: { psi($0) })
                Text("Ball").bold()
                sigma("Mass", tau: $eta.omega, upsilon: 1...20, phi: { psi($0) })
                sigma("Rest", tau: $eta.alphaTwo, upsilon: 0...1, phi: { betaTwo($0) })
                sigma("Friction", tau: $eta.gammaTwo, upsilon: 0...1, phi: { betaTwo($0) })
                Text("Block").bold()
                sigma("Mass", tau: $eta.deltaTwo, upsilon: 0.2...10, phi: { psi($0) })
                sigma("Rest", tau: $eta.epsilonTwo, upsilon: 0...1, phi: { betaTwo($0) })
                sigma("Friction", tau: $eta.zetaTwo, upsilon: 0...1, phi: { betaTwo($0) })
                Text("Physics").bold()
                sigma("Gravity", tau: $eta.etaTwo, upsilon: 0...20, phi: { psi($0) })
                sigma("Impulse", tau: $eta.thetaTwo, upsilon: 1...20, phi: { psi($0) })
            }.padding()
        }.background(Color(.systemBackground))
    }
    func sigma(_ iotaTwo: String, tau: Binding<Double>, upsilon: ClosedRange<Double>, phi: @escaping (Double) -> String) -> some View {
        HStack {
            Text(iotaTwo).frame(width: 90, alignment: .leading)
            Slider(value: tau, in: upsilon)
            Text(phi(tau.wrappedValue)).frame(width: 60, alignment: .trailing)
        }
    }
    func chi(_ kappaTwo: Double) -> String { String(format: "%.0f%%", kappaTwo * 100) }
    func psi(_ lambdaTwo: Double) -> String { String(format: "%.1f", lambdaTwo) }
    func betaTwo(_ muTwo: Double) -> String { String(format: "%.2f", muTwo) }
}
