//
//  CustomScroll.swift
//  Journ
//
//  Created by Yida Zhang on 2020-01-26.
//  Copyright © 2020 Yida Zhang. All rights reserved.
//

import Foundation
import SwiftUI

struct CustomScroll: GeometryEffect {
    
    var offset: CGFloat
    
    init(offset: CGFloat) {
        self.offset = offset
    }
    
    var animatableData: Double {
        get { return Double(offset) }
        set {
            offset = CGFloat(newValue)
        }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        return ProjectionTransform(CGAffineTransform(a: 1, b: 0, c: 0, d: 1, tx: offset, ty: 0))
    }


}
