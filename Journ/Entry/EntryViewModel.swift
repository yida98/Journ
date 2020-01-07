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
    
    @Published var currentMonth = ["y": Date().getYear(), "m": Date().getMonth()]
//    @Published var dayList: [String: [Int]] = ["Empty": [Int](), "Written": [Int]()]
    @Published var dayList: [[Int]] = [[Int]]()
    
//    @Published var usageList: [ListItem] = [ListItem]()
    
    init() {
    }
    
    func getEntry(from date: Date) -> Entry? {
        let resultList = entries.filter { $0.day.same(as: date)}
        if let result = resultList.first {
            return result
        }
        return nil
    }
    
    private func entriesInMonth() -> [Entry] {
        let resultList = entries.filter { $0.day.getYear() == currentMonth["y"] && $0.day.getMonth() == currentMonth["m"] }
        return resultList
    }

    private func makeDays() {
        dayList = [[Int]]()
        guard let y = currentMonth["y"] else { fatalError() }
        guard let m = currentMonth["m"] else { fatalError() }
        let numOfDays = Date.numOfDays(in: (y, m))
        
        var i = 1
        while i <= numOfDays {
            var n = i + 1
            var currList = [Int]()
            if let _ = entries.first(where: { $0.day.getYear() == currentMonth["y"] && $0.day.getMonth() == i }) {
                currList.append(i)
                while (entries.first(where: { $0.day.getYear() == currentMonth["y"] && $0.day.getMonth() == n }) != nil) && n <= numOfDays {
                    currList.append(n)
                    n += 1
                }
                dayList.append(currList)
            } else {
                currList.append(i)
                while entries.first(where: { $0.day.getYear() == currentMonth["y"] && $0.day.getMonth() == n }) == nil && n <= numOfDays {
                    currList.append(n)
                    n += 1
                }
            }
            i = n + 1
        }
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

protocol ListItem {
}
//
//extension Entry: ListItem {
//}
//
//extension Int: ListItem {
//}
