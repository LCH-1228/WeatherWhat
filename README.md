# WeatherWhat

## 목차
1. [프로젝트 소개](#프로젝트-소개)
2. [팀소개](#프로젝트-소개)
3. [주요기능](#주요기능)
4. [개발기간](#개발기간)
5. [기술스택](#기술스택)
6. [프로젝트 파일 구조](#파일별-역할-및-프로젝트-구조)
7. [샘플이미지](#샘플이미지)
8. [실행방법](#실행방법)

## 프로젝트 소개
- 외출 전 빠르게 날씨를 확인하고 싶은 일반 사용자, 원하는 지역의 날씨를 검색하고 저장해두고 싶은 사용자를 위한 날씨 앱

## 팀소개
| 이름 | 역할 |
|------|------|
| 박혜민 | 와어이프레임, SA, 초기화면 구현 |
| 유승한 | 와이어프레임, SA, 스플래시뷰 구현 |
| 이다성 | 와이어프레임, SA, 디자인, 검색화면 구현 |
| 이찬호 | 와이프레임, SA, 메인화면 구현 |

## 주요기능
- 주소 자동완성
- 검색을 통한 위치 변경
- 섭씨 화시 단위 변경
-  날씨에 따른 배경 색상 변경

## 개발기간

> 2025.05.20(화) ~ 2025.05.28(수)

## 기술스택

### 개발환경
| 구분 | 비고 |
|------|------|
| Swift 5 | iOS 앱 개발을 위한 프로그래밍 언어 |
| Xcode 16.2 | iOS 앱 개발을 위한 공식 IDE |
| iOS 16.6 | Target OS 버전 |

### 사용 패턴
| 구분| 패턴 | 비고 |
|------|-----|------|
| 아키텍처 | MVVM <br> (Model-View-ViewModel) | - UI(View)와 비즈니스 로직(Model)을 분리하여 코드의 재사용성, 유지보수성 향상 <br> - ViewModel은 RxSwift를 기반으로 구성하여 사용자 이벤트와 데이터를 반응형(Rx) 방식으로 처리 |

### UI 구성
| 구분 | 비고 |
|------|------|
| UIKit | iOS 기본 UI 프레임워크 |
| [SnapKit 5.7.1](https://github.com/SnapKit/SnapKit) | AutoLayout을 간결하게 작성할 수 있는 DSL |

### 네트워크
| 구분 | 비고 |
|------|------|
| [Moya 15.0.3](https://github.com/Moya/Moya) | HTTP 네트워킹 라이브러리 |

### 기타 라이브러리
| 구분 | 비고 |
|------|------|
| [RxSwift 6.9.0](https://github.com/ReactiveX/RxSwift) | 반응형 프로그래밍을 위한 라이브러리 |
| [RxDataSources 5.0.2](https://github.com/RxSwiftCommunity/RxDataSources) | 테이블·컬렉션 뷰를 RxSwift로 바인딩할 수 있도록 도와주는 라이브러리 |


## 파일별 역할 및 프로젝트 구조

### 폴더별 파일 역활

---

#### Application 폴더
- `Data 폴더` : 주소 자동완성 기능을 위해 만든 JSON 파일 위치
- `Font  폴더` : 앱에서 사용할 Font 파일 위치
- `SplashView.swift ` : 앱 로딩 UI

#### InitialView 폴더
- `InitialViewController.swift` : 초기화면 UI 표시
- `InitialViewModel.swift` : 초기화면 뷰 모델

#### MainView 폴더
- `MainViewController.swift` : 메인화면 UI 표시
- `MainViewModel.swift ` : 메인화면 뷰 모델
- `Cell 폴더` : 날씨 표시를 위한 CollectionView Cell
- `ReusableView 폴더` : CollectionView 헤더와 배경색 지정을 위한 ReusableView 위치
- `Model 폴더` : 메인화면 동작을 위한 모델 위치

#### SearchView 폴더
- `SearchView.swift` : 서치바 + 테이블 뷰 공통 View(initial과 Search에서 사용)
- `SearchViewController.swift` :  검색화면 UI 표시
- `SearchViewModel.swift ` : 검색화면 뷰 모델

#### DataModel 폴더
- 네트워크 응답 디코딩과 UserDefault 사용시 인코딩/디코딩을 위한 구조체 위치

#### Service 폴더
- `UserDefaultsError.swift` : UserDefaults에서 발생하는 Error 정의
- `UserDefaultsManager.swift` : UserDefaults 입출력을 관리하는 싱글턴 클래스
- `WeatherAPI.swift` : 날씨 API 호출을 위한 코드 정의

---

### 프로젝트 구조
```
WeatherWhat
├── README.md
└── WeatherWhat
    ├── WeatherWhat
    │   ├── Application
    │   │   ├── AppDelegate.swift
    │   │   ├── Assets.xcassets
    │   │   ├── Data
    │   │   │   ├── TotalAddressData.json
    │   │   │   └── TotalAddressDataInfo.swift
    │   │   ├── Font
    │   │   ├── Info.plist
    │   │   ├── SceneDelegate.swift
    │   │   └── SplashView.swift
    │   ├── Common
    │   │   └── Cell
    │   │       └── AutoCompleteCell.swift
    │   ├── DataModel
    │   │   ├── CurrentWeather.swift
    │   │   ├── ForecastWeather.swift
    │   │   ├── LocationData.swift
    │   │   └── LocationHistory.swift
    │   ├── InitialView
    │   │   ├── InitialViewController.swift
    │   │   └── InitialViewModel.swift
    │   ├── MainView
    │   │   ├── Cell
    │   │   │   ├── CurrentWeatherCell.swift
    │   │   │   ├── ForecastRainCell.swift
    │   │   │   ├── ForecastTemperatureCell.swift
    │   │   │   └── ForecastWeatherCell.swift
    │   │   ├── MainViewController.swift
    │   │   ├── MainViewModel.swift
    │   │   ├── Model
    │   │   │   ├── SectionOfCellModel.swift
    │   │   │   ├── WeatherDescriptionTranslator.swift
    │   │   │   └── WeatherIconMatchModel.swift
    │   │   └── ReusableView
    │   │       ├── BaseBackground.swift
    │   │       ├── LeadingMaskingBackground.swift
    │   │       ├── SectionOfHeaderView.swift
    │   │       └── TrailingMaskingBackground.swift
    │   ├── SearchView
    │   │   ├── Cell
    │   │   │   └── LocationHistoryCell.swift
    │   │   ├── SearchView.swift
    │   │   ├── SearchViewController.swift
    │   │   └── SearchViewModel.swift
    │   └── Service
    │       ├── UserDefaultsError.swift
    │       ├── UserDefaultsManager.swift
    │       └── WeatherAPI.swift
    └── WeatherWhat.xcodeproj
```

## 샘플이미지

<div style="display: flex; gap: 10px; justify-content: center;">
<br>
<h3> 로딩화면 </h3>
  <img src="https://github.com/LCH-1228/WeatherWhat/blob/develop/SampleImages/Splash.png?raw=true" alt="스플래시뷰" width="40%">
</div>
<hr>
<div style="display: flex; gap: 10px; justify-content: center;">
<br>
<h3> 초기화면 </h3>
 <img src="https://github.com/LCH-1228/WeatherWhat/blob/develop/SampleImages/InitialView.png?raw=true" alt="초기화면" width="38%">
  <img src="https://github.com/LCH-1228/WeatherWhat/blob/develop/SampleImages/InitialViewAutcompletion.png?raw=true" alt="초기화면자동완성" width="40%">
 </div>
 <hr>
<div style="display: flex; gap: 10px; justify-content: center;">
<br>
<h3> 메인화면 </h3>
<img src="https://github.com/LCH-1228/WeatherWhat/blob/develop/SampleImages/MainViewDisplayCelsius.png?raw=true" alt="메인화면섭씨" width="30%">
<img src="https://github.com/LCH-1228/WeatherWhat/blob/develop/SampleImages/MainViewDisplayFahrenheit.png?raw=true" alt="메인화면화씨" width="30%">
<img src="https://github.com/LCH-1228/WeatherWhat/blob/develop/SampleImages/MainViewDisplayWeatherColor.png?raw=true" alt="메인화면 흐릴때" width="30%">
 </div>
 <hr>
<div style="display: flex; gap: 10px; justify-content: center;">
<br>
<h3> 검색화면 </h3>
<img src="https://github.com/LCH-1228/WeatherWhat/blob/develop/SampleImages/SearchView.png?raw=true" alt="검색화면" width="30%">
<img src="https://github.com/LCH-1228/WeatherWhat/blob/develop/SampleImages/SearchViewAutocompletion.png?raw=true" alt="검색화면 자동완성" width="30%">
<img src="https://github.com/LCH-1228/WeatherWhat/blob/develop/SampleImages/SearchViewHistory.png?raw=true" alt="검색화면 기록" width="30%">
 </div>
 
## 실행방법

1. 레포지토리 클론
```shell
git clone https://github.com/LCH-1228/WeatherWhat.git
```

2. 프로젝트 파일 실행