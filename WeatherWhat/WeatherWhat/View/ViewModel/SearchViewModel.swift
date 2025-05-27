//
//  SearchViewModel.swift
//  WeatherWhat
//
//  Created by Lee on 5/26/25.
//

import Foundation
import RxCocoa
import RxSwift

final class SearchViewModel {

    let totalData = TotalAddressDataInfo().getAllData()

    let userDefaults = UserDefaultsManager.shared

    func transform(input: Input) -> Output {
        let userInput = input.addressInput
            .withUnretained(self)
            .map { vm, text in
                if text == "init" || text.isEmpty {
                    if let locationHistory: LocationHistory = try? vm.userDefaults.getData(with: .locationHistory) {
                        return locationHistory.history.map { ($0.address, true) }
                    } else {
                        return []
                    }
                } else {
                    return self.totalData
                        .map { ($0.address, false) }
                        .filter { $0.0.contains(text) }
                }
            }
            .share()

        let selectedAddress = input.addressSelected
            .withLatestFrom(userInput) { indexPath, text in
                text[indexPath.row].0
            }
            .withUnretained(self)
            .map { vm, seletedItem in
                vm.totalData.first { $0.address == seletedItem }
            }
            .compactMap { $0 }

        let isTableViewHidden = input.addressInput
            .map { text -> Bool in
                text.isEmpty
            }

        return .init(completedData: userInput, selectedData: selectedAddress, isTableViewHidden: isTableViewHidden)
    }
}

extension SearchViewModel{
    struct Input {
        let addressInput: Observable<String>
        let addressSelected: Observable<IndexPath>
    }

    struct Output {
        let completedData: Observable<[(String, Bool)]>
        let selectedData: Observable<LocationData>
        let isTableViewHidden: Observable<Bool>
    }
}
