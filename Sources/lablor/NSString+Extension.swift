import AppKit
import Foundation

extension NSString {

    func drawWithBase(point: NSPoint, andAngle angle: CGFloat, andFont font: NSFont) {
        let textAttributes = [NSAttributedStringKey.font: font]
        let textSize = size(withAttributes: textAttributes)
        print("Draw \(self) with with size: \(textSize)")

        guard let context = NSGraphicsContext.current?.cgContext else {
            fatalError("No `current` context of `NSGraphicsContext`")
        }

        let transform = CGAffineTransform.identity.translatedBy(x: point.x, y: point.y).rotated(by: angle)
        context.concatenate(transform)

        draw(at: NSPoint(x: -1 * textSize.width / 2,
                         y: -1 * textSize.height / 2),
             withAttributes: textAttributes)

        context.concatenate(transform.inverted())
    }

}
