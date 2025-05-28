//
//  AutoCompleteCell.swift
//  WeatherWhat
//
//  Created by Lee on 5/24/25.
//

import UIKit

final class AutoCompleteCell: UITableViewCell {

    private let label = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        [label].forEach {
            self.contentView.addSubview($0)
        }

        label.font = .suit(.regular, size: 15)
        label.textColor = .pureBlack

        self.backgroundColor = .clear
    }

    private func setConstraints() {
        label.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(11)
            make.trailing.equalToSuperview().offset(11)
        }
    }

    // 자동완성 모델의 데이터를 받아오면 되고, 임시로 UserLocationData로 입력
    func configureCell(data: String) {
        label.text = data
    }
}
