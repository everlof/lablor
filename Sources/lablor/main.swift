import Argumentable
import AppKit
import CoreText
import Foundation
import SwiftyBeaver

let log = SwiftyBeaver.self
let console = ConsoleDestination()  // log to Xcode Console
log.addDestination(console)
log.info("HELLO")

L.enable()

let help = """
usage:
    lablor [options] [<in-folder> | <in-file>] [<out-folder> | <out-file>]
"""

guard let imagePath = CommandLine.arguments.last else {
    print("Coulnd't extract ")
    exit(1)
}

guard let nsImage = NSImage(byReferencingFile: imagePath) else {
    print("Coulnd't open image at `\(imagePath)`")
    exit(1)
}

print(BadgeInput.Position.help)
print(BadgeInput.Height.help)
print(BadgeInput.Distance.help)


CGContext.use(scale: 2.0, size: nsImage.size) { context, canvas in
    var args = CommandLine.arguments
    let distance = BadgeInput.Distance.from(arg: &args)
    let position = BadgeInput.Position.from(arg: &args)
    let height = BadgeInput.Height.from(arg: &args)

    print(distance)
    print(position)
    print(height)

    let badge = BadgeInput(height: height, distance: distance, position: position)
    context.draw(nsImage.cgImage(forProposedRect: nil, context: nil, hints: nil)!, in: canvas)
    context.addPath(CGPath.pathFor(badge: badge, inCanvas: canvas))
    context.setFillColor(NSColor.red.cgColor)
    context.fillPath()
    context.exportTo(path: "ina-badge.png")
}
