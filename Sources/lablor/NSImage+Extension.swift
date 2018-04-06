import AppKit

extension NSImage {

    func saveTo(path: String) {
        guard let cgImage = cgImage(forProposedRect: nil, context: nil, hints: nil) else {
            fatalError("Couldn't create `cgImage` from `self`")
        }

        let bitmapImageRep = NSBitmapImageRep(cgImage: cgImage)
        bitmapImageRep.size = size

        guard let data = bitmapImageRep.representation(using: .png, properties: [:]) else {
            fatalError("Couldn't create `NSData` from `NSBitmapImageRep`")
        }

        do {
            try data.write(to: URL(fileURLWithPath: path))
        } catch {
            fatalError(error.localizedDescription)
        }
    }

}
