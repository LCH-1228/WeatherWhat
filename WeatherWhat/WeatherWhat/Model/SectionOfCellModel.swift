//
//  SectionOfCellModel.swift
//  WeatherWhat
//
//  Created by LCH on 5/22/25.
//

import Foundation
import RxDataSources

struct SectionOfCellModel {
    var section: Section
    var items: [CellModel]
}

extension SectionOfCellModel {
    enum Section: Int {
        case currentWeather
        case timeForecastCellModel
        case rainPercentResult
        case dayForecastResult
        
        var headerTitle: String {
            switch self {
            case .currentWeather:
                return "현재 날씨"
            case .timeForecastCellModel:
                return "시간대별 날씨"
            case .rainPercentResult:
                return "시간대별 강수확률"
            case .dayForecastResult:
                return "5일 예보"
            }
        }
    }
    
    enum CellModel {
        case currentWeather(CurrentWeatherResult)
        case timeForecastCellModel(TimeForecastResult)
        case rainPercentResult(RainPercentResult)
        case dayForecastResult(DayForecastResult)
    }
}

extension SectionOfCellModel: SectionModelType {
    typealias Item = CellModel
    
    init(original: SectionOfCellModel, items: [CellModel]) {
        self = original
        self.items = items
    }
}

extension SectionOfCellModel.CellModel {
    struct CurrentWeatherResult {
        let toggleImage: String
        let address: String
        let weatherIcon: String
        let tempMax: String
        let tempMin: String
        let temp: String
        let description: String
        let backgroundColor: String
    }
    
    struct TimeForecastResult {
        let weatherIcon: String
        let time: String
        let temp: String
    }
    
    struct RainPercentResult {
        let weatherIcon: String
        let time: String
        let percent: String
    }
    
    struct DayForecastResult {
        let weatherIcon: String
        let day: String
        let tempMax: String
        let tempMin: String
    }
}
