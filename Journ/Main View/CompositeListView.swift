//
//  CompositeListView.swift
//  Journ
//
//  Created by Yida Zhang on 2020-01-14.
//  Copyright © 2020 Yida Zhang. All rights reserved.
//

import SwiftUI
import Foundation

struct CompositeListView: View {
    
    @ObservedObject var entryViewModel: EntryViewModel
//    var test = [[1,2,3,4,5,6,7,8,9,10],[7],[8,9,10,11]]
    var test = [[1],[2],[3],[4],[5],[6]]//,[7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22],[9],[10],[11]]
    @State private var isDragging: Bool = false
    @State private var draggedOffset: CGFloat = CGFloat.zero// Constant.screenSize / 2
    
    init(entryViewModel: EntryViewModel) {
        self.entryViewModel = entryViewModel
    }
    
    // TODO: Need to clip between scenes
    var body: some View {
        
        let drag = DragGesture()
        .onChanged({ (value) in
            print("changing")
            self.isDragging = true
            self.draggedOffset = value.translation.width / 2
        })
        .onEnded({ (value) in
            print("ended")
            if self.draggedOffset > 70 {
                withAnimation {
                    self.draggedOffset = Constant.screenSize
                }
                self.entryViewModel.goToPrevMonth()
            } else if self.draggedOffset < -70 && !self.entryViewModel.isMostRecentMonth() {
                withAnimation {
                    self.draggedOffset = -Constant.screenSize
                }
                self.entryViewModel.goToNextMonth()
            } else {
                withAnimation {
                    self.draggedOffset = .zero
                }
            }
            self.isDragging = false
            self.draggedOffset = .zero
        })
        
        return HStack(alignment: .top, spacing: 0) {
                VStack(alignment: .center) {
                    ForEach(entryViewModel.makeDayList(for: entryViewModel.currentDisplayMY.previousMonth()), id: \.self) { (num) in
                        GroupRow(entryViewModel: self.entryViewModel, listOfSingles: num)
                            .listRowInsets(EdgeInsets())
                    }
                }.background(SpecialColor.lightLightGrey)
                VStack {
                    ForEach(entryViewModel.makeDayList(for: entryViewModel.currentDisplayMY), id: \.self) { (num) in
                        GroupRow(entryViewModel: self.entryViewModel, listOfSingles: num)
                            .listRowInsets(EdgeInsets())
                    }
                    // TEST
//                    ForEach(test, id: \.self) { (num) in
//                        GroupRow(entryViewModel: self.entryViewModel, listOfSingles: num)
//                            .listRowInsets(EdgeInsets())
//                    }
//                    .listRowBackground(SpecialColor.lightLightGrey)
                    // TEST
                    Spacer()
                }.background(SpecialColor.lightLightGrey)
                
            if !self.entryViewModel.isMostRecentMonth() {
                    VStack(alignment: .leading) {
                        ForEach(entryViewModel.makeDayList(for: entryViewModel.currentDisplayMY.nextMonth()), id: \.self) { (num) in
                            GroupRow(entryViewModel: self.entryViewModel, listOfSingles: num)
                                .listRowInsets(EdgeInsets())
                        }
                    }.background(SpecialColor.lightLightGrey)
            } else {
                Spacer()
                    .frame(width: Constant.screenSize)
            }
        }
        .frame(width: Constant.screenSize)
        .offset(x: self.draggedOffset)
        .gesture(drag)

    }
}

struct CompositeListView_Previews: PreviewProvider {
    static var previews: some View {
        CompositeListView(entryViewModel: EntryViewModel())
    }
}
