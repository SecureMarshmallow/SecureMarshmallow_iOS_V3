import Foundation


extension Date {
    
    public var startOfWeek: Date {
        let gregorian = Calendar(identifier: .gregorian)
        let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
        return gregorian.date(byAdding: .day, value: 0, to: sunday!)!
    }
    
    public func getWeekDates() -> [Date] {
        var thisWeekDateArray: [Date] = []
        for i in 0..<7 {
            thisWeekDateArray.append(Calendar.current.date(byAdding: .day, value: i, to: startOfWeek)!)
        }
        return thisWeekDateArray
    }
    
    public func isInThisWeek() -> Bool {
        let thisWeek: [Date] = Date().getWeekDates()
        var isIn: Bool = false
        let date = Calendar.current.dateComponents([.day, .year, .month], from: self)
        
        for item in thisWeek {
            let weekDate = Calendar.current.dateComponents([.day, .year, .month], from: item)
            
            if weekDate.year == date.year && weekDate.month == date.month && weekDate.day == date.day {
                isIn = true
                break
            } else {
                isIn = false
                
            }
        }
        return isIn
    }


}
