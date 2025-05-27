//
//  UserDefaultsManager.swift
//  WeatherWhat
//
//  Created by Lee on 5/23/25.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard

    private init() {}

    /**
     key를 입력하고 value에 접근할 수 있는 메서드입니다
     - key: currentLocation(현재 위치), locationHistory(위치 전체 기록)
     */
    func getData<T: Decodable>(with key: userDefaultsKey) -> T? {
        if let data = defaults.data(forKey: key.rawValue) {
            if let decodedData = try?JSONDecoder().decode(T.self, from: data) {
                return decodedData
            }
        }
        return nil
    }

    /**
     key를 입력하고 value를 저장할 수 있는 메서드입니다
     - key: currentLocation(현재 위치), locationHistory(위치 전체 기록)
     - value: 제네릭 Type이므로 저장하는 타입에 따라 LocationHistory(history: [value]) 등으로 타입을 맞춰줘야 합니다.
     */
    func saveData<T: Encodable>(key: userDefaultsKey, value: T) {
        if let encodedData = try?JSONEncoder().encode(value) {
            defaults.set(encodedData, forKey: key.rawValue)
        }
    }

    /**
       위치 데이터를 추가할 수 있는 메서드입니다.
     - 데이터는 배열형태로 저장되며, locationHistory key에 접근하여 확인할 수 있습니다.
     */
    func updateLocationHistory(with locationData: LocationData) {
        var userHistory = getData(with: .locationHistory) ?? LocationHistory(history: [])
            userHistory.history.insert(locationData, at: 0)
            saveData(key: .locationHistory, value: userHistory)
    }

    /**
     인덱스에 해당하는 데이터를 삭제할 수 있는 메서드입니다.
     - 추후 테이블뷰에 적용할 때 선택한 indexPath.row의 값을 주입하여 삭제할 수 있습니다.
     */
    func removeData(index: Int) {
        var userHistory = getData(with: .locationHistory) ?? LocationHistory(history: [])
        userHistory.history.remove(at: index)
        saveData(key: .locationHistory, value: userHistory)
    }

    /**
     데이터를 삭제할 수 있는 메서드입니다.
     - 데이터는 배열형태로 저장되며, locationHistory key에 접근하여 확인할 수 있습니다.
     - 전체 삭제 구현 시에 사용할 수 있습니다.
     */
    func removeData(with key: userDefaultsKey) {
        defaults.removeObject(forKey: key.rawValue)
    }

}

extension UserDefaultsManager {
    enum userDefaultsKey: String {
        case currentLocation
        case locationHistory
    }
}
