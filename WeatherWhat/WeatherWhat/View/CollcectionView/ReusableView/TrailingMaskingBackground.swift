//
//  TrailingMaskingBackground.swift
//  WeatherWhat
//
//  Created by LCH on 5/24/25.
//

import UIKit
import SnapKit

final class TrailingMaskingBackground: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .mainBlue
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        layer.masksToBounds = true
        layer.cornerRadius = 16
        clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        frame.origin.x = (frame.width - 9) * 0.5
        frame.origin.y = frame.origin.y + 12
        bounds.size = .init(width: 9, height: bounds.height - 24)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
