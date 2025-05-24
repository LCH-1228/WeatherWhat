//
//  BaseBackground.swift
//  WeatherWhat
//
//  Created by LCH on 5/22/25.
//

import UIKit
import SnapKit

final class BaseBackground: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .mainBlue
        layer.cornerRadius = 16
        layer.masksToBounds = true
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
