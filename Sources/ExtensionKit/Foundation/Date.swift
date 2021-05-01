import Foundation

public extension Date {

    /// Days of the week in Gregorian calendar (Sunday - Saturday)
    static let days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

    /// Returns the year from the date.
    var year: Int { Calendar.current.component(.year, from: self) }

    /// Returns month as `Int` starting from `1...12`.
    var month: Int { Calendar.current.component(.month, from: self) }

    /// Returns week as `Int` starting from 1...52
    var week: Int { Calendar.current.component(.weekOfYear, from: self) }

    var weekday: Int { Calendar.current.component(.weekday, from: self) }
    
    var weekOfMonth: Int { Calendar.current.component(.weekOfMonth, from: self) }
    
    var day: Int { Calendar.current.component(.day, from: self) }
    
    var hour: Int { Calendar.current.component(.hour, from: self) }
    
    var minute: Int { Calendar.current.component(.minute, from: self) }
    
    var second: Int { Calendar.current.component(.second, from: self) }
    
    var nanos: Int { Calendar.current.component(.nanosecond, from: self) }
    
    var yesterday: Date { self.adjust(.day, offset: -1) }
    
    var today: Date { self.startOfDay }
    
    var tomorrow: Date { self.adjust(.day, offset: 1) }
    
    var dayAfter: Date { self.adjust(.day, offset: 2) }
    
    var dayBefore: Date { self.adjust(.day, offset: -2) }
    
    var isLastDayOfMonth: Bool { return self.tomorrow.month != month }

    /// Offset component by amount
    /// - Parameters:
    ///   - type: Component
    ///   - offset: Offset to add
    /// - Returns: Date
    func adjust(_ type: Calendar.Component, offset: Int) -> Date {
        var comp = DateComponents()
        comp.setValue(offset, for: type)
        return Calendar.current.date(byAdding: comp, to: self)!
    }

    /// Start of current day
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    /// End of current day
    var endOfDay: Date {
        let cal = Calendar.current
        var comp = DateComponents()
        comp.day = 1
        return cal.date(byAdding: comp, to: self.startOfDay)!.addingTimeInterval(-1)
    }

    /// Get relative String back from Date ex: 1 year ago, 1 month ago ...
    /// - Parameters:
    ///   - currentDate: Current Date
    ///   - numericDates: Display the numeric value in string ex: 1 year ago vs Last year
    /// - Returns: String
    func toRelativeFormat(
        currentDate: Date = Date(),
        numericDates: Bool = true
    ) -> String {
        let calendar = Calendar.current
        let now = currentDate
        let earliest = (now as NSDate).earlierDate(self)
        let latest = (earliest == now) ? self : now
        let components = calendar.dateComponents(
            Calendar.Component.allCases, from: earliest, to: latest)

        if let year = components.year, year >= 2 {
            return "\(year) years ago"
        } else if let year = components.year, year >= 1 {
            if (numericDates) {
                return "1 year ago"
            } else {
                return "Last year"
            }
        } else if let month = components.month, month >= 2 {
            return "\(month) months ago"
        } else if let month = components.month, month >= 1 {
            if (numericDates) {
                return "1 month ago"
            } else {
                return "Last month"
            }
        } else if let week = components.weekOfYear, week >= 2 {
            return "\(week) weeks ago"
        } else if let week = components.weekOfYear, week >= 1 {
            if (numericDates) {
                return "1 week ago"
            } else {
                return "Last week"
            }
        } else if let day = components.day, day >= 2 {
            return "\(day) days ago"
        } else if let day = components.day, day >= 1 {
            if (numericDates) {
                return "1 day ago"
            } else {
                return "Yesterday"
            }
        } else if let hour = components.hour, hour >= 2 {
            return "\(hour) hours ago"
        } else if let hour = components.hour, hour >= 1 {
            if (numericDates) {
                return "1 hour ago"
            } else {
                return "An hour ago"
            }
        } else if let min = components.minute, min >= 2 {
            return "\(min) minutes ago"
        } else if let min = components.minute, min >= 1 {
            if (numericDates) {
                return "1 minute ago"
            } else {
                return "A minute ago"
            }
        } else if let sec = components.second, sec >= 3 {
            return "\(sec) seconds ago"
        } else {
            return "Just now"
        }
    }
}
