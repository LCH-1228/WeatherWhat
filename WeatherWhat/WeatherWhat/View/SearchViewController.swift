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

        searchView.tableView.rowHeight = 40
        searchView.tableView.estimatedRowHeight = 40
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }

    func configureUI() {
        [searchView].forEach { view.addSubview($0) }
        view.backgroundColor = .white
    }

    func setConstraints() {
        searchView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(105)
            make.bottom.equalToSuperview().offset(-421)
            make.leading.equalToSuperview().offset(23)
            make.trailing.equalToSuperview().offset(-23)
        }
    }

    func bind() {

        let input = SearchViewModel.Input(
            addressInput: searchView.rx.searchText.asObservable(),
            addressSelected: searchView.tableView.rx.itemSelected.asObservable()
        )

        let output = viewModel.transform(with: input)

        output.completedData
            .asDriver(onErrorDriveWith: .empty())
            .drive(searchView.tableView.rx.items(cellIdentifier: String(describing: AutoCompleteCell.self), cellType: AutoCompleteCell.self)) { (row, element, cell) in
                cell.configureCell(data: element)
            }
            .disposed(by: disposeBag)

        output.selectedData
            .withUnretained(self)
            .asDriver(onErrorDriveWith: .empty())
            .drive { vc, selectedLocation in
                vc.viewModel.userDefaults.saveData(key: .currentLocation, value: selectedLocation)
                vc.navigationController?.pushViewController(ViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
}

