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
    
    @State var currentMonth = ["y": Date().getYear(), "m": Date().getMonth()]
    @State var dayList: [String: [Int]] = ["Empty": [Int](), "Written": [Int]()]
    
    init(entryViewModel: EntryViewModel) {
        self.entryViewModel = entryViewModel
    }
    
    var body: some View {
        Text("Hello World")
//            .sheet(isPresented: $isPresented) {
//                if let entry = entryViewModel.getEntry(from: Date()) {
//                    EntryView(entry: entry)
//                } else {
//                    EntryView(entry: Entry(day: Date()))
//                }
//        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(entryViewModel: EntryViewModel())
    }
}

extension ContentView {
    var listView: some View {
        VStack {
            ForEach($entryViewModel.dayList, id: \.self) { num in
                <#code#>
            }
        }
    }
}

