//
//  ForecastRainCell.swift
//  WeatherWhat
//
//  Created by LCH on 5/22/25.
//

import UIKit
import SnapKit

final class ForecastRainCell: UICollectionViewCell {
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .pureBlack
        label.font = .suit(.bold, size: 10)
        label.textAlignment = .center
        return label
    }()
    
    private let weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .pureBlack
        label.font = .suit(.bold, size: 10)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:
                                        [
                                            timeLabel,
                                            weatherImage,
                                            tempLabel
                                        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.distribution = .equalCentering
        return stackView
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
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        [
             stackView
        ].forEach { contentView.addSubview($0) }
    }
    
    private func setConstraints() {
        
        weatherImage.snp.makeConstraints {
            $0.horizontalEdges.equalTo(stackView.snp.horizontalEdges).inset(16)
            $0.height.equalTo(weatherImage.snp.width)
        }
        
        stackView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(contentView.snp.horizontalEdges)
            $0.top.equalTo(contentView.snp.top).inset(9)
            $0.bottom.equalTo(contentView.snp.bottom).inset(7)
        }
        
    }
    
    func configure(with data: SectionOfCellModel.CellModel) {
        switch data {
        case .rainPercentResult(let forecastData):
            timeLabel.text = forecastData.time
            weatherImage.image = UIImage(named: forecastData.weatherIcon)
            tempLabel.text = forecastData.percent
        default:
            break
        }
    }
}
