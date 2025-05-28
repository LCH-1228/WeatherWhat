//
//  WeatherDescriptionTranslator.swift
//  WeatherWhat
//
//  Created by 박혜민 on 5/24/25.
//

enum WeatherDescriptionTranslator: String, Codable {

    //Thunderstorm
    case thunderstormWithLightRain = "thunderstorm with light rain"
    case thunderstormWithRain = "thunderstorm with rain"
    case thunderstormWithHeavyRain = "thunderstorm with heavy rain"
    case lightThunderstorm = "light thunderstorm"
    case thunderstorm = "thunderstorm"
    case heavyThunderstorm = "heavy thunderstorm"
    case raggedThunderstorm = "ragged thunderstorm"
    case thunderstormWithLightDrizzle = "thunderstorm with light drizzle"
    case thunderstormWithDrizzle = "thunderstorm with drizzle"
    case thunderstormWithHeavyDrizzle = "thunderstorm with heavy drizzle"
    
    // Drizzle
    case lightIntensityDrizzle = "light intensity drizzle"
    case drizzle = "drizzle"
    case heavyIntensityDrizzle = "heavy intensity drizzle"
    case lightIntensityDrizzleRain = "light intensity drizzle rain"
    case drizzleRain = "drizzle rain"
    case heavyIntensityDrizzleRain = "heavy intensity drizzle rain"
    case showerRainAndDrizzle = "shower rain and drizzle"
    case heavyShowerRainAndDrizzle = "heavy shower rain and drizzle"
    case showerDrizzle = "shower drizzle"
    
    // Rain
    case lightRain = "light rain"
    case moderateRain = "moderate rain"
    case heavyIntensityRain = "heavy intensity rain"
    case veryHeavyRain = "very heavy rain"
    case extremeRain = "extreme rain"
    case freezingRain = "freezing rain"
    case lightIntensityShowerRain = "light intensity shower rain"
    case showerRain = "shower rain"
    case heavyIntensityShowerRain = "heavy intensity shower rain"
    case raggedShowerRain = "ragged shower rain"
    
    // Snow
    case lightSnow = "light snow"
    case snow = "snow"
    case heavySnow = "heavy snow"
    case sleet = "sleet"
    case lightShowerSleet = "light shower sleet"
    case showerSleet = "shower sleet"
    case lightRainAndSnow = "light rain and snow"
    case rainAndSnow = "rain and snow"
    case lightShowerSnow = "light shower snow"
    case showerSnow = "shower snow"
    case heavyShowerSnow = "heavy shower snow"
    
    // Atmosphere
    case mist = "mist"
    case smoke = "smoke"
    case haze = "haze"
    case sandDustWhirls = "sand/dust whirls"
    case fog = "fog"
    case sand = "sand"
    case dust = "dust"
    case volcanicAsh = "volcanic ash"
    case squalls = "squalls"
    case tornado = "tornado"
    
    // Clear & Clouds
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case scatteredClouds = "scattered clouds"
    case brokenClouds = "broken clouds"
    case overcastClouds = "overcast clouds"
    
    var displayName: String {
        switch self {
            
            // Thunderstorm
        case .thunderstormWithLightRain: return "약한 비를 동반한 천둥번개가 있어요"
        case .thunderstormWithRain: return "비를 동반한 천둥번개가 있어요"
        case .thunderstormWithHeavyRain: return "강한 비를 동반한 천둥번개가 있어요"
        case .lightThunderstorm: return "약한 천둥번개가 있어요"
        case .thunderstorm: return "천둥번개가 있어요"
        case .heavyThunderstorm: return "강한 천둥번개가 있어요"
        case .raggedThunderstorm: return "불규칙한 천둥번개가 있어요"
        case .thunderstormWithLightDrizzle: return "이슬비를 동반한 천둥번개가 있어요"
        case .thunderstormWithDrizzle: return "이슬비와 천둥번개가 있어요"
        case .thunderstormWithHeavyDrizzle: return "강한 이슬비와 천둥번개가 있어요"
            
            // Drizzle
        case .lightIntensityDrizzle: return "약한 이슬비가 내려요"
        case .drizzle: return "이슬비가 내려요"
        case .heavyIntensityDrizzle: return "강한 이슬비가 내려요"
        case .lightIntensityDrizzleRain: return "약한 이슬비와 비가 섞여 내려요"
        case .drizzleRain: return "이슬비가 섞인 비가 내려요"
        case .heavyIntensityDrizzleRain: return "강한 이슬비가 섞인 비가 내려요"
        case .showerRainAndDrizzle: return "소나기와 이슬비가 함께 내려요"
        case .heavyShowerRainAndDrizzle: return "강한 소나기와 이슬비가 함께 내려요"
        case .showerDrizzle: return "소나기처럼 이슬비가 내려요"
            
            // Rain
        case .lightRain: return "약한 비가 내려요"
        case .moderateRain: return "보통 세기의 비가 내려요"
        case .heavyIntensityRain: return "강한 비가 내려요"
        case .veryHeavyRain: return "매우 강한 비가 내려요"
        case .extremeRain: return "극심한 비가 내려요"
        case .freezingRain: return "얼어붙는 비가 내려요"
        case .lightIntensityShowerRain: return "약한 소나기가 내려요"
        case .showerRain: return "소나기가 내려요"
        case .heavyIntensityShowerRain: return "강한 소나기가 내려요"
        case .raggedShowerRain: return "불규칙한 소나기가 내려요"
            
            // Snow
        case .lightSnow: return "약한 눈이 내려요"
        case .snow: return "눈이 내려요"
        case .heavySnow: return "많은 눈이 내려요"
        case .sleet: return "진눈깨비가 내려요"
        case .lightShowerSleet: return "약한 소나기 진눈깨비가 내려요"
        case .showerSleet: return "소나기 진눈깨비가 내려요"
        case .lightRainAndSnow: return "약한 비와 눈이 섞여 내려요"
        case .rainAndSnow: return "비와 눈이 섞여 내려요"
        case .lightShowerSnow: return "약한 소나기 눈이 내려요"
        case .showerSnow: return "소나기 눈이 내려요"
        case .heavyShowerSnow: return "강한 소나기 눈이 내려요"
            
            // Atmosphere
        case .mist: return "안개가 자욱해요"
        case .smoke: return "연기가 껴 있어요"
        case .haze: return "실안개가 끼었어요"
        case .sandDustWhirls: return "모래나 먼지가 휘몰아쳐요"
        case .fog: return "짙은 안개가 있어요"
        case .sand: return "모래바람이 불어요"
        case .dust: return "먼지가 많아요"
        case .volcanicAsh: return "화산재가 퍼져 있어요"
        case .squalls: return "돌풍이 불어요"
        case .tornado: return "토네이도가 발생했어요"
            
            // Clear / Clouds
        case .clearSky: return "오늘은 맑아요"
        case .fewClouds: return "맑은 하늘에 구름이 조금 있어요"
        case .scatteredClouds: return "구름이 흩어져 있어요"
        case .brokenClouds: return "구름이 많이 낀 하늘이에요"
        case .overcastClouds: return "구름이 완전히 뒤덮였어요"
        }
    }
}
