enum WeatherDescriptionTranslator: String, Codable {
    
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case scatteredClouds = "scattered clouds"
    case brokenClouds = "broken clouds"
    case showerRain = "shower rain"
    case rain
    case thunderstorm
    case snow
    case mist
    
    var displayName: String {
        switch self {
        case .clearSky: return "오늘은 맑아요"
        case .fewClouds: return "맑은 하늘에 구름이 조금 있어요"
        case .scatteredClouds: return "구름이 흩어져 있어요"
        case .brokenClouds: return "구름이 많이 낀 하늘이에요"
        case .showerRain: return "소나기가 내릴 수 있어요"
        case .rain: return "비가 내려요"
        case .thunderstorm: return "천둥번개를 동반한 비가 내려요"
        case .snow: return "눈이 내려요"
        case .mist: return "안개가 자욱해요"
        }
    }

    static func getKoreanDescription(for englishDescription: String) -> String {
        // 영어 설명에 해당하는 case의 한글 설명(displayName)을 반환하고, 일치하는 case가 없을 경우 입력값 그대로 출력
        return WeatherDescriptionTranslator(rawValue: englishDescription.lowercased())?.displayName ?? englishDescription
    }
}
