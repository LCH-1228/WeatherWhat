//
//  CurrentWeatherCell.swift
//  WeatherWhat
//
//  Created by LCH on 5/26/25.
//

import UIKit
import RxSwift
import RxCocoa

final class CurrentWeatherCell: UICollectionViewCell {
    
    var disposeBag = DisposeBag()
        
    fileprivate let toggleUnitsButton: UIButton = {
        let button = UIButton()
        button.setImage(.clearCelsius, for: .normal)
        return button
    }()
    
    fileprivate let searchButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.pureBlack, for: .normal)
        button.titleLabel?.font = .suit(.regular, size: 13)
        button.titleLabel?.textAlignment = .left
        button.backgroundColor = .pureWhite
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.mainBlue.cgColor
        button.layer.borderWidth = 3
        return button
    }()
    
    private let searchButtonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "magnifyingglass")?.withTintColor(.mainBlue)
        return imageView
    }()
    
    private let weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let tempMinIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .minIcon
        return imageView
    }()
    
    private let tempMinLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .suit(.regular, size: 20)
        label.textAlignment = .center
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .pureBlack
        label.font = .suit(.bold, size: 60)
        label.textAlignment = .center
        return label
    }()
    
    private let tempMaxIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .maxIcon
        return imageView
    }()
    
    private let tempMaxLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .suit(.regular, size: 20)
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainBlue
        label.font = .suit(.regular, size: 20)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var minTempStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            tempMinIcon,
            tempMinLabel
        ])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var maxTempStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            tempMaxIcon,
            tempMaxLabel
        ])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 4
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.backgroundColor = .pureWhite
        
        [
            toggleUnitsButton,
            searchButton,
            weatherImage,
            minTempStackView,
            tempLabel,
            maxTempStackView,
            descriptionLabel
        ].forEach { contentView.addSubview($0) }
        
        searchButton.addSubview(searchButtonImage)
    }
    
    private func setConstraints() {
        
        toggleUnitsButton.snp.makeConstraints {
            $0.size.equalTo(30)
            $0.top.equalTo(contentView.snp.top)
            $0.trailing.equalTo(contentView.snp.trailing)
        }
        
        searchButton.titleLabel?.snp.makeConstraints {
            $0.leading.equalTo(searchButton.snp.leading).inset(8)
            $0.centerY.equalTo(searchButton.snp.centerY)
        }
        
        searchButton.snp.makeConstraints {
            $0.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(100)
            $0.top.equalTo(contentView.snp.top).inset(28)
            $0.centerX.equalTo(contentView.snp.centerX)
        }
        
        searchButtonImage.snp.makeConstraints {
            $0.size.equalTo(15)
            $0.trailing.equalTo(searchButton.snp.trailing).inset(6)
            $0.centerY.equalTo(searchButton.snp.centerY)
        }
        
        weatherImage.snp.makeConstraints {
            $0.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(98)
            $0.top.equalTo(searchButton.snp.bottom).offset(28)
            $0.height.equalTo(weatherImage.snp.width)
            $0.centerX.equalTo(contentView.snp.centerX)
        }
        
        tempLabel.snp.makeConstraints {
            $0.height.equalTo(69)
            $0.top.equalTo(weatherImage.snp.bottom).offset(24)
            $0.centerX.equalTo(contentView.snp.centerX)
        }
        
        minTempStackView.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.trailing.equalTo(tempLabel.snp.leading).offset(-12)
            $0.centerY.equalTo(tempLabel).offset(6)
        }
        
        tempMinIcon.snp.makeConstraints {
            $0.height.equalTo(tempMinLabel.snp.height).multipliedBy(0.7)
            $0.width.equalTo(tempMinIcon.snp.height)
        }
        
        maxTempStackView.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.leading.equalTo(tempLabel.snp.trailing).offset(12)
            $0.centerY.equalTo(tempLabel).offset(5)
        }
        
        tempMaxIcon.snp.makeConstraints {
            $0.height.equalTo(tempMaxLabel.snp.height).multipliedBy(0.7)
            $0.width.equalTo(tempMaxIcon.snp.height)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(tempLabel.snp.bottom).offset(5)
            $0.centerX.equalTo(contentView.snp.centerX)
        }
    }
    
    func configure(with data: SectionOfCellModel.CellModel) {
        switch data {
        case .currentWeather(let weatherData):
            toggleUnitsButton.setImage(UIImage(named: weatherData.toggleImage),
                                       for: .normal)
            searchButton.setTitle(weatherData.address, for: .normal)
            weatherImage.image = UIImage(named: weatherData.weatherIcon)
            tempMinLabel.text = weatherData.tempMin
            tempLabel.text = weatherData.temp
            tempMaxLabel.text = weatherData.tempMax
            descriptionLabel.text = weatherData.description
            contentView.backgroundColor = UIColor(named: weatherData.backgroundColor)
        default:
            break
        }
    }
}


extension Reactive where Base: CurrentWeatherCell {
    
    var searchButtonTapped: ControlEvent<Void> {
        return base.searchButton.rx.tap
    }
    
    var toggleButtonTapped: ControlEvent<Void> {
        return base.toggleUnitsButton.rx.tap
    }
}
