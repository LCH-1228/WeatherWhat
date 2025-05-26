//
//  SearchViewModel.swift
//  WeatherWhat
//
//  Created by Lee on 5/26/25.
//

import Foundation
import RxCocoa
import RxSwift

class SearchViewModel {

    let userDefaults = UserDefaultsManager.shared

    let totalData = TotalAddressDataInfo().getAllData()

    // totalInfo는 Observable
    let totalInfo = BehaviorRelay(value: TotalAddressDataInfo().getAllData())

    func transform(with input: Input) -> Output {
        // 서울
        let userInput = input.addressInput
            .withUnretained(self)
            .map { vm, str in
                vm.totalData
                    .map { $0.address }
                    .filter { $0.contains(str) }
            }

        let selectedAddress = input.addressSelected
            .withLatestFrom(userInput) { indexPath, str in
                str[indexPath.row]
            }
            .map { selectedStr in
                self.totalData.first { $0.address == selectedStr }
            }
            .compactMap { $0 }


        return .init(completedData: userInput, selectedData: selectedAddress)
    }

}

extension SearchViewModel {
    struct Input {
        let addressInput: Observable<String>
        let addressSelected: Observable<IndexPath>
    }

    struct Output {
        let completedData: Observable<[String]>
        let selectedData: Observable<LocationData>
    }
}
