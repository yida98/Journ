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
    var test = [[1],[2,3,4],[5],[6],[7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22],[9],[10],[11]]
    
    init(entryViewModel: EntryViewModel) {
        self.entryViewModel = entryViewModel
    }
    
    // TODO: Need to clip between scenes
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
    //            ForEach(entryViewModel.dayList, id: \.self) { (num) in
    //                GroupRow(entryViewModel: self.entryViewModel, listOfSingles: num)
    //                    .listRowInsets(EdgeInsets(top: 0, leading: CompositeListView.spacer, bottom: 0, trailing: 0))
    //                    .padding()
    //            }
                
                // TEST
                ForEach(test, id: \.self) { (num) in
                    GroupRow(entryViewModel: self.entryViewModel, listOfSingles: num)
                        .listRowInsets(EdgeInsets())
                }
            
    //            .listRowBackground(SpecialColor.lightLightGrey)
            }.background(SpecialColor.lightLightGrey)
        }
    }
}

struct CompositeListView_Previews: PreviewProvider {
    static var previews: some View {
        CompositeListView(entryViewModel: EntryViewModel())
    }
}
