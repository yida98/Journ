//
//  InfoSheet.swift
//  Journ
//
//  Created by Yida Zhang on 2020-01-16.
//  Copyright © 2020 Yida Zhang. All rights reserved.
//

import SwiftUI

struct InfoSheet: View {
    
    @ObservedObject var entryViewModel: EntryViewModel
    @State var isLastestDate: Bool = true
    
    init(entryViewModel: EntryViewModel) {
        self.entryViewModel = entryViewModel
    }
    
    static var cornerRadius: CGFloat = 15
    
    var body: some View {
        HStack {
            CustomSpacer(space: Space.left)
            HStack(alignment: .top) { // Remove .top to drop "April" a little
                VStack(alignment: .leading, spacing: 20) {
                    Text(entryViewModel.currMonthString())
                        .font(Font.monthFont)
                        .foregroundColor(Color.white)
                    Text(entryViewModel.currYearString())
                        .font(Font.weekdayFont)
                        .foregroundColor(SpecialColor.darkGrey)
                }
                Spacer()
                VStack {
                    ratioView
                    Spacer()
                }
            }
        }.padding()
            .background(SpecialColor.yellow)
            .cornerRadius(InfoSheet.cornerRadius)
            .shadow(radius: 5)
            .frame(height: 200)
    }
}

struct InfoSheet_Previews: PreviewProvider {
    static var previews: some View {
        InfoSheet(entryViewModel: EntryViewModel())
    }
}

extension InfoSheet {
    
    var ratioView: some View {
        ZStack {
            if isLastestDate {
                Capsule()
                    .fill(Color.white)
                    .frame(width: 40, height: 24)
            }
            Text(entryViewModel.getRatioString())
                .foregroundColor(SpecialColor.yellow)
                .font(Font.ratioFont)
        }
    }
}
