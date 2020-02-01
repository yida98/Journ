//
//  EntryViewModel.swift
//  Journ
//
//  Created by Yida Zhang on 2020-01-02.
//  Copyright © 2020 Yida Zhang. All rights reserved.
//

import Foundation

class EntryViewModel: ObservableObject {
    @Published var entries: [Entry] = []
        
    @Published var currentDisplayMY: Date = Date()
    @Published var dayList: [[Int]] = [[Int]]() // [[1,2,3,4],[5],[6,7]]
    
    @Published var name: String = "Carrie"
    
    private var ratio: Int = 0
    
    init() {
    }
}

extension EntryViewModel {
    
    // All about Entries
    
    func isEntry(d: Int, m: Int?, y: Int?) -> Bool {
        return getEntry(d: d, m: m, y: y) != nil
    }
    
    func getEntry(from date: Date) -> Entry? {
        let resultList = entries.filter { $0.day.same(as: date)}
        if let result = resultList.first {
            return result
        }
        return nil
    }
    
    func getEntry(d: Int, m: Int?, y: Int?) -> Entry? {
        guard let date = Date.makeDate(year: currentDisplayMY.year, month: currentDisplayMY.month, day: d) else { return nil }
        return getEntry(from: date)
    }
        
    private func entriesInMonth() -> [Entry] {
        let resultList = entries.filter { $0.day.getYear() == currentDisplayMY.year && $0.day.getMonth() == currentDisplayMY.month }
        return resultList
    }
    
    func newEntry(from d: Int) -> Entry {
        guard let date = Date.makeDate(year: currentDisplayMY.year, month: currentDisplayMY.month, day: d) else { fatalError("Why can't I make a date") }
        return Entry(day: date)
    }

    
//    private func updateUsageList() {
//        usageList = [ListItem]()
//        guard let y = currentMonth["y"] else { fatalError() }
//        guard let m = currentMonth["m"] else { fatalError() }
//        let numOfDays = Date.numOfDays(in: (y, m))
//        for i in 1 ... numOfDays {
//            if let result = entries.first(where: { $0.day.getYear() == currentMonth["y"] && $0.day.getMonth() == i }) {
//                usageList.append(result)
//            } else {
//                usageList.append(i)
//            }
//        }
//    }
    
}

extension EntryViewModel {
    
    // All about days
    
    func makeDayList(for date: Date) -> [[Int]] { // [[1,2,3],[4],[5,6,7,8,9,10,11,12],[13],[14]]
        var result = [[Int]]()
        let numOfDays = Date.numOfDays(in: (date.year, date.month)) // correct
        
        var i = 1
        while i <= numOfDays {
            var currList = [i]
            if let _ = entries.first(where: { $0.day.getYear() == date.year && $0.day.getMonth() == date.month && $0.day.getDay() == i }) {
                result.append(currList)
                i += 1
            } else {
                var n = i + 1
                while entries.first(where: { $0.day.getYear() == date.year && $0.day.getMonth() == date.month && $0.day.getDay() == n }) == nil && n <= numOfDays {
                    currList.append(n)
                    n += 1
                }
                result.append(currList)
                i = n + 1
            }
        }
        return result
    }
    
    static func makeSevens(listOfSingle: [Int]) -> [[Int]] {
        var listOfList = [[Int]]()
        let num = listOfSingle.count / 7
        let remainder = listOfSingle.count % 7
        var index = 0
        for _ in 0..<num {
            let newList = Array(listOfSingle[index..<(index + 7)])
            listOfList.append(newList)
            index = index + 7
        }
        
        if remainder > 0 {
            let newList = Array(listOfSingle[index..<(index + remainder)])
            listOfList.append(newList)
        }
        
        return listOfList
    }
    
    private func makeDate(d: Int, m: Int?, y: Int?) -> Date {
        return Date.makeDate(year: y ?? currentDisplayMY.year, month: m ?? currentDisplayMY.month, day: d) ?? Date()
    }
    
    func weekdayStringWith(d: Int, m: Int?, y: Int?) -> String{
        return makeDate(d: d, m: m, y: y).weekdayString()
    }
    
    func monthDayStringWith(d: Int, m: Int?, y: Int?) -> String{
        return makeDate(d: d, m: m, y: y).monthDayString()
    }
    
    func currMonthString() -> String {
        let date = Date.makeDate(year: currentDisplayMY.year, month: currentDisplayMY.month) ?? Date()
        return date.monthString()
    }
    
    func currYearString() -> String {
        return String(currentDisplayMY.year)
    }
}

// Changing view

extension EntryViewModel {
    
    func goToPrevMonth() {
        currentDisplayMY = currentDisplayMY.previousMonth()
    }
    
    func goToNextMonth() {
        currentDisplayMY = currentDisplayMY.nextMonth()
    }
    
    func isMostRecentMonth() -> Bool {
        if currentDisplayMY.sameMonth(as: Date()) {
            return true
        }
        return false
    }
}

extension EntryViewModel {
    
    func getRatioString() -> String {
        let result = String(entriesInMonth().count) + "/" + String(Date.numOfDays(in: (currentDisplayMY.year, currentDisplayMY.month)))
        return result
    }
    
}
