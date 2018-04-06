import Foundation

public protocol CommandLineable {
    associatedtype ValueType
    static var help: String { get }
    var `default`: ValueType? { get }
}

