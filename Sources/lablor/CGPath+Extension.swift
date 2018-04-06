import CoreGraphics

extension CGPath {

    static func pathFor(badge: BadgeInput, inCanvas canvas: CGRect) -> CGPath {
        let mutablePath = CGMutablePath()

        let distance = badge.distance.value(forRect: canvas)
        let height = badge.height.value(forRect: canvas)

        let points: [CGPoint]
        switch badge.position {
        case .topRight:
            points = [
                CGPoint(x: canvas.maxX - distance, y: canvas.maxY),
                CGPoint(x: canvas.maxX - distance - height, y: canvas.maxY),
                CGPoint(x: canvas.maxX - distance - height, y: canvas.maxY),
                CGPoint(x: canvas.maxX, y: canvas.maxY - distance - height),
                CGPoint(x: canvas.maxX, y: canvas.maxY - distance)
            ]
        case .topLeft:
            points = [
                CGPoint(x: 0, y: canvas.maxY - distance),
                CGPoint(x: 0, y: canvas.maxY - distance - height),
                CGPoint(x: distance + height, y: canvas.maxY),
                CGPoint(x: distance, y: canvas.maxY),
                CGPoint(x: 0, y: canvas.maxY - distance),
            ]
        case .bottomRight:
            points = [
                CGPoint(x: canvas.maxX - distance, y: 0),
                CGPoint(x: canvas.maxX - distance - height, y: 0),
                CGPoint(x: canvas.maxX, y: distance + height),
                CGPoint(x: canvas.maxX, y: distance),
                CGPoint(x: canvas.maxX - distance, y: 0),
            ]
        case .bottomLeft:
            points = [
                CGPoint(x: distance, y: 0),
                CGPoint(x: distance + height, y: 0),
                CGPoint(x: 0, y: distance + height),
                CGPoint(x: 0, y: distance),
                CGPoint(x: distance, y: 0),
            ]
        }

        points.enumerated().forEach {
            if $0.offset == 0 {
                mutablePath.move(to: $0.element)
                print("Move to: \($0.element)")
            } else {
                mutablePath.addLine(to: $0.element)
                print("Line to: \($0.element)")
            }
        }

        mutablePath.closeSubpath()
        
        return mutablePath
    }

}
