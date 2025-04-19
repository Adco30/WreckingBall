import SpriteKit

final class RenderComponent: Component {
    let node: SKNode
    init(node: SKNode) { self.node = node }
}

final class TransformComponent: Component {
    var pos: CGPoint
    var rot: CGFloat = 0
    init(_ p: CGPoint) { pos = p }
}

final class PhysicsComponent: Component {
    var body: SKPhysicsBody?
}

final class InputComponent: Component {
    var draggable = false
    var dragging = false
}

final class BallComponent: Component {}
final class BlockComponent: Component {}
