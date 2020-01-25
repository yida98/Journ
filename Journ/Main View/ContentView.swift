//
//  ContentView.swift
//  Journ
//
//  Created by Yida Zhang on 11/20/19.
//  Copyright © 2019 Yida Zhang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var entryViewModel: EntryViewModel
    
    @State var isPresented: Bool = false
    
//    @State var currentMonth = ["y": Date().getYear(), "m": Date().getMonth()]
    
    init(entryViewModel: EntryViewModel) {
        self.entryViewModel = entryViewModel
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 0) {
                header
                CompositeListView(entryViewModel: entryViewModel)
                InfoSheet(entryViewModel: entryViewModel)
                    .padding(.bottom, -InfoSheet.cornerRadius)
                
            }.edgesIgnoringSafeArea(.bottom)
                .background(SpecialColor.lightLightGrey)
            header
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(entryViewModel: EntryViewModel())
    }
}

extension ContentView {
    
    var header: some View {
        HStack {
            Spacer()
            TextField("Add Name", text: $entryViewModel.name)
                .multilineTextAlignment(.center)
                .foregroundColor(SpecialColor.yellow)
                .font(Font.nameFont)
            Spacer()
        }.padding()
            .background(Color.white)
            .clipped()
            .shadow(radius: 3, x: 0, y: 5)
    }
    
}
