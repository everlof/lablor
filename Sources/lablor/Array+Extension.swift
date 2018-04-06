extension Array where Element == String {

    var quoted: Array {
        return self.map { "`\($0)`" }
    }

    var textualCommaJoin: String {
        guard let last = last else { return "" }
        return count > 2 ? dropLast().joined(separator: ", ") + " or " + last : joined(separator: " or ")
    }

}
