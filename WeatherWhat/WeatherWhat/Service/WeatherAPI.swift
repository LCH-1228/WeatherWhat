//
//  NetworkManager.swift
//  WeatherWhat
//
//  Created by Lee on 5/22/25.
//

import Foundation
import Moya

// MARK: 날씨 타입 열거형(연관값으로 lat, lon 주입)
// 나중에 WeatherType을 초기화할 때 값을 주입해줄 수 있음
enum WeatherAPI {
    case currentCelsius(lat: String, lon: String)
    case currentFahrenheit(lat: String, lon: String)
    case forecastCelsius(lat: String, lon: String)
    case forecastFahrenheit(lat: String, lon: String)
}

// MARK: WeatherType 확장
extension WeatherAPI: TargetType {
    // 기본 URL
    var baseURL: URL {
        return URL(string: "https://api.openweathermap.org")!
    }

    // case에 따라 path 분기
    var path: String {
        switch self {
        case .currentCelsius, .currentFahrenheit: return "/data/2.5/weather"
        case .forecastCelsius, .forecastFahrenheit: return "/data/2.5/forecast"
        }
    }

    // 모든 case가 get 메서드 사용
    var method: Moya.Method {
        return .get
    }

    // task가 딕셔너리 타입이라서 순서를 보장하지는 않지만, 쿼리 파라미터는 순서와 상관이 없음
    var task: Task {
        guard let apiKey = Bundle.main.infoDictionary?["APIKey"] as? String else {
            fatalError("Configuration에 정의된 키가 없습니다")
        }

        switch self {
        case .currentCelsius(let lat, let lon):
            return .requestParameters(parameters: [
                "lat": lat,
                "lon": lon,
                "appid": apiKey,
                "units": "metric"
            ], encoding: URLEncoding.queryString)
        case .currentFahrenheit(let lat, let lon):
            return .requestParameters(parameters: [
                "lat": lat,
                "lon": lon,
                "appid": apiKey,
                "units": "imperial"
            ], encoding: URLEncoding.queryString)
        case .forecastCelsius(let lat, let lon):
            return .requestParameters(parameters: [
                "lat": lat,
                "lon": lon,
                "appid": apiKey,
                "units": "metric"
            ], encoding: URLEncoding.queryString)
        case .forecastFahrenheit(let lat, let lon):
            return .requestParameters(parameters: [
                "lat": lat,
                "lon": lon,
                "appid": apiKey,
                "units": "imperial"
            ], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
