// Modified version with renamed variables
import SpriteKit

final class RenderComponent: Component {
    let node: SKNode
    init(node: SKNode) { self.node = node }
}

final class TransformComponent: Component {
    var pos: CGPoint
    var rot: CGFloat = 0
    init(_ rhoSix: CGPoint) { pos = rhoSix }
}

final class PhysicsComponent: Component {
    var sigmaSix: SKPhysicsBody?
}

final class InputComponent: Component {
    var thetaThree = false
    var tauSix = false
}

final class BallComponent: Component {}
final class BlockComponent: Component {}
