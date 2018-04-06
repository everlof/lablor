import Foundation

struct Formatters {

    static var numberFormatter = NumberFormatter()

    static var percentFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.positiveSuffix = "%"
        formatter.negativeSuffix = "%"
        return formatter
    }()

}
