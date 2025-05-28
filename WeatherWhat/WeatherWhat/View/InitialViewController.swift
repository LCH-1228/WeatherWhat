//
//  InitialViewController.swift
//  WeatherWhat
//
//  Created by 박혜민 on 5/26/25.
//


import UIKit
import SnapKit
import RxSwift
import RxCocoa

class InitialViewController: UIViewController {

    let viewModel = InitialViewModel()
    private var disposeBag = DisposeBag()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "mainLogo")
        return imageView
    }()
    
    let searchView: SearchView = {
        let searchView = SearchView()
        searchView.searchBar.setImage(UIImage(), for: .search, state: .normal)
        searchView.tableView.isHidden = true
        return searchView
    }()
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("시작하기", for: .normal)
        button.setTitleColor(.pureWhite, for: .normal)
        button.titleLabel?.font = .suit(.bold, size: 15)
        button.backgroundColor = .lightGray
        // 초기화 시 버튼 비활성화
        button.isEnabled = false
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setTableView()
        configureUI()
        
        searchView.tableView.register(AutoCompleteCell.self, forCellReuseIdentifier: String(describing: AutoCompleteCell.self))
        searchView.tableView.rowHeight = 40
        searchView.tableView.estimatedRowHeight = 40
    }
    
    private func bind() {
        
        let input = InitialViewModel.Input(
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
                if let savedLocation: LocationData = try? vc.viewModel.userDefaults.getData(with: .currentLocation) {
                    vc.searchView.searchBar.searchTextField.text = "검색 위치: \(savedLocation.address)"
                    vc.searchView.tableView.isHidden = true
                }
            }
            .disposed(by: disposeBag)
        
        // 입력값이 있을 경우 버튼 활성화
        searchView.rx.searchText
            .map { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
            .withUnretained(self)
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { vc, isEnabled in
                vc.startButton.isEnabled = isEnabled
                if isEnabled {
                    vc.startButton.backgroundColor = .mainBlue
                }
            })
            .disposed(by: disposeBag)
        
        // 시작하기 버튼 클릭 시 MainVC로 이동
        startButton.rx.tap
            .withUnretained(self)
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { vc, _ in
                if let currentData: LocationData = try? vc.viewModel.userDefaults.getData(with: .currentLocation) {
                  vc.viewModel.userDefaults.updateLocationHistory(with: currentData)
                }
                let mainVC = MainViewController()
                vc.navigationController?.pushViewController(mainVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    // 입력값이 있을 때 tableview 노출
    private func setTableView() {
        searchView.rx.searchText
            .map { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
            .withUnretained(self)
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { vc, shouldShow in
                vc.searchView.tableView.isHidden = !shouldShow
            })
            .disposed(by: disposeBag)
    }
    
    private func configureUI() {
        view.backgroundColor = .pureWhite
        
        [
            startButton,
            logoImageView,
            searchView
        ].forEach { view.addSubview($0) }
        
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(270)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(141)
            $0.height.equalTo(50)
        }
        
        searchView.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(23)
            $0.height.equalTo(200)
        }
        
        startButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(644)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(128)
            $0.height.equalTo(31)
        }
    }
}
