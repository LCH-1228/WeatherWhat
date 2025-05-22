import Foundation

enum WeatherDescriptionTranslator {
    // private으로 외부에서 직접 호출하는 것을 방지하고, 인스턴스 없이도 값을 사용하기 위해 static으로 정의
    private static let koreanDescription: [String: String] = [
        "clear sky": "오늘은 맑아요",
        "few clouds": "맑은 하늘에 구름이 조금 있어요",
        "scattered clouds": "구름이 흩어져 있어요",
        "broken clouds": "구름이 많이 낀 하늘이에요",
        "shower rain": "소나기가 내릴 수 있어요",
        "rain": "비가 내려요",
        "thunderstorm": "천둥번개를 동반한 비가 내려요",
        "snow": "눈이 내려요",
        "mist": "안개가 자욱해요"
    ]
    
    static func getKoreanDescription(for englishDescription: String) -> String {
        // englishDescription 값을 받아서 소문자로 변환 후 해당하는 값을 가져오고, 없을 경우 입력값 그대로 반환
        return koreanDescription[englishDescription.lowercased()] ?? englishDescription
    }
}
