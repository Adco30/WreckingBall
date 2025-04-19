import SwiftUI
import SpriteKit

extension Notification.Name {
    static let restartGame = Notification.Name("restartGame")
}

struct ContentView: View {
    @EnvironmentObject var store: ParametersStore
    @State private var panel = true

    var body: some View {
        GeometryReader { geo in
            if geo.size.width > geo.size.height {
                HStack(spacing: 0) {
                    GameView(params: store.params)
                    if panel {
                        ControlPanel(p: store.params)
                            .frame(width: 300)
                    }
                }
            } else {
                VStack(spacing: 0) {
                    GameView(params: store.params)
                    if panel {
                        ControlPanel(p: store.params)
                            .frame(height: 300)
                    }
                }
            }
        }
        .overlay(
            HStack(spacing: 16) {
                Button {
                    panel.toggle()
                } label: {
                    Image(systemName: panel ? "sidebar.left" : "sidebar.right")
                        .font(.title2)
                }
                Button {
                    store.params.slingshotX  = 0.30
                    store.params.stackX      = 0.80
                    store.params.slingHeight = 120
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
    let params: PhysicsParameters
    static let sharedWorld = World()
    
    func makeUIView(context: Context) -> SKView {
        let v = SKView()
        let scene = GameScene(size: v.bounds.size, params: params, world: GameView.sharedWorld)
        v.presentScene(scene)
        let controller = GameController(scene: scene, params: params)
        scene.userData = ["controller": controller]
        v.showsFPS = true
        v.showsNodeCount = true
        return v
    }
    
    func updateUIView(_ uiView: SKView, context: Context) {
        if let scene = uiView.scene as? GameScene,
           let controller = scene.userData?["controller"] as? GameController {
            scene.didChangeSize(uiView.bounds.size)
            controller.tick(dt: 1/60)
        }
    }
}

struct ControlPanel: View {
    @ObservedObject var p: PhysicsParameters
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Position").bold()
                slider("Slingshot", val: $p.slingshotX, range: 0...1, fmt: { pct($0) })
                slider("Stack", val: $p.stackX, range: 0...1, fmt: { pct($0) })
                slider("Height", val: $p.slingHeight, range: 50...200, fmt: { num($0) })
                Text("Ball").bold()
                slider("Mass", val: $p.ballMass, range: 1...20, fmt: { num($0) })
                slider("Rest", val: $p.ballRestitution, range: 0...1, fmt: { dec($0) })
                slider("Friction", val: $p.ballFriction, range: 0...1, fmt: { dec($0) })
                Text("Block").bold()
                slider("Mass", val: $p.blockMass, range: 0.2...10, fmt: { num($0) })
                slider("Rest", val: $p.blockRestitution, range: 0...1, fmt: { dec($0) })
                slider("Friction", val: $p.blockFriction, range: 0...1, fmt: { dec($0) })
                Text("Physics").bold()
                slider("Gravity", val: $p.gravity, range: 0...20, fmt: { num($0) })
                slider("Impulse", val: $p.impulse, range: 1...20, fmt: { num($0) })
            }.padding()
        }.background(Color(.systemBackground))
    }
    func slider(_ label: String, val: Binding<Double>, range: ClosedRange<Double>, fmt: @escaping (Double) -> String) -> some View {
        HStack {
            Text(label).frame(width: 90, alignment: .leading)
            Slider(value: val, in: range)
            Text(fmt(val.wrappedValue)).frame(width: 60, alignment: .trailing)
        }
    }
    func pct(_ v: Double) -> String { String(format: "%.0f%%", v * 100) }
    func num(_ v: Double) -> String { String(format: "%.1f", v) }
    func dec(_ v: Double) -> String { String(format: "%.2f", v) }
}
