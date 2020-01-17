//
//  CustomSpacer.swift
//  Journ
//
//  Created by Yida Zhang on 2020-01-16.
//  Copyright © 2020 Yida Zhang. All rights reserved.
//

import SwiftUI

struct CustomSpacer: View {
    
    var space: CGFloat
    
    var body: some View {
        Spacer()
            .frame(width: space)
    }
}

struct Space {
    static var left: CGFloat = 20
    static var leftInset: CGFloat {
        return ((Constant.screenSize - ((Block.frameSize) * 7 + 40)) / 2) - 25// List default inset
    }
}

struct CustomSpacer_Previews: PreviewProvider {
    static var previews: some View {
        CustomSpacer(space: Space.left)
    }
}
