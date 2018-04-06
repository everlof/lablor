import AppKit
import Foundation

extension CGContext {

    private struct AssociatedKeys {
        static var scaleKey = "CGContext_scale"
    }

    /// This is used to indicate @1x, @2x and @3x
    var scale: CGFloat {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.scaleKey) as? CGFloat ?? 1.0
        }
        set {
            scaleBy(x: scale, y: scale)
            objc_setAssociatedObject(self, &AssociatedKeys.scaleKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }

    func exportTo(path: String) {
        guard let cgImage = makeImage() else {
            fatalError("Can't create `cgImage` from \(self)")
        }

        NSImage(cgImage: cgImage, size: .zero).saveTo(path: path)
        print("`CGContext` exported => `\(path)`")
    }

    static func use(scale: CGFloat = 1.0, size: CGSize, closure: (CGContext, CGRect) -> Void) {
        let image = NSImage(size: size)
        image.lockFocus()

        guard let ctx = NSGraphicsContext.current?.cgContext else {
            fatalError("Can't get context")
        }

        ctx.scale = scale
        closure(ctx, CGRect(origin: .zero, size: size))
        image.unlockFocus()

        // ctx.setAllowsAntialiasing(true)
        // ctx.setAllowsFontSmoothing(true)
        // ctx.setAllowsFontSubpixelPositioning(true)
        // ctx.setAllowsFontSubpixelQuantization(true)
    }

    func drawText(_ string: String, withBase base: NSPoint, andAngle angle: CGFloat, andFont font: NSFont) {
        (string as NSString).drawWithBase(point: base, andAngle: angle, andFont: font)
    }

    func fill(size: CGSize, withCenter center: CGPoint, andAngle angle: CGFloat) {
        let rect = CGRect(origin: CGPoint(x: -size.width / 2, y: -size.height / 2), size: size)
        saveGState()
        concatenate(
            CGAffineTransform
                .identity
                .translatedBy(x: center.x, y: center.y)
                .rotated(by: angle))
        setFillColor(NSColor.red.withAlphaComponent(0.5).cgColor)
        fill(rect)
        restoreGState()
    }

}
