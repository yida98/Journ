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
    var test = [[6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22]]//,[9],[10],[11]]
    @State private var isDragging: Bool = false
    @State private var draggedOffset: CGFloat = CGFloat.zero// Constant.screenSize / 2
    
    init(entryViewModel: EntryViewModel) {
        self.entryViewModel = entryViewModel
    }
    
    // TODO: Need to clip between scenes
    var body: some View {
        
        let drag = DragGesture()
        .onChanged({ (value) in
            self.isDragging = true
            self.draggedOffset = value.translation.width / 2
        })
        .onEnded({ (value) in
            if self.draggedOffset > 60 {
                withAnimation(.spring()) {
                    self.draggedOffset = Constant.screenSize
                }
                DispatchQueue.main.async {
                    self.entryViewModel.goToPrevMonth()
                }
            } else if self.draggedOffset < -60 && !self.entryViewModel.isMostRecentMonth() {
                withAnimation(.spring()) {
                    self.draggedOffset = -Constant.screenSize
                }
                DispatchQueue.main.async {
                    self.entryViewModel.goToNextMonth()
                }
            } else {
                withAnimation {
                    self.draggedOffset = .zero
                }
            }
            self.isDragging = false
            DispatchQueue.main.async {
//                self.draggedOffset = CGFloat(0)
            }
        })
        
        return HStack(alignment: .top, spacing: 0) {
            VStack {
                ForEach(test, id: \.self) { (num) in
                    GroupRow(entryViewModel: self.entryViewModel, listOfSingles: num)
                        .listRowInsets(EdgeInsets())
                }
                .listRowBackground(SpecialColor.lightLightGrey)
            }.background(SpecialColor.lightLightGrey)
            .disabled(true)
            .frame(width: Constant.screenSize)
            VStack {
                Text("hiiiiiiiiiiiiiiiiiiiiii")
                    .frame(width: Constant.screenSize)
                    .background(Color.red)
//                ForEach(entryViewModel.makeDayList(for: entryViewModel.currentDisplayMY), id: \.self) { (num) in
//                    GroupRow(entryViewModel: self.entryViewModel, listOfSingles: num)
//                        .listRowInsets(EdgeInsets())
//                }
                // TEST
//                    ForEach(test, id: \.self) { (num) in
//                        GroupRow(entryViewModel: self.entryViewModel, listOfSingles: num)
//                            .listRowInsets(EdgeInsets())
//                    }
//                    .listRowBackground(SpecialColor.lightLightGrey)
                // TEST
                Spacer()
            }.background(SpecialColor.lightLightGrey)
            .frame(width: Constant.screenSize)
            .highPriorityGesture(drag)
            if !self.entryViewModel.isMostRecentMonth() {
                    VStack(alignment: .leading) {
                        ForEach(test, id: \.self) { (num) in
                            GroupRow(entryViewModel: self.entryViewModel, listOfSingles: num)
                                .listRowInsets(EdgeInsets())
                        }
                        .listRowBackground(SpecialColor.lightLightGrey)
                    }.background(SpecialColor.lightLightGrey)
                    .disabled(true)
                .frame(width: Constant.screenSize)
            } else {
                Spacer()
                    .frame(width: Constant.screenSize)
            }
        }
        .frame(width: Constant.screenSize)
        .offset(x: self.draggedOffset)
        .highPriorityGesture(drag)
    }
}

struct CompositeListView_Previews: PreviewProvider {
    static var previews: some View {
        CompositeListView(entryViewModel: EntryViewModel())
    }
}
