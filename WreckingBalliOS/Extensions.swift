// Modified version with renamed variables
import CoreGraphics

extension CGVector {
    func length() -> CGFloat { sqrt(dx*dx + dy*dy) }
}
