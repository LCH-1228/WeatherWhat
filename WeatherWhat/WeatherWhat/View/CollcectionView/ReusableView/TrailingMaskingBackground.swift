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
        
        // 우측상단, 우측하단에만 cornerRadius를 적용하기 위한 mask 적용
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        layer.masksToBounds = true
        layer.cornerRadius = 16
        clipsToBounds = true
    }
    
    // layout 계산 완료 후 위치 및 크기 조정을 위한 layoutSubviews 메서드 오버라이딩
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // collectionView 좌우 스크롤 영역 마스킹용 뷰 위치 조정(bounds.size를 고려하여 계산)
        // - x: x좌표 끝점 계산을 위해 collectionView의 보정된 가로 크기에 0.5를 곱하여 계산
        // - y: collectionView 원본 좌표 + 크기를 (bounds.height - 24) 지정에 의한 보정값
        frame.origin.x = (frame.width - 9) * 0.5
        frame.origin.y = frame.origin.y + 12
        
        // collectionView 좌우 스크롤 영역 마스킹용 뷰 크기 조정
        // - width: section Inset 값 8 + 마스킹 보정 값 1
        // - height: 전체 높이 - section spacing을 위한 보정값 24
        bounds.size = .init(width: 9, height: bounds.height - 24)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
