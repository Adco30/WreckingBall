import SpriteKit


final class Coordinate {
    private(set) var screen: CGSize
    let groundHeight: CGFloat = 50
    let groundNode: SKSpriteNode

    init(screen: CGSize) {
        self.screen = screen
        groundNode = SKSpriteNode(color: .green, size: CGSize(width: screen.width, height: groundHeight))
        groundNode.position = CGPoint(x: screen.width / 2, y: groundHeight / 2)
        groundNode.physicsBody = SKPhysicsBody(rectangleOf: groundNode.size)
        groundNode.physicsBody?.isDynamic = false
    }

    func resize(size: CGSize) {
        screen = size
        groundNode.size = CGSize(width: screen.width, height: groundHeight)
        groundNode.position = CGPoint(x: screen.width / 2, y: groundHeight / 2)
        groundNode.physicsBody = SKPhysicsBody(rectangleOf: groundNode.size)
        groundNode.physicsBody?.isDynamic = false
    }

    func slingshotPos(xp: CGFloat) -> CGPoint {
        let halfWidth: CGFloat = 30
        let clampedX = min(max(xp * screen.width, halfWidth), screen.width - halfWidth)
        return CGPoint(x: clampedX, y: groundHeight)
    }

    func stackBase(xp: CGFloat) -> CGPoint {
        let halfWidth: CGFloat = 60
        let clampedX = min(max(xp * screen.width, halfWidth), screen.width - halfWidth)
        return CGPoint(x: clampedX, y: groundHeight)
    }
}
