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
    let backButton = UIButton()
    let titleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setConstraints()
        backButtonTapped()
        bind()

        searchView.tableView.register(LocationHistoryCell.self, forCellReuseIdentifier: String(describing: LocationHistoryCell.self))
        searchView.tableView.register(AutoCompleteCell.self, forCellReuseIdentifier: String(describing: AutoCompleteCell.self))

        searchView.tableView.rowHeight = 40
        searchView.tableView.estimatedRowHeight = 40
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }

    func configureUI() {
        [backButton, titleLabel, searchView].forEach { view.addSubview($0) }
        view.backgroundColor = .white

        backButton.setImage(.backIcon, for: .normal)
        titleLabel.text = "검색"
        titleLabel.font = .suit(.extrabold, size: 20)
    }

    func setConstraints() {

        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(5)
            make.leading.equalToSuperview().offset(31)
            make.trailing.equalTo(backButton.snp.leading).offset(12)
            make.bottom.equalTo(searchView.snp.top).offset(-26)
        }

        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton.snp.centerY)
            make.leading.equalTo(backButton.snp.trailing).offset(12)
        }

        searchView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(51)
            make.bottom.equalToSuperview().offset(-421)
            make.leading.equalToSuperview().offset(23)
            make.trailing.equalToSuperview().offset(-23)
        }
    }

    func backButtonTapped() {
        backButton.rx.tap
            .withUnretained(self)
            .asDriver(onErrorDriveWith: .empty())
            .drive { vc, _ in
                vc.navigationController?.pushViewController(MainViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }

    func bind() {

        let input = SearchViewModel.Input(
            addressInput: searchView.rx.searchText.asObservable(),
            addressSelected: searchView.tableView.rx.itemSelected.asObservable()
        )

        let output = viewModel.transform(input: input)

        output.completedData
            .asDriver(onErrorDriveWith: .empty())
            .drive(searchView.tableView.rx.items) { (tableView, row, element) in
                let isEmpty = element.1
                let data = element.0
                if isEmpty {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LocationHistoryCell.self)) as? LocationHistoryCell else { return .init() }
                    cell.configureCell(data: data)

                    cell.cancelButton.rx.tap
                        .asDriver(onErrorDriveWith: .empty())
                        .drive(onNext: {
                            UserDefaultsManager.shared.removeData(index: row)
                        })
                        .disposed(by: cell.disposeBag)

                    return cell
                } else {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AutoCompleteCell.self)) as? AutoCompleteCell else { return .init() }
                    cell.configureCell(data: data)
                    return cell
                }
            }
            .disposed(by: disposeBag)

        output.selectedData
            .withUnretained(self)
            .asDriver(onErrorDriveWith: .empty())
            .drive { vc, selectedLocation in
                vc.viewModel.userDefaults.saveData(key: .currentLocation, value: selectedLocation)

                if let currentLocation: LocationData = try? UserDefaultsManager.shared.getData(with: .currentLocation) {
                    vc.viewModel.userDefaults.updateLocationHistory(with: currentLocation)
                } else {
                    vc.viewModel.userDefaults.updateLocationHistory(with: selectedLocation)
                }

                vc.navigationController?.pushViewController(MainViewController(), animated: true)
            }
            .disposed(by: disposeBag)

        output.isTableViewHidden
            .withUnretained(self)
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { vc, toggle in
                vc.searchView.tableView.isHidden = toggle })
            .disposed(by: disposeBag)
    }
}

