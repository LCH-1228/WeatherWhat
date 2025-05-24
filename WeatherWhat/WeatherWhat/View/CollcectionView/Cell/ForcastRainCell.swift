//
//  ForcastTemperatureCell.swift
//  WeatherWhat
//
//  Created by LCH on 5/22/25.
//

import UIKit
import SnapKit

final class ForcastRainCell: UICollectionViewCell {
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .pureBlack
        label.font = .suit(.bold, size: 24)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
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
        label.font = .suit(.bold, size: 12)
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
        stackView.spacing = 6
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
            $0.verticalEdges.equalTo(contentView.snp.verticalEdges).inset(16)
        }
        
    }
    
    func configure(with data: SectionOfCellModel.CellModel) {
        switch data {
        case .rainPercentResult(let forcastData):
            timeLabel.text = forcastData.time
            weatherImage.image = UIImage(named: forcastData.weatherIcon)
            tempLabel.text = forcastData.percent
        default:
            break
        }
    }
}
