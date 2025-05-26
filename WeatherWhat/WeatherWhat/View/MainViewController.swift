//
//  MainViewController.swift
//  WeatherWhat
//
//  Created by LCH on 5/22/25.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    private lazy var weatherCollectionView = UICollectionView(frame: .zero,
                                                      collectionViewLayout: createLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setConstraints()
        setCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configureUI() {
        
        view.backgroundColor = .white
        
        [
            weatherCollectionView
        ].forEach { view.addSubview($0) }
    }
    
    private func setConstraints() {
        
        weatherCollectionView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide.snp.horizontalEdges).inset(20)
            $0.verticalEdges.equalTo(view.safeAreaLayoutGuide.snp.verticalEdges)
        }
    }
    
    private func setCollectionView() {
        weatherCollectionView.delegate = self
        weatherCollectionView.dataSource = self
        
        weatherCollectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: "Cell"
        )
        
        weatherCollectionView.register(
            ForcastTemperatureCell.self,
            forCellWithReuseIdentifier:
                String(describing: ForcastTemperatureCell.self)
        )
        
        weatherCollectionView.register(
            ForcastRainCell.self,
            forCellWithReuseIdentifier:
                String(describing:ForcastRainCell.self)
        )
        
        weatherCollectionView.register(
            ForcastWeatherCell.self,
            forCellWithReuseIdentifier:
                String(describing: ForcastWeatherCell.self)
        )
        
        weatherCollectionView.register(
            SectionOfHeaderView.self,
            forSupplementaryViewOfKind:
                UICollectionView.elementKindSectionHeader,
            withReuseIdentifier:
                String(describing: SectionOfHeaderView.self)
        )
        
        weatherCollectionView.showsVerticalScrollIndicator = false
    }
}

// MARK: collectionView 관련 코드
private extension MainViewController {
    
    // collectionView 섹션 구분을 위한 enum
    private enum WeatherCollectionViewSection: Int, CaseIterable {
        case currentWeather
        case forcastTemperature
        case forcastRain
        case forcastWeather
    }
    
    // collectionView layout생성 메서드
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] section, env in
            guard let self, let sectionType = WeatherCollectionViewSection(
                rawValue: section
            ) else {
                return self?.createEmptySection()
            }
            
            switch sectionType {
            case .currentWeather:
                return self.createCurrentWeatherSection()
            case .forcastTemperature:
                return self.createForcastTemperatureSection()
            case .forcastRain:
                return self.createForcastRainSection()
            case .forcastWeather:
                return self.createForcastWeatherSection()
            }
        }
        
        // section별 배경색 지정을 위한 decorationView 등록
        layout.register(
            BaseBackground.self,
            forDecorationViewOfKind: "baseBackground"
        )
        
        // 스크롤시 leading, trailing을 마스킹 하기 위한 decorationView 등록
        layout.register(
            LeadingMaskingBackground.self,
            forDecorationViewOfKind: "leadingMaskingBackground"
        )
        layout.register(
            TrailingMaskingBackground.self,
            forDecorationViewOfKind: "trailingMaskingBackground"
        )
        
        return layout
    }
    
    // 예외처리를 위한 기본 section 생성 메서드
    private func createEmptySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .zero
        section.interGroupSpacing = 0
        return section
    }
    
    // 현재 날씨 section 생성 메서드
    private func createCurrentWeatherSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .zero
        section.interGroupSpacing = 0
        return section
    }
    
    
    // 온도 예보 section 생성 메서드
    private func createForcastTemperatureSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/6.42),
            heightDimension: .fractionalWidth(1/3.63)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        // section별 spacing을 위한 inset 설정
        section.contentInsets = .init(top: 32,
                                      leading: 8,
                                      bottom: 8,
                                      trailing: 8)
        section.interGroupSpacing = 8
        
        // section별 배경색 지정을 위한 decorationItem 생성
        let sectionBackgroundDecoration = NSCollectionLayoutDecorationItem.background(
            elementKind: "baseBackground"
        )
        
        // 스크롤시 leading, trailing을 마스킹 하기 위한 decorationItem 생성
        let sectionLeadingBackgroundDecoration = NSCollectionLayoutDecorationItem.background(
            elementKind: "leadingMaskingBackground"
        )
        let sectionTrailingBackgroundDecoration = NSCollectionLayoutDecorationItem.background(
            elementKind: "trailingMaskingBackground"
        )
        
        // decorationItem 크기 조정을 위한 inset 설정
        sectionBackgroundDecoration.contentInsets = .init(top: 24,
                                                          leading: 0,
                                                          bottom: 0,
                                                          trailing: 0)
        
        // 스크롤시 leading, trailing을 마스킹 하기 위한 decorationItem zIndex 설정
        sectionLeadingBackgroundDecoration.zIndex = 1
        sectionTrailingBackgroundDecoration.zIndex = 1
        
        // section에 decorationItem 추가
        section.decorationItems = [
            sectionBackgroundDecoration,
            sectionLeadingBackgroundDecoration,
            sectionTrailingBackgroundDecoration
        ]
        
        return section
    }
    
    // 강수확률 예보 section 생성 메서드
    private func createForcastRainSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/6.42),
            heightDimension: .fractionalWidth(1/4.64)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        // section별 spacing을 위한 inset 설정
        section.contentInsets = .init(top: 32,
                                      leading: 8,
                                      bottom: 8,
                                      trailing: 8)
        section.interGroupSpacing = 8
        
        // section별 배경색 지정을 위한 decorationItem 생성
        let sectionBackgroundDecoration = NSCollectionLayoutDecorationItem.background(
            elementKind: "baseBackground"
        )
        
        // 스크롤시 leading, trailing을 마스킹 하기 위한 decorationItem 생성
        let sectionLeadingBackgroundDecoration = NSCollectionLayoutDecorationItem.background(
            elementKind: "leadingMaskingBackground"
        )
        let sectionTrailingBackgroundDecoration = NSCollectionLayoutDecorationItem.background(
            elementKind: "trailingMaskingBackground"
        )
        
        // decorationItem 크기 조정을 위한 inset 설정
        sectionBackgroundDecoration.contentInsets = .init(top: 24,
                                                          leading: 0,
                                                          bottom: 0,
                                                          trailing: 0)
        
        // 스크롤시 leading, trailing을 마스킹 하기 위한 decorationItem zIndex 설정
        sectionLeadingBackgroundDecoration.zIndex = 1
        sectionTrailingBackgroundDecoration.zIndex = 1
        
        // section에 decorationItem 추가
        section.decorationItems = [
            sectionBackgroundDecoration,
            sectionLeadingBackgroundDecoration,
            sectionTrailingBackgroundDecoration
        ]
        
        return section
    }
    
    // 날씨예보 section 생성 메서드
    private func createForcastWeatherSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1/10.4)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        
        // section별 spacing을 위한 inset 설정
        section.contentInsets = .init(top: 0,
                                      leading: 8,
                                      bottom: 8,
                                      trailing: 8)
        section.interGroupSpacing = 8
        
        // header 표시를 위한 boundarySupplementaryItem 생성
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .absolute(43)
        )
        let headerView = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
        
        // section별 배경색 지정을 위한 decorationItem 생성
        let sectionBackgroundDecoration = NSCollectionLayoutDecorationItem.background(
            elementKind: "baseBackground"
        )
        
        // decorationItem 크기 조정을 위한 inset 설정
        sectionBackgroundDecoration.contentInsets = .init(top: 35,
                                                          leading: 0,
                                                          bottom: 0,
                                                          trailing: 0)
        
        // section에 boundarySupplementaryItem 추가
        section.boundarySupplementaryItems = [headerView]
        
        // section에 decorationItem 추가
        section.decorationItems = [sectionBackgroundDecoration]
        return section
    }
}

// TODO: Layout작업 완료후 extension RxDataSource로 변경
extension MainViewController: UICollectionViewDelegate {
    
}

extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return WeatherCollectionViewSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let sectionType = WeatherCollectionViewSection(
            rawValue: indexPath.section
        ) else {
            return .init()
        }
        
        switch sectionType {
        case .forcastWeather:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: String(describing: SectionOfHeaderView.self),
                for: indexPath
            ) as? SectionOfHeaderView else {
                return .init()
            }
            
            headerView.configure(title: "5일 예보")
            return headerView
        default:
            return .init()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        guard let sectionType = WeatherCollectionViewSection(
            rawValue: section
        ) else {
            return 0
        }
        
        switch sectionType {
        case .currentWeather:
            return 1
        case .forcastTemperature:
            return 10
        case .forcastRain:
            return 10
        case .forcastWeather:
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let sectionType = WeatherCollectionViewSection(
            rawValue: indexPath.section
        ) else {
            return .init()
        }
        
        switch sectionType {
        case .currentWeather:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "Cell",
                for: indexPath
            )
            
            cell.backgroundColor = .amber
            
            return cell
        case .forcastTemperature:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: ForcastTemperatureCell.self),
                for: indexPath
            ) as? ForcastTemperatureCell else {
                return .init()
            }
            
            let tempValue = SectionOfCellModel.CellModel.timeForecastCellModel (
                .init(
                    weatherIcon: "01d",
                    time: "06시",
                    temp: "24°"
                )
            )
            cell.configure(with: tempValue)
            return cell
            
        case .forcastRain:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: ForcastRainCell.self),
                for: indexPath
            ) as? ForcastRainCell else {
                return .init()
            }
            
            let tempValue = SectionOfCellModel.CellModel.rainPercentResult(
                .init(
                    weatherIcon: "popIcon",
                    time: "09시",
                    percent: "56"
                )
            )
            cell.configure(with: tempValue)
            return cell
            
        case .forcastWeather:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: ForcastWeatherCell.self),
                for: indexPath
            ) as? ForcastWeatherCell else {
                return .init()
            }
            
            let tempValue = SectionOfCellModel.CellModel.dayForecastResult(
                .init(
                    weatherIcon: "50d",
                    day: Date(),
                    tempMax: "36°",
                    tempMin: "17°"
                )
            )
            cell.configure(with: tempValue)
            return cell
        }
    }
}
