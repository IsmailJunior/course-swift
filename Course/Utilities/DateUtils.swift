import Foundation

public func month() -> String {
    let date = Date()
    let dateFormatter = DateFormatter()
     dateFormatter.dateFormat = "LLLL d"
    let monthString = dateFormatter.string(from: date)
    return monthString
}
