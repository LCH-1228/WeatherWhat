//
//  SearchLogCustomView.swift
//  WeatherWhat
//
//  Created by Lee on 5/24/25.
//

import UIKit

class SearchLogCustomView: UIView {

    let label = UILabel()
    let cancelButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureUI() {
        [label, cancelButton].forEach {
            self.addSubview($0)
        }

        label.font = .suit(.regular, size: 13)
        label.textColor = .pureBlack

        cancelButton.setImage(UIImage(named: "deleteIcon"), for: .normal)
    }

    private func setConstraints() {
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(14)
            make.centerY.equalToSuperview()
        }

        cancelButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-14)
            make.centerY.equalToSuperview()
            make.size.equalTo(10)
        }
    }
}
