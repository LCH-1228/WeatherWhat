//
//  SearchView.swift
//  WeatherWhat
//
//  Created by Lee on 5/24/25.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

final class SearchView: UIView {

    let searchBar = UISearchBar()
    let tableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
        setConstraints()
    }

    private func configureUI() {
        [tableView, searchBar].forEach {
            self.addSubview($0)
        }

        tableView.backgroundColor = .subBlue
        tableView.layer.cornerRadius = 13
        tableView.contentInset = .init(top: 30, left: 0, bottom: 0, right: 0)

        searchBar.showsCancelButton = false
        searchBar.searchTextField.backgroundColor = .pureWhite
        searchBar.layer.borderWidth = 2
        searchBar.layer.cornerRadius = 10
        searchBar.placeholder = "위치를 입력해주세요."
        searchBar.searchTextField.font = .suit(.regular, size: 15)
        searchBar.layer.masksToBounds = true
        searchBar.layer.borderColor = UIColor.mainBlue.cgColor
    }

    private func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }

        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom).inset(30)
        }
    }

    func showHistoryView(_ isVisible: Bool) {
        tableView.isHidden = true
    }

}

extension Reactive where Base: SearchView {
    var searchText: ControlProperty<String> {
        return base.searchBar.rx.text.orEmpty
    }
}
