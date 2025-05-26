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

        return .init(completedData: userInput)
    }

}

extension SearchViewModel {
    struct Input {
        let addressInput: Observable<String>
    }

    struct Output {
        let completedData: Observable<[String]>
    }
}
