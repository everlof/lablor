import Argumentable
import Foundation

struct BadgeInput {
    enum Position: String {
        case topRight      = "topright"
        case topLeft       = "topleft"
        case bottomLeft    = "bottomleft"
        case bottomRight   = "bottomright"

        static var all: [Position] = [.topRight, .topLeft, bottomLeft, .bottomRight]
    }

    enum Height {
        case absolute(CGFloat)
        case percent(CGFloat)


        func value(forRect rect: CGRect?) -> CGFloat {
            switch self {
            case .absolute(let value):
                return value
            case .percent(let percent):
                return (percent / 100) * max(rect!.width, rect!.height)
            }
        }
    }

    enum Distance {
        case absolute(CGFloat)
        case percent(CGFloat)

        func value(forRect rect: CGRect?) -> CGFloat {
            switch self {
            case .absolute(let value):
                return value
            case .percent(let percent):
                return (percent / 100) * max(rect!.width, rect!.height)
            }
        }
    }

    let height: Height
    
    let distance: Distance

    let position: Position

}

extension BadgeInput.Position: Argable {
    static func from(_: ParameterType) -> BadgeInput.Position? {
        <#code#>
    }

    static var longArg: String? {
        return "--position"
    }

    static var shortArg: String? {
        return "-p"
    }

    static var nbrArguments: Int {
        return 1
    }

    static func from(arg: inout [String]) -> BadgeInput.Position {
        if let index = arg.index(of: "-p") ?? arg.index(of: "-position") {
            if index + 1 < arg.count {
                var mutableArg = arg
                let value = arg[index + 1]
                mutableArg.remove(at: index + 1)
                mutableArg.remove(at: index)

                if let position = BadgeInput.Position(rawValue: value) {
                    return position
                } else {
                    print("Can't interpret \(value) as position.")
                    exit(1)
                }
            } else {
                print("Expected argument after `-p` or `--position`")
                exit(1)
            }
        }
        return `default`
    }

    static var `default`: BadgeInput.Position {
        return .topRight
    }

    static var help: String {
        return
            " -p, --position      Where to place the `badge`. Valid values: " +
                BadgeInput.Position.all.map { $0.rawValue }.quoted.textualCommaJoin + "."
    }

}

extension BadgeInput.Height: Argable {

    static func from(_: ParameterType) -> BadgeInput.Height? {
        <#code#>
    }

    static var longArg: String? {
        return "--height"
    }

    static var shortArg: String? {
        return "-h"
    }

    static var nbrArguments: Int {
        return 1
    }


    static func from(arg: inout [String]) -> BadgeInput.Height {
        if let index = arg.index(of: "-h") ?? arg.index(of: "--height") {
            if index + 1 < arg.count {
                var mutableArg = arg
                let value = arg[index + 1]
                mutableArg.remove(at: index + 1)
                mutableArg.remove(at: index)

                if let regularNumber = Formatters.numberFormatter.number(from: value) {
                    return .absolute(CGFloat(regularNumber.doubleValue))
                } else if let percentNumber = Formatters.percentFormatter.number(from: value) {
                    return .percent(CGFloat(percentNumber.doubleValue))
                } else {
                    print("Can't use \(value) as number or percent.")
                    exit(1)
                }
            } else {
                print("Expected argument after `-h` or `--height`")
                exit(1)
            }
        }
        return `default`
    }

    static var `default`: BadgeInput.Height {
        return .percent(30)
    }

    static var help: String {
        return
            " -h, --height        The height of the `badge`. Valid values are absolute and relative,\n" +
            "                     such as `65`, `72.1`, `50%` and `99%`."
    }

}

extension BadgeInput.Distance: Argable {
    static func from(_: ParameterType) -> BadgeInput.Distance? {
        <#code#>
    }

    static var longArg: String? {
        return "--distance"
    }

    static var shortArg: String? {
        return "-d"
    }

    static var nbrArguments: Int {
        return 1
    }

    static func from(arg: inout [String]) -> BadgeInput.Distance {
        if let index = arg.index(of: "-d") ?? arg.index(of: "--distance") {
            if index + 1 < arg.count {
                var mutableArg = arg
                let value = arg[index + 1]
                mutableArg.remove(at: index + 1)
                mutableArg.remove(at: index)
                if let regularNumber = Formatters.numberFormatter.number(from: value) {
                    return .absolute(CGFloat(regularNumber.doubleValue))
                } else if let percentNumber = Formatters.percentFormatter.number(from: value) {
                    return .percent(CGFloat(percentNumber.doubleValue))
                } else {
                    print("Can't use \(value) as number or percent.")
                    exit(1)
                }
            } else {
                print("Expected argument after `-d` or `--distance`")
                exit(1)
            }
        }
        return `default`
    }

    static var `default`: BadgeInput.Distance {
        return .percent(17.5)
    }

    static var help: String {
        return
            " -d, --distance      The distance from the `badge` to the corner of the image (along the axises). Valid values are absolute and relative,\n" +
            "                     such as `65`, `72.1`, `50%` and `99%`."
    }

}
