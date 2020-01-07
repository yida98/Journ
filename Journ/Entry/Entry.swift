//
//  Entry.swift
//  Journ
//
//  Created by Yida Zhang on 11/20/19.
//  Copyright © 2019 Yida Zhang. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class Entry: ObservableObject, Comparable {
    @Published var day: Date
    @Published var content: NSMutableAttributedString = NSMutableAttributedString()
    
    init(day: Date) {
        self.day = day
    }
    
    static func < (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.day < rhs.day
    }

    static func == (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.day == rhs.day
    }
}
