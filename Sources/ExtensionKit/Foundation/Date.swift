import Foundation

public extension Date {
    
    /// Days of the week in Gregorian calendar (Sunday - Saturday)
    static let days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    /// Current day of the week in Gregorian calendar
    var day: String {
        let gregorian = Calendar(identifier: .gregorian)
        let weekday = gregorian.component(.weekday, from: self)
        return Date.days[weekday]
    }
    
}
