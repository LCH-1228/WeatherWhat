//
//  ForcastWeatherCell.swift
//  WeatherWhat
//
//  Created by LCH on 5/22/25.
//

import UIKit
import SnapKit

final class ForcastWeatherCell: UICollectionViewCell {
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .pureBlack
        label.font = .suit(.bold, size: 17)
        return label
    }()
    
    private let weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let tempMinLabel: UILabel = {
        let label = UILabel()
        label.textColor = .pureBlack
        label.font = .suit(.bold, size: 20)
        return label
    }()
    
    private let dividingTextLabel: UILabel = {
        let label = UILabel()
        label.text = "/"
        label.textColor = .pureBlack
        label.font = .suit(.bold, size: 20)
        return label
    }()
    
    private let tempMaxLabel: UILabel = {
        let label = UILabel()
        label.textColor = .pureBlack
        label.font = .suit(.bold, size: 20)
        return label
    }()
    
    private lazy var leadingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:
                                        [
                                            dayLabel,
                                            weatherImage
                                        ])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 6
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private lazy var trailingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:
                                        [
                                            tempMinLabel,
                                            dividingTextLabel,
                                            tempMaxLabel
                                        ])
        stackView.axis = .horizontal
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
            leadingStackView,
            trailingStackView
        ].forEach { contentView.addSubview($0) }
    }
    
    private func setConstraints() {
        
        leadingStackView.snp.makeConstraints {
            $0.width.equalTo(80)
            $0.leading.equalTo(contentView.snp.leading).inset(16)
            $0.verticalEdges.equalTo(contentView.snp.verticalEdges).inset(24)
            $0.centerY.equalTo(contentView.snp.centerY)
        }
        
        dayLabel.snp.makeConstraints {
            $0.leading.equalTo(leadingStackView.snp.leading)
        }
        
        weatherImage.snp.makeConstraints {
            $0.verticalEdges.equalTo(leadingStackView.snp.verticalEdges)
            $0.width.equalTo(weatherImage.snp.height)
        }
        
        trailingStackView.snp.makeConstraints {
            $0.trailing.equalTo(contentView.snp.trailing).inset(16)
            $0.centerY.equalTo(contentView.snp.centerY)
        }
    }
    
    func configure(with data: SectionOfCellModel.CellModel) {
        switch data {
        case .dayForecastResult(let forcastData):
            dayLabel.text = "월"
            weatherImage.image = UIImage(named: forcastData.weatherIcon)
            tempMinLabel.text = forcastData.tempMin
            tempMaxLabel.text = forcastData.tempMax
        default:
            break
        }
    }
}
