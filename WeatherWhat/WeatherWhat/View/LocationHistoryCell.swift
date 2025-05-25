//
//  LocationHistoryCel.swift
//  WeatherWhat
//
//  Created by Lee on 5/24/25.
//

import UIKit

class LocationHistoryCell: UITableViewCell {

    let searchLogCustomView = SearchLogCustomView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureUI() {
        self.contentView.addSubview(searchLogCustomView)
        self.backgroundColor = .clear
    }

    func setConstraints() {
        searchLogCustomView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func configureCell(data: LocationHistory, indexPath: IndexPath) {
        searchLogCustomView.label.text = data.history[indexPath.row].address
    }
}
