import CoreGraphics

extension CGVector {
    func length() -> CGFloat { sqrt(dx*dx + dy*dy) }
}
