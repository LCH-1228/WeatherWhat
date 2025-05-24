//
//  LeadingMaskingBackground.swift
//  WeatherWhat
//
//  Created by LCH on 5/24/25.
//

import UIKit
import SnapKit

final class LeadingMaskingBackground: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .mainBlue
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        layer.masksToBounds = true
        layer.cornerRadius = 16
        clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bounds.size = .init(width: 9, height: bounds.height - 24)
        frame.origin.x = -1
        frame.origin.y = frame.origin.y + 12
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
