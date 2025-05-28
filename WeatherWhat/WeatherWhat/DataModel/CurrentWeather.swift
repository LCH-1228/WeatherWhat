import Foundation

struct CurrentWeather: Decodable {
    let weather: [Weather]
    let main: Main
}

extension CurrentWeather {
    
    struct Weather: Decodable {
        let description: WeatherDescriptionTranslator
        let icon: String
    }
    
    struct Main: Decodable {
        let temp, tempMin, tempMax: Double

        enum CodingKeys: String, CodingKey {
            case temp
            case tempMin = "temp_min"
            case tempMax = "temp_max"
        }
    }
}
