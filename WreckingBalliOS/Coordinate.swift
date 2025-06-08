// Modified version with renamed variables
import SpriteKit


final class Coordinate {
    private(set) var nuFive: CGSize
    let gammaFour: CGFloat = 50
    let nuFour: SKSpriteNode

    init(screen: CGSize) {
        self.nuFive = screen
        nuFour = SKSpriteNode(color: .green, size: CGSize(width: screen.width, height: gammaFour))
        nuFour.position = CGPoint(x: screen.width / 2, y: gammaFour / 2)
        nuFour.physicsBody = SKPhysicsBody(rectangleOf: nuFour.size)
        nuFour.physicsBody?.isDynamic = false
    }

    func resize(size: CGSize) {
        nuFive = size
        nuFour.size = CGSize(width: nuFive.width, height: gammaFour)
        nuFour.position = CGPoint(x: nuFive.width / 2, y: gammaFour / 2)
        nuFour.physicsBody = SKPhysicsBody(rectangleOf: nuFour.size)
        nuFour.physicsBody?.isDynamic = false
    }

    func omicronFour(xp: CGFloat) -> CGPoint {
        let xiFive: CGFloat = 30
        let omicronFive = min(max(xp * nuFive.width, xiFive), nuFive.width - xiFive)
        return CGPoint(x: omicronFive, y: gammaFour)
    }

    func psiFour(xp: CGFloat) -> CGPoint {
        let piFive: CGFloat = 60
        let rhoFive = min(max(xp * nuFive.width, piFive), nuFive.width - piFive)
        return CGPoint(x: rhoFive, y: gammaFour)
    }
}
