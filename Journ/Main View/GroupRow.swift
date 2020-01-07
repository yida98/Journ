//
//  GroupRow.swift
//  Journ
//
//  Created by Yida Zhang on 2020-01-02.
//  Copyright © 2020 Yida Zhang. All rights reserved.
//

import SwiftUI

struct GroupRow: View {
    
    @Binding var listOfSingles: [Int] // [[1,2,3,4,5,6,7],[1,2,3,4,5,6,7],[1,2]]
    
    var body: some View {
        List(alignmentGuide(.top, computeValue: { _ in
            return Constant.screenSize / 7 // negative alignment
        })) { // First of each group of seven
            ForEach(listOfSingles.count/7) {
                List {
                    ForEach() {
                        Block(num: 1)
                    }
                }
            }
        }
    }
}

struct GroupRow_Previews: PreviewProvider {
    static var previews: some View {
        GroupRow()
    }
}

extension GroupRow {
    private func makeSevens() {
        let num = listOfSingles.count / 7
        
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
