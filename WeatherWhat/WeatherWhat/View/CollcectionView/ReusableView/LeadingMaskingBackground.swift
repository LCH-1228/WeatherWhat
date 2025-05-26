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
        
        // 우측상단, 우측하단에만 cornerRadius를 적용하기 위한 mask 적용
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        layer.masksToBounds = true
        layer.cornerRadius = 16
        clipsToBounds = true
    }
    
    // layout 계산 완료 후 위치 및 크기 조정을 위한 layoutSubviews 메서드 오버라이딩
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // collectionView 좌우 스크롤 영역 마스킹용 뷰 크기 조정
        // - width: section Inset 값 8 + x좌표 -1에 의한 보정값 1
        // - height: 전체 높이 - section spacing을 위한 보정값 24
        bounds.size = .init(width: 9, height: bounds.height - 24)
        
        // collectionView 좌우 스크롤 영역 마스킹용 뷰 위치 조정(bounds.size를 고려하여 계산)
        // - x: 0으로 지정시 마스킹이 정확하게 되지 않는 문제로 -1 로 보정
        // - y: collectionView 원본 좌표 + 크기를 (bounds.height - 24) 지정에 의한 보정값
        frame.origin.x = -1
        frame.origin.y = frame.origin.y + 12
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
