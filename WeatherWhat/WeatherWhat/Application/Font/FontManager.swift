//
//  FontManager.swift
//  WeatherWhat
//
//  Created by 유승한 on 5/22/25.
//

import UIKit

extension UIFont {
    
    enum Suit: String {
        case regular = "SUIT-Regular"
        case bold = "SUIT-Bold"
        case extrabold = "SUIT-ExtraBold"
    }

    enum Electricalsafety: String {
        case regular = "Electrical Safety Regular"
    }

    private static func loadFont(named name: String, size: CGFloat) -> UIFont {
        UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
    }

    static func suit(_ style: Suit, size: CGFloat = 17) -> UIFont {
        return loadFont(named: style.rawValue, size: size)
    }

    static func electricalsafety(_ style: Electricalsafety, size: CGFloat = 17) -> UIFont {
        return loadFont(named: style.rawValue, size: size)
    }
}
