//
//  SectionOfHeaderView.swift
//  WeatherWhat
//
//  Created by LCH on 5/24/25.
//

import UIKit

final class SectionOfHeaderView: UICollectionReusableView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .pureBlack
        label.font = .suit(.bold, size: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(titleLabel)
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
    
}
