//
//  ForcastTemperatureCell.swift
//  WeatherWhat
//
//  Created by LCH on 5/22/25.
//

import UIKit
import SnapKit

final class ForcastTemperatureCell: UICollectionViewCell {
    
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
        label.font = .boldSystemFont(ofSize: 10)
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
            $0.height.equalTo(weatherImage.snp.width)
            $0.horizontalEdges.equalTo(stackView.snp.horizontalEdges).inset(16)
            $0.top.equalTo(timeLabel.snp.bottom).offset(6)
            $0.bottom.equalTo(tempLabel.snp.top).offset(-21)
            
        }
        
        stackView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(contentView.snp.horizontalEdges)
            $0.top.equalTo(contentView.snp.top).inset(10)
            $0.bottom.equalTo(contentView.snp.bottom).inset(13)
        }
        
    }
    
    func configure(with data: SectionOfCellModel.CellModel) {
        switch data {
        case .timeForecastCellModel(let forcastData):
            timeLabel.text = forcastData.time
            weatherImage.image = UIImage(named: forcastData.weatherIcon)
            tempLabel.text = forcastData.temp
        default:
            break
        }
    }
}
