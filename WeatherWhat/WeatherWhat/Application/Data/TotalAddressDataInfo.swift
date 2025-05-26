//
//  TotalDataInfo.swift
//  WeatherWhat
//
//  Created by Lee on 5/25/25.
//

import Foundation

struct TotalAddressDataInfo{

    private var totalData: [LocationData] = []

    init() {
        loadData()
    }

    private mutating func loadData() {
        guard let path = Bundle.main.path(forResource: "TotalAddressData", ofType: "json") else { return }
        
        guard let jsonString = try? String(contentsOfFile: path) else { return }

        guard let data = jsonString.data(using: .utf8) else { return }

        guard let decodedData = try? JSONDecoder().decode([LocationData].self, from: data) else { return }
        self.totalData = decodedData
    }

    func getAllData() -> [LocationData] {
        return totalData
    }
}
