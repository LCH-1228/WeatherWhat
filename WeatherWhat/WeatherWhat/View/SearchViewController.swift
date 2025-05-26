//
//  SearchViewController.swift
//  WeatherWhat
//
//  Created by Lee on 5/26/25.
//

import UIKit
import RxSwift

class SearchViewController: UIViewController {

    let disposeBag = DisposeBag()

    let viewModel = SearchViewModel()

    let searchView = SearchView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setConstraints()
        bind()

        searchView.tableView.register(LocationHistoryCell.self, forCellReuseIdentifier: String(describing: LocationHistoryCell.self))
        searchView.tableView.register(AutoCompleteCell.self, forCellReuseIdentifier: String(describing: AutoCompleteCell.self))
        searchView.tableView.reloadData()
    }

    func configureUI() {
        [searchView].forEach { view.addSubview($0) }
    }

    func setConstraints() {
        searchView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(105)
            make.bottom.equalToSuperview().offset(-421)
            make.leading.equalToSuperview().offset(23)
            make.trailing.equalToSuperview().offset(-23)
        }

        searchView.tableView.rowHeight = 40
    }

    func bind() {

        let input = SearchViewModel.Input(addressInput: searchView.rx.searchText.asObservable())

        let output = viewModel.transform(with: input)

        output.completedData
            .asDriver(onErrorDriveWith: .empty())
            .drive(searchView.tableView.rx.items(cellIdentifier: String(describing: AutoCompleteCell.self), cellType: AutoCompleteCell.self)) { (row, element, cell) in
                cell.configureCell(data: element)
            }
            .disposed(by: disposeBag)
    }
}

