//
//  CustomSpacer.swift
//  Journ
//
//  Created by Yida Zhang on 2020-01-16.
//  Copyright © 2020 Yida Zhang. All rights reserved.
//

import SwiftUI

struct CustomSpacer: View {
    
    var hSpace: CGFloat
    var vSpace: CGFloat
    
    init(hSpace: CGFloat = 0, vSpace: CGFloat = 0) {
        self.hSpace = hSpace
        self.vSpace = vSpace
    }
    
    var body: some View {
        Spacer()
            .frame(width: hSpace, height: vSpace)
    }
}

struct Space {
    static var left: CGFloat = 20
    static var leftInset: CGFloat {
        return ((Constant.screenSize.width - ((Block.frameSize) * 7 + 40)) / 2) - 25// List default inset
    }
    static var top: CGFloat = 44
}

struct CustomSpacer_Previews: PreviewProvider {
    static var previews: some View {
        CustomSpacer(hSpace: Space.left, vSpace: Space.top)
    }
}
