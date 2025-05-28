//
//  MainViewModel.swift
//  WeatherWhat
//
//  Created by LCH on 5/25/25.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

final class MainViewModel {
    
    private var disposeBag = DisposeBag()
    private let weatehrProvider = MoyaProvider<WeatherAPI>()
    private let errorRelay = PublishRelay<Error>()
    
    func transform(_ input: Input) -> Output {
        
        let location = input.fetchInitialData
            .withUnretained(self)
            .flatMap { vm, _ -> Observable<LocationData> in
                let location = vm.getCurrentLocation()
                return location
                    .catch { error in
                        print(error.localizedDescription)
                        return .empty()
                    }
            }
                
        let networkResponse = location
            .withUnretained(self)
            .flatMap { vm, location -> Observable<(CurrentWeather, ForecastWeather)> in
                    let currentWeather = vm.fetchCurrentWeather(lat: location.lat,
                                                                lon: location.lon)
                    let forecastWeather = vm.fetchForcastWeatehr(lat: location.lat,
                                                                 lon: location.lon)
                
                    return Observable.zip(currentWeather, forecastWeather)
            }
            .share()
        
        let collectionViewData = Observable.merge(input.fetchInitialData,
                                                  input.toggleButtonTapped.asObservable())
            .flatMapLatest { isCellciius in
                return networkResponse.map {
                    ($0.0, $0.1, isCellciius)
                }
            }
            .withLatestFrom(location) { weather, location in
                return (weather.0, weather.1, weather.2, location)
            }
            .withUnretained(self)
            .map { vm, response -> [SectionOfCellModel] in
                
                let currenWeatehrData = response.0
                let forecastWeatherData = response.1
                let isCellciius = response.2
                let currentLocation = response.3
                
                let currentWeatherSectionItem = vm.createFirstSectionItem(
                    weather: currenWeatehrData,
                    location: currentLocation,
                    isCellciius: isCellciius
                )
                
                let timeForecastSectionItem = vm.createSecondSectionItem(
                    weather: forecastWeatherData,
                    isCellciius: isCellciius
                )
                
                let rainPercentSectionItem = vm.createThirdSectionItem(
                    weather: forecastWeatherData,
                    isCellciius: isCellciius
                )
                
                let dayForcastSectionItem = vm.createForthSectionItem(
                    with: forecastWeatherData,
                    isCellciius: isCellciius
                )
                
                let currentWeatherSection = SectionOfCellModel(
                    section: .currentWeather,
                    items: currentWeatherSectionItem
                )
                
                let timeForecastSection = SectionOfCellModel(
                    section: .timeForecastCellModel,
                    items: timeForecastSectionItem
                )
                
                let rainPercentSection = SectionOfCellModel(
                    section: .rainPercentResult,
                    items: rainPercentSectionItem
                )
                
                let dayForcastSection = SectionOfCellModel(
                    section: .dayForecastResult,
                    items: dayForcastSectionItem
                )
                
                let dataSource: [SectionOfCellModel] = [
                    currentWeatherSection,
                    timeForecastSection,
                    rainPercentSection,
                    dayForcastSection
                ]
                                
                return dataSource
            }
            .asDriver(onErrorDriveWith: .empty())
        
        let background = input.fetchInitialData
            .flatMapFirst { _ in
                return networkResponse.map {
                    $0.0.weather.first!.icon
                }
            }
            .take(1)
            .asDriver(onErrorDriveWith: .empty())
        
        return Output(
            collectionViewData: collectionViewData,
            backgorund: background,
            error: errorRelay.asDriver(onErrorDriveWith: .empty())
        )
    }
    
    private func getCurrentLocation() ->  Observable<LocationData> {
        return Observable<LocationData>.create { observer in
            do {
                let data: LocationData = try UserDefaultsManager.shared.getData(with: .currentLocation)
                observer.onNext(data)
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    private func fetchCurrentWeather(lat: String, lon: String) -> Observable<CurrentWeather> {
        return weatehrProvider.rx.request(.currentCelsius(lat: lat, lon: lon))
            .asObservable()
            .map(CurrentWeather.self)
    }
    
    private func fetchForcastWeatehr(lat: String, lon: String) -> Observable<ForecastWeather> {
        return weatehrProvider.rx.request(.forecastCelsius(lat: lat, lon: lon))
            .asObservable()
            .map(ForecastWeather.self)
    }
    
    private func setUnits(number: Double, isCelsius: Bool) -> String {
        let temperature = Measurement(value: number, unit: UnitTemperature.celsius)
        switch isCelsius {
        case true:
            return "\(Int(temperature.value))°"
        case false:
            return "\(Int(temperature.converted(to: .fahrenheit).value))°"
        }
    }
    
    private func createFirstSectionItem(weather data: CurrentWeather,
                                    location: LocationData,
                                    isCellciius: Bool) -> [SectionOfCellModel.Item] {
        return [SectionOfCellModel.Item.currentWeather(
            .init(
                toggleImage: isCellciius ? "clearCelsius" : "clearFahrenheit",
                address: location.address,
                weatherIcon: String(data.weather.first!.icon.prefix(2)),
                tempMax: setUnits(number: data.main.tempMax,
                                  isCelsius: isCellciius),
                tempMin: setUnits(number: data.main.tempMin,
                                  isCelsius: isCellciius),
                temp: setUnits(number: data.main.temp,
                               isCelsius: isCellciius),
                description: data.weather.first!.description.displayName, backgroundColor: sendWeatherColor(with: data)))
        ]
    }
    
    
    private func createSecondSectionItem(weather data: ForecastWeather,
                                     isCellciius: Bool) -> [SectionOfCellModel.Item] {
        
        return data.list.map { forcastData in
            SectionOfCellModel.Item.timeForecastCellModel(
                .init(
                    weatherIcon: String(forcastData.weather.first!.icon.prefix(2)),
                    time: convertTimeToData(input: forcastData.dtTxt),
                    temp: setUnits(number: forcastData.main.temp,
                                   isCelsius: isCellciius)
                )
            )
        }
    }
    
    private func createThirdSectionItem(weather data: ForecastWeather,
                                        isCellciius: Bool) -> [SectionOfCellModel.Item] {
        
        return data.list.map { forcastData in
            SectionOfCellModel.Item.rainPercentResult(
                .init(
                    weatherIcon: "popIcon",
                    time: convertTimeToData(input: forcastData.dtTxt),
                    percent: "\(Int(forcastData.pop * 100))")
                )
        }
    }
    
    private func createForthSectionItem(with data: ForecastWeather, isCellciius: Bool) -> [SectionOfCellModel.Item] {
        let convertedForcasData = convetForcastData(with: data)
        
        let dic = Dictionary(
            grouping: convertedForcasData,
            by: { $0.dtTxt }
        )
        
        let convertedData: [SectionOfCellModel.CellModel] = dic
            .sorted(by: {
                $0.key < $1.key
            })
            .compactMap { (date, data) in
                let icons = data.flatMap { $0.weather.map { $0.icon} }
                
                let iconGroup = Dictionary(grouping: icons,
                                           by: {$0}
                )
                let iconGroupCount = iconGroup.mapValues { $0.count }
                let icon = iconGroupCount.keys.max { $0 < $1 }
                let minTemp = data.map({ $0.main.tempMin }).min()
                let maxTemp = data.map({ $0.main.tempMax }).max()
                return .dayForecastResult(.init(weatherIcon: String(icon!.prefix(2)),
                                                day: convertDateToDay(input: date),
                                                tempMax: setUnits(number: maxTemp!,
                                                                     isCelsius: isCellciius),
                                                tempMin: setUnits(number: minTemp!,
                                                                  isCelsius: isCellciius)
                                               )
                )
            }
        
        return convertedData
    }
    
    private func sendWeatherColor(with data: CurrentWeather) -> String {
        let defaultColorName = "pureWhite"
        let weatherColor = WeatherIconMatchModel()
        
        guard let list = data.weather.first else { return defaultColorName }
        guard let colorName = weatherColor.dictionary[list.icon] else { return defaultColorName }
        return colorName
    }
    
    private func convetForcastData(with data: ForecastWeather) -> [ForecastWeather.List] {
        return data.list.map { forcast in
            let weather = [
                ForecastWeather.List.Weather(
                    description: forcast.weather.first!.description,
                    icon: String(forcast.weather.first!.icon.prefix(2))
                )
            ]
            
            let day = convertDateTimeToDate(input: forcast.dtTxt)
            return ForecastWeather.List(
                main: forcast.main,
                weather: weather,
                pop: forcast.pop,
                dtTxt: day
            )
        }
    }
    
    private func convertTimeToData(input: String) -> String {
        let dateFormatter = DateFormatter()
        let dateTimeFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateTimeFormatter.dateFormat = "HH시"
        
        guard let dateData = dateFormatter.date(from: input) else {
            return ""
        }
        
        return dateTimeFormatter.string(from: dateData)
    }
    
    private func convertDateTimeToDate(input: String) -> String {
        let dateFormatter = DateFormatter()
        let dateFilterFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFilterFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let dateData = dateFormatter.date(from: input) else {
            return ""
        }
        
        return dateFilterFormatter.string(from: dateData)
    }
    
    private func convertDateToDay(input: String) -> String {
        
        let dateDayFormatter = DateFormatter()
        let dateFilterFormatter = DateFormatter()
        
        dateDayFormatter.dateFormat = "E"
        dateFilterFormatter.dateFormat = "yyyy-MM-dd"
        dateDayFormatter.locale = Locale(identifier: "ko_KR")
        
        guard let dateData = dateFilterFormatter.date(from: input) else {
            return ""
        }
        
        return dateDayFormatter.string(from: dateData)
    }
    
}

extension MainViewModel {
    struct Input {
        let fetchInitialData: Observable<Bool>
        let toggleButtonTapped: PublishRelay<Bool>
    }
    
    struct Output {
        let collectionViewData: Driver<[SectionOfCellModel]>
        let backgorund: Driver<String>
        let error: Driver<Error>
    }
}
