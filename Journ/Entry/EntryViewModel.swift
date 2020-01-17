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
    
    private var currentMonthYear = ["y": Date().getYear(), "m": Date().getMonth()]
//    @Published var dayList: [String: [Int]] = ["Empty": [Int](), "Written": [Int]()]
    @Published var dayList: [[Int]] = [[Int]]() // [[1,2,3,4],[5],[6,7]]
    
//    @Published var usageList: [ListItem] = [ListItem]()
    @Published var name: String = "Carrie"
    
    private var ratio: Int = 0
    
    init() {
    }
}

extension EntryViewModel {
    
    // All about Entries
    
    func isEntry(with day: Int) -> Bool {
        return getEntry(d: day, m: nil, y: nil) != nil
    }
    
    func getEntry(from date: Date) -> Entry? {
        let resultList = entries.filter { $0.day.same(as: date)}
        if let result = resultList.first {
            return result
        }
        return nil
    }
    
    func getEntry(d: Int, m: Int?, y: Int?) -> Entry? {
        guard let currYear = currentMonthYear["y"] else { fatalError() }
        guard let currMonth = currentMonthYear["m"] else { fatalError() }
        guard let date = Date.makeDate(year: y ?? currYear, month: m ?? currMonth, day: d) else { return nil }
        return getEntry(from: date)
    }
        
    private func entriesInMonth() -> [Entry] {
        let resultList = entries.filter { $0.day.getYear() == currentMonthYear["y"] && $0.day.getMonth() == currentMonthYear["m"] }
        return resultList
    }
    
    func newEntry(from d: Int) -> Entry {
        guard let currYear = currentMonthYear["y"] else { fatalError() }
        guard let currMonth = currentMonthYear["m"] else { fatalError() }
        guard let date = Date.makeDate(year: currYear, month: currMonth, day: d) else { fatalError("Why can't I make a date") }
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
    
    private func makeDays() {
        dayList = [[Int]]()
        guard let y = currentMonthYear["y"] else { fatalError() }
        guard let m = currentMonthYear["m"] else { fatalError() }
        let numOfDays = Date.numOfDays(in: (y, m))
        
        var i = 1
        while i <= numOfDays {
            var n = i + 1
            var currList = [Int]()
            if let _ = entries.first(where: { $0.day.getYear() == currentMonthYear["y"] && $0.day.getMonth() == i }) {
                currList.append(i)
                while (entries.first(where: { $0.day.getYear() == currentMonthYear["y"] && $0.day.getMonth() == n }) != nil) && n <= numOfDays {
                    currList.append(n)
                    n += 1
                }
                dayList.append(currList)
            } else {
                currList.append(i)
                while entries.first(where: { $0.day.getYear() == currentMonthYear["y"] && $0.day.getMonth() == n }) == nil && n <= numOfDays {
                    currList.append(n)
                    n += 1
                }
            }
            i = n + 1
        }
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
    
    func makeDate(d: Int) -> Date {
        return Date.makeDate(year: currentMonthYear["m"] ?? 0, month: currentMonthYear["y"] ?? 0, day:d) ?? Date()
    }
    
    func currMonthString() -> String {
        let date = Date.makeDate(year: currentMonthYear["m"] ?? 0, month: currentMonthYear["y"] ?? 0) ?? Date()
        return date.monthString()
    }
    
    func currYearString() -> String {
        return String(currentMonthYear["y"] ?? 1970)
    }
}

// Changing view

extension EntryViewModel {
    
    func getPreviousMonth() -> [String: Int] {
        guard let y = currentMonthYear["y"] else { fatalError() }
        guard let m = currentMonthYear["m"] else { fatalError() }
        var resultM = m
        var resultY = y
        if m == 1 {
            resultM = 12
            resultY -= 1
        } else {
            resultM -= 1
        }
        return ["y": resultY, "m": resultM]
    }
    
    func getNextMonth() -> [String: Int]? {
        guard let y = currentMonthYear["y"] else { fatalError() }
        guard let m = currentMonthYear["m"] else { fatalError() }
        var resultM = m
        var resultY = y
        if y < Date().getYear() {
            if m == 12 {
                resultM = 1
                resultY += 1
            } else {
                resultM += 1
            }
        } else {
            if resultM < Date().getMonth() {
                resultM += 1
            } else {
                return nil
            }
        }
        return ["y": resultY, "m": resultM]
    }
    
    func previousMonth() {
        currentMonthYear = getPreviousMonth()
    }
    
    func nextMonth() {
        if let next = getNextMonth() {
            currentMonthYear = next
        }
    }
}

extension EntryViewModel {
    
    func getRatioString() -> String {
        guard let y = currentMonthYear["y"] else { fatalError() }
        guard let m = currentMonthYear["m"] else { fatalError() }
        let result = String(entriesInMonth().count) + "/" + String(Date.numOfDays(in: (y, m)))
        return result
    }
    
}
