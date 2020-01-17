//
//  FontVar.swift
//  Journ
//
//  Created by Yida Zhang on 2019-12-30.
//  Copyright © 2019 Yida Zhang. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct FontVar {
    
    static var overallFont = "Avenir"
    static var editorSize = CGFloat(18)
    static var editorSpacing = CGFloat(8)
    
    static var daySize = CGFloat(20)
    static var weekdaySize = CGFloat(14)
    static var monthDaySize = CGFloat(42)
    static var monthSize = CGFloat(52)
    
    static var nameSize = CGFloat(26)
    
    static var ratioSize = CGFloat(12)

}

extension Font {
    
    static var dayFont: Font = {
        return Font.custom(FontVar.overallFont, size: FontVar.daySize).weight(.medium)
    }()
    
    static var weekdayFont: Font = {
        return Font.custom(FontVar.overallFont, size: FontVar.weekdaySize)
    }()
    
    static var monthDayFont: Font = {
        return Font.custom(FontVar.overallFont, size: FontVar.monthDaySize)
    }()
    
    static var monthFont: Font = {
        return Font.custom(FontVar.overallFont, size: FontVar.monthSize).weight(.medium)
    }()
    
    static var nameFont: Font = {
        return Font.custom(FontVar.overallFont, size: FontVar.nameSize).smallCaps()
    }()
    
    static var ratioFont: Font = {
        return Font.custom(FontVar.overallFont, size: FontVar.ratioSize).weight(.medium)
    }()
    
}

extension NSMutableAttributedString {

    func setEditorFont(range: NSRange) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = FontVar.editorSpacing
        addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle as Any,
                       NSAttributedString.Key.foregroundColor: SpecialColour.darkGrey as Any,
                       NSAttributedString.Key.font: NSMutableAttributedString.editorFont as Any],
                      range: range)
    }

    static var editorFont: UIFont {
        guard let font = UIFont(name: "Avenir",
                                size: FontVar.editorSize) else {fatalError()}
        return font
    }
}
