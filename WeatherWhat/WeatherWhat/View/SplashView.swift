//
//  splashView.swift
//  WeatherWhat
//
//  Created by 유승한 on 5/26/25.
//

import UIKit
import SnapKit
final class SplashViewController: UIViewController {
    private let logoImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "splashLogo"))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(94)
            make.trailing.equalToSuperview().inset(94)
            make.height.equalTo(88)
            make.centerY.equalToSuperview()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 1.2초 정도 보여준 뒤 메인 화면으로
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            let mainVC = MainViewController()
            let nav = UINavigationController(rootViewController: mainVC)
            if let windowScene = self.view.window?.windowScene,
               let window = windowScene.windows.first {
                window.rootViewController = nav
                window.makeKeyAndVisible()
            }
        }
    }
}
