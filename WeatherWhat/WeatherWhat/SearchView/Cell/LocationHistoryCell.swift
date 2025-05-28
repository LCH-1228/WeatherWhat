//
//  LocationHistoryCel.swift
//  WeatherWhat
//
//  Created by Lee on 5/24/25.
//

import UIKit
import RxSwift
import RxCocoa

final class LocationHistoryCell: UITableViewCell {

    private let label = UILabel()
    let cancelButton = UIButton()

    var disposeBag = DisposeBag()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        self.backgroundColor = .clear

        [label, cancelButton].forEach {
            self.contentView.addSubview($0)
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

    func configureCell(data: String) {
        label.text = data
    }
}

extension Reactive where Base: LocationHistoryCell {
    var buttonTap: ControlEvent<Void> {
        let buttonTap = base.cancelButton.rx.tap
        return buttonTap
    }
}
