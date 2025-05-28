//
//  InitialViewModel.swift
//  WeatherWhat
//
//  Created by 박혜민 on 5/26/25.
//

import Foundation
import RxSwift
import RxCocoa

final class InitialViewModel {

    let userDefaults = UserDefaultsManager.shared

    private let totalData = TotalAddressDataInfo().getAllData()

    func transform(with input: Input) -> Output {
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

extension InitialViewModel {
    struct Input {
        let addressInput: Observable<String>
        let addressSelected: Observable<IndexPath>
    }

    struct Output {
        let completedData: Observable<[String]>
        let selectedData: Observable<LocationData>
    }
}


