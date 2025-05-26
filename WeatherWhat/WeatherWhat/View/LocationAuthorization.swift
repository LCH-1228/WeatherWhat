//
//  LocationAuthorization.swift
//  WeatherWhat
//
//  Created by 유승한 on 5/26/25.
//

import UIKit
import CoreLocation
class PopUpViewController: UIViewController, CLLocationManagerDelegate {
  // 위치 관리자 인스턴스 생성
  let locationManager = CLLocationManager()
  override func viewDidLoad() {
    super.viewDidLoad()
    locationManager.delegate = self
    checkLocationAuthorization()
  }
  // 위치 권한 상태 확인 및 요청
  func checkLocationAuthorization() {
    let status: CLAuthorizationStatus
    if #available(iOS 14.0, *) {
      status = locationManager.authorizationStatus
    } else {
      status = CLLocationManager.authorizationStatus()
    }
    switch status {
    case .notDetermined:
      locationManager.requestWhenInUseAuthorization()
    case .authorizedWhenInUse, .authorizedAlways:
      print("위치 권한 허용됨")
    case .denied, .restricted:
      print("위치 권한 거부됨")
    @unknown default:
      break
    }
  }
}
