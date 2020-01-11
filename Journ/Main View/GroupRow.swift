//
//  GroupRow.swift
//  Journ
//
//  Created by Yida Zhang on 2020-01-02.
//  Copyright © 2020 Yida Zhang. All rights reserved.
//

import SwiftUI

struct GroupRow: View {
    
    var listOfSingles: [[Int]] // [[1,2,3,4,5,6,7],[1,2,3,4,5,6,7],[1,2]]
    
    var body: some View {
        List(listOfSingles, id: \.self.first) { intList in// First of each group of seven
            List {
                ForEach(intList, id: \.self) { item in
                    Block(num: item)
                }
            }
        }
    }
}

struct GroupRow_Previews: PreviewProvider {
    static var previews: some View {
        let i = [[1,2,3,4,5,6,7],[8,9,10,11,12,13,14],[15,16]]
        return GroupRow(listOfSingles: i)
    }
}

extension GroupRow {
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
}

struct Block: View {
    
    var num: Int
    
    
    var body: some View {
        Button(action: {
            
        }) {
            // TODO:
            EntryView(entry: Entry(day: Date()))
        }
    }
}
