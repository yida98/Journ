//
//  Font.swift
//  Journ
//
//  Created by Yida Zhang on 2019-12-30.
//  Copyright © 2019 Yida Zhang. All rights reserved.
//

import Foundation
import UIKit

struct Font {
    
    static var editorFont = "Avenir"
    static var editorSize = CGFloat(18)
    static var editorSpacing = CGFloat(8)
}

struct SpecialColour {
    static var darkGrey = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
}


extension NSMutableAttributedString {

    func setEditorFont(range: NSRange) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = Font.editorSpacing
        addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle as Any,
                       NSAttributedString.Key.foregroundColor: SpecialColour.darkGrey as Any,
                       NSAttributedString.Key.font: NSMutableAttributedString.editorFont as Any],
                      range: range)
    }

    static var editorFont: UIFont {
        guard let font = UIFont(name: "Avenir",
                                size: Font.editorSize) else {fatalError()}
        return font
    }
}
