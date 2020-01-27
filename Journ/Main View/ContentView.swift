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
    @State private var draggedOffset: CGFloat = CGFloat.zero
    
//    @State var currentMonth = ["y": Date().getYear(), "m": Date().getMonth()]
    
    init(entryViewModel: EntryViewModel) {
        self.entryViewModel = entryViewModel
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .center, spacing: 0) {
                header2
                CompositeListView(entryViewModel: entryViewModel)
//                .offset(x: self.draggedOffset)
//                .animation(Animation.spring())
                InfoSheet(entryViewModel: entryViewModel)
                    .padding(.bottom, -InfoSheet.cornerRadius)
                
            }.edgesIgnoringSafeArea(.bottom)
                .background(SpecialColor.lightLightGrey)
            header
        }.foregroundColor(Color.white)
            .edgesIgnoringSafeArea(.top)
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
    
    var header2: some View {
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
    }
    
}
