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
    var listOfSingles: [Int] // [[1,2,3,4,5,6,7],[1,2,3,4,5,6,7],[1,2]]
    
    @State var isPresenting: Bool = false
    
    init(entryViewModel: EntryViewModel, listOfSingles: [Int]) {
        self.entryViewModel = entryViewModel
        self.listOfSingles = listOfSingles
    }
    
    var body: some View {
        VStack(alignment: .leading){
            if listOfSingles.count == 1 {//&& entryViewModel.isEntry(with: listOfSingles.first ?? 0) {
                singleView
                    .sheet(isPresented: $isPresenting) {
                    EntryView(entry: self.entryViewModel.getEntry(d: self.listOfSingles.first ?? 0, m: nil, y: nil) ?? self.entryViewModel.newEntry(from: self.listOfSingles.first ?? 0))
                }
                    .onTapGesture {
                        self.isPresenting.toggle()
                }
                
            } else {
                gridView
            }
//            singleView
        }
    }
}

struct GroupRow_Previews: PreviewProvider {
    static var previews: some View {
        let i = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]// [[1,2,3,4,5,6,7],[8,9,10,11,12,13,14],[15,16]]
        return GroupRow(entryViewModel: EntryViewModel(), listOfSingles: i)
    }
}

extension GroupRow {
    
    var gridView: some View {
        HStack {
            CustomSpacer(space: Space.leftInset)
            VStack(alignment: .leading) {
                ForEach(EntryViewModel.makeSevens(listOfSingle: listOfSingles), id: \.self.first) { intList in// First of each group of seven
                    HStack {
                        ForEach(intList, id: \.self) { item in
                            Block(entryViewModel: self.entryViewModel, num: item)
                        }
                    }
                        .padding(.horizontal, 5)
                        .padding(.vertical, 5)
                }
            }
            CustomSpacer(space: Space.leftInset)
        }.padding()
            
    }
    
    var singleView: some View {
        HStack {
            CustomSpacer(space: Space.left)
            VStack(alignment: .leading) {
                Text(entryViewModel.weekdayStringWith(d: listOfSingles.first ?? 0))
                    .font(Font.weekdayFont)
                    .foregroundColor(SpecialColor.darkGrey)
                
                Text(entryViewModel.monthDayStringWith(d: listOfSingles.first ?? 0))
                    .font(Font.monthDayFont)
                    .foregroundColor(SpecialColor.yellow)
            }
            Spacer()
        }.padding()
            .background(Color.white)
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
                .cornerRadius(10)
                .font(Font.dayFont)
        }.sheet(isPresented: $isPresenting) {
            EntryView(entry: self.entryViewModel.newEntry(from: self.num))
        }
    }
}
