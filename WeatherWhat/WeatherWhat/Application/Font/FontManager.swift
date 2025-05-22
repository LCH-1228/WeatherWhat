//
//  FontManager.swift
//  WeatherWhat
//
//  Created by 유승한 on 5/22/25.
//

import SwiftUI

extension Font {
    enum Kkubulim {
        case medium
        case custom(String)
        
        var value: String {
            switch self {
            case .medium:
                return "BMKkubulimTTF"
            case .custom(let name):
                return name
            }
        }
    }
    
    static func kkubulim(_ type: Kkubulim, size: CGFloat = 17) -> Font {
        return .custom(type.value, size: size)
    }
}
