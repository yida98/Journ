//
//  DateExt.swift
//  Journ
//
//  Created by Yida Zhang on 11/20/19.
//  Copyright © 2019 Yida Zhang. All rights reserved.
//

import Foundation

extension Date {
    
    static func makeDate(timeZone: TimeZone = Date.currTimeZone, year: Int, month: Int, day: Int = 0) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        // calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        var components: DateComponents
        if day > 0 {
            components = DateComponents(timeZone: timeZone, year: year, month: month, day: day)
        } else {
            components = DateComponents(timeZone: timeZone, year: year, month: month)
        }
        return calendar.date(from: components)!
    }
    
    static func numOfDays(in date:(Int, Int)) -> Int {
        let currDate = Date()
        let calendar = Calendar.current
        if date.1 == currDate.getMonth() {
            let incompleteMonth = calendar.component(.day, from: currDate)
            return incompleteMonth
        }
        if let thisDay = Date.makeDate(timeZone: Date.currTimeZone, year: date.0, month: date.1) {
            return thisDay.daysInMonth()
        }
        return 0
    }
    
    private func daysInMonth() -> Int {
       let dateComponents = DateComponents(year: self.getYear(), month: self.getMonth())
       let calendar = Calendar.current
       if let date = calendar.date(from: dateComponents) {
           if let range = calendar.range(of: .day, in: .month, for: date) {
               let numDays = range.count
               return numDays
           }
       }
       return 0
    }
    
    static var currTimeZone: TimeZone = {
        return TimeZone.current
    }()
    
    func weekdayString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self)
    }
    
    func monthDayString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        return formatter.string(from: self)
    }

//    func getTimeZone() -> TimeZone {
//        return TimeZone.current
//    }
    
    func getDay() -> Int {
        let calendar = Calendar.current
        let today = calendar.component(.day, from: self)
        return today
    }

    func getMonth() -> Int {
        let calendar = Calendar.current
        let thisMonth = calendar.component(.month, from: self)
        return thisMonth
    }

    func getYear() -> Int {
        let calendar = Calendar.current
        let thisYear = calendar.component(.year, from: self)
        return thisYear
    }
    
    func same(as date: Date) -> Bool {
        if self.getYear() == date.getYear() && self.getMonth() == date.getMonth() && self.getDay() == date.getDay() {
            return true
        }
        return false
    }
}
