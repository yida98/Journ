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
    var test = [[6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22]]
    @State private var isDragging: Bool = false
    @State private var draggedOffset: CGFloat = CGFloat.zero
    
    init(entryViewModel: EntryViewModel) {
        self.entryViewModel = entryViewModel
    }
    
    var body: some View {
        
        let drag = DragGesture()
        .onChanged({ (value) in
            self.isDragging = true
            self.draggedOffset = value.translation.width / 2
        })
        .onEnded({ (value) in
            if self.draggedOffset > 60 {
                withAnimation(.spring()) {
                    self.draggedOffset = Constant.screenSize.width
                }
                    self.entryViewModel.goToPrevMonth()
            } else if self.draggedOffset < -60 && !self.entryViewModel.isMostRecentMonth() {
                withAnimation(.spring()) {
                    self.draggedOffset = -Constant.screenSize.width
                }
                    self.entryViewModel.goToNextMonth()
            } else {
                withAnimation {
                    self.draggedOffset = .zero
                }
            }
            self.isDragging = false
            DispatchQueue.main.async {
                self.draggedOffset = CGFloat(0)
            }
        })
        
        return HStack(alignment: .top, spacing: 0) {
            VStack {
                GroupRow(entryViewModel: self.entryViewModel, listOfList: entryViewModel.makeDayList(for: entryViewModel.currentDisplayMY.previousMonth()), displayMY: entryViewModel.currentDisplayMY.previousMonth())
                    .listRowInsets(EdgeInsets())
            }.background(SpecialColor.lightLightGrey)
                .disabled(true)
                .frame(width: Constant.screenSize.width)
            VStack {
                GroupRow(entryViewModel: self.entryViewModel, listOfList: entryViewModel.makeDayList(for: entryViewModel.currentDisplayMY), displayMY: entryViewModel.currentDisplayMY)
                    .listRowInsets(EdgeInsets())
                    // TEST
//                            GroupRow(entryViewModel: self.entryViewModel, listOfList: test, displayMY: entryViewModel.currentDisplayMY)
//                                .listRowInsets(EdgeInsets())
//                        .listRowBackground(SpecialColor.lightLightGrey)
                    // TEST
                }
                .highPriorityGesture(drag)
            if !self.entryViewModel.isMostRecentMonth() {
                VStack(alignment: .leading) {
                    GroupRow(entryViewModel: self.entryViewModel, listOfList: entryViewModel.makeDayList(for: entryViewModel.currentDisplayMY.nextMonth()), displayMY: entryViewModel.currentDisplayMY.nextMonth())
                            .listRowInsets(EdgeInsets())
                }.background(SpecialColor.lightLightGrey)
                .disabled(true)
                    .frame(width: Constant.screenSize.width)
            } else {
                Spacer()
                    .frame(width: Constant.screenSize.width)
                    .background(Color.red)
            }
        }
        .frame(width: Constant.screenSize.width)
        .offset(x: self.draggedOffset)
    }
}

struct CompositeListView_Previews: PreviewProvider {
    static var previews: some View {
        CompositeListView(entryViewModel: EntryViewModel())
    }
}
