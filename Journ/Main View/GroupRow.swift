//
//  GroupRow.swift
//  Journ
//
//  Created by Yida Zhang on 2020-01-02.
//  Copyright © 2020 Yida Zhang. All rights reserved.
//

import SwiftUI

struct GroupRow: View {
    
    @ObservedObject var entryViewModel: EntryViewModel
    var displayMY: Date
    var listOfList: [[Int]] = [[12], [1,2,3,4,5,6,7,8,9,10],[11,13,14],[15]]
    
    @State var isPresenting: Bool = false
    
    init(entryViewModel: EntryViewModel, listOfList: [[Int]], displayMY: Date) {
        self.entryViewModel = entryViewModel
        self.listOfList = listOfList
        self.displayMY = displayMY
    }
    
    var body: some View {
        VStack(alignment: .leading){
            ForEach(entryViewModel.makeDayList(for: displayMY), id: \.self.first) { list in
                Group {
                    if self.entryViewModel.isEntry(d: list.first ?? 0, m: self.displayMY.getMonth(),y: self.displayMY.getYear()) {
                        // Single Pane
                        SingleView(entryViewModel: self.entryViewModel, num: list.first ?? 0, displayMY: self.displayMY)
                    } else {
                        // Make Grid
                        GridView(entryViewModel: self.entryViewModel, gridList: list)
                    }
                }
            }
        }
    }
}

struct GroupRow_Previews: PreviewProvider {
    static var previews: some View {
        let i =  [[1,2,3,4,5,6,7],[77], [8,9,10,11,12,13,14,15,16]]
        return GroupRow(entryViewModel: EntryViewModel(), listOfList: i, displayMY: Date())
    }
}

struct SingleView: View {
    
    @ObservedObject var entryViewModel: EntryViewModel
    var num: Int
    var displayMY: Date
    
    init(entryViewModel: EntryViewModel, num: Int, displayMY: Date) {
        self.entryViewModel = entryViewModel
        self.num = num
        self.displayMY = displayMY
    }
    
    var body: some View {
        HStack {
            CustomSpacer(hSpace: Space.left)
            VStack(alignment: .leading) {
                Text(self.entryViewModel.weekdayStringWith(d: num, m: self.displayMY.getMonth(),y: self.displayMY.getYear()))
                    .font(Font.weekdayFont)
                    .foregroundColor(SpecialColor.darkGrey)
                
                Text(self.entryViewModel.monthDayStringWith(d: num, m: self.displayMY.getMonth(),y: self.displayMY.getYear()))
                    .font(Font.monthDayFont)
                    .foregroundColor(SpecialColor.yellow)
            }
            Spacer()
        }.padding()
            .background(Color.white)
    }
}

struct GridView: View {
    
    @ObservedObject var entryViewModel: EntryViewModel
    var gridList: [Int]
    
    
    init(entryViewModel: EntryViewModel, gridList: [Int]) {
        self.entryViewModel = entryViewModel
        self.gridList = gridList
    }
    
    var body: some View {
        HStack {
            CustomSpacer(hSpace: Space.leftInset)
            VStack(alignment: .leading) {
                ForEach(EntryViewModel.makeSevens(listOfSingle: gridList), id: \.self.first) { intList in// First of each group of seven
                    HStack {
                        ForEach(intList, id: \.self) { item in
                            Block(entryViewModel: self.entryViewModel, num: item)
                        }
                    }
                        .padding(.horizontal, 5)
                        .padding(.vertical, 5)
                }
            }
            CustomSpacer(hSpace: Space.leftInset)
        }.padding()
            .frame(width: Constant.screenSize)

    }
}

struct Block: View {
    
    @ObservedObject var entryViewModel: EntryViewModel
    var num: Int
    
    @State var isPresenting: Bool = false
    
    static var frameSize: CGFloat {
        return (Constant.screenSize/7) - 14
    }
    
    init(entryViewModel: EntryViewModel, num: Int) {
        self.entryViewModel = entryViewModel
        self.num = num
    }
    
    var body: some View {
        Button(action: {
            self.isPresenting.toggle()
        }) {
            // TODO:
//            EntryView(entry: Entry(day: Date()))
            Text(String(num))
                .frame(width: Block.frameSize, height: Block.frameSize, alignment: .center)
                .foregroundColor(.white)
                .background(SpecialColor.lightGrey)
//                .clipShape(RoundedRectangle(cornerRadius: 10))
                .cornerRadius(5)
                .font(Font.dayFont)
        }.sheet(isPresented: $isPresenting) {
            EntryView(entry: self.entryViewModel.newEntry(from: self.num))
        }
    }
}
