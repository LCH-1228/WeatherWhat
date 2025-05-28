//
//  UserDefaultsError.swift
//  WeatherWhat
//
//  Created by Lee on 5/28/25.
//

import Foundation

enum UserDefaultsError: Error {

    case failDataFetch
    case failDecoding

    var errorTitle: String {
        switch self {
        case .failDataFetch: return "데이터 불러오기 실패"
        case .failDecoding: return "디코딩 실패"
        }
    }

}
