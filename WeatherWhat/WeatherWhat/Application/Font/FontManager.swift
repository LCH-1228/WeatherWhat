//
//  FontManager.swift
//  WeatherWhat
//
//  Created by 유승한 on 5/22/25.
//

import UIKit

extension UIFont {
    
    enum CustomFont {
        case suit(Suit)
        case electricalsafety(Electricalsafety)
        case custom(name: String)
        
        var fontName: String {
            switch self {
            case .suit(let type): return type.rawValue
            case .electricalsafety(let type): return type.rawValue
            case .custom(let name): return name
            }
        }
    }
    
    static func custom(_ type: CustomFont, size: CGFloat = 17) -> UIFont {
        return UIFont(name: type.fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    
    enum Suit: String {
        case regular = "SUIT-Regular"
        case bold = "SUIT-Bold"
        case extrabold = "SUIT-ExtraBold"
    }

    enum Electricalsafety: String {
        case regular = "Electrical Safety Regular"
    }
}
