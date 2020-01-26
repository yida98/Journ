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
    @State private var draggedOffset: CGFloat = CGFloat.zero
    @GestureState private var dragState: DragState = DragState.inactive
    
    init(entryViewModel: EntryViewModel) {
        self.entryViewModel = entryViewModel
    }
    
    // TODO: Need to clip between scenes
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    ForEach(entryViewModel.makeDayList(for: entryViewModel.currentDisplayMY.previousMonth()), id: \.self) { (num) in
                        GroupRow(entryViewModel: self.entryViewModel, listOfSingles: num)
                            .listRowInsets(EdgeInsets())
                    }
                }.background(SpecialColor.lightLightGrey)
            }.frame(width: Constant.screenSize)
                .disabled(true)
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
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
                }.background(SpecialColor.lightLightGrey)
            }.frame(width: Constant.screenSize)
            .disabled(true)
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    ForEach(entryViewModel.makeDayList(for: entryViewModel.currentDisplayMY.nextMonth()), id: \.self) { (num) in
                        GroupRow(entryViewModel: self.entryViewModel, listOfSingles: num)
                            .listRowInsets(EdgeInsets())
                    }
                }.background(SpecialColor.lightLightGrey)
            }.frame(width: Constant.screenSize)
            .disabled(true)
            
        }
        .frame(width: Constant.screenSize)
        .offset(x: self.draggedOffset)
        .animation(Animation.spring())
        .simultaneousGesture(
            DragGesture()
            .onChanged({ (value) in
                print("changing")
                self.isDragging = true
                self.draggedOffset = value.translation.width
            })
            .onEnded({ (value) in
                print("ended")
                if self.draggedOffset > 120 {
                    self.draggedOffset = Constant.screenSize
                } else if self.draggedOffset < -120 {
                    self.draggedOffset -= Constant.screenSize
                } else {
                    self.draggedOffset = .zero
                }
                self.isDragging = false
            })
        )

    }
}

struct CompositeListView_Previews: PreviewProvider {
    static var previews: some View {
        CompositeListView(entryViewModel: EntryViewModel())
    }
}

extension CompositeListView {
    
    enum DragState {
        case inactive
        case pressing
        case dragging(translation: CGSize)
        
        var translation: CGSize {
            switch self {
            case .inactive, .pressing:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }
        
        var isActive: Bool {
            switch self {
            case .inactive:
                return false
            case .pressing, .dragging:
                return true
            }
        }
        
        var isDragging: Bool {
            switch self {
            case .inactive, .pressing:
                return false
            case .dragging:
                return true
            }
        }
    }
}
