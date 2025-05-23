import Foundation

struct ForecastWeather: Decodable {
    let list: [List]
}

extension ForecastWeather {
    
    struct List: Decodable {
        let main: Main
        let weather: [Weather]
        let pop: Double
        let dtTxt: String

        enum CodingKeys: String, CodingKey {
            case main, weather, pop
            case dtTxt = "dt_txt"
        }
    }
}

extension ForecastWeather.List {
    
    struct Main: Decodable {
        let temp, tempMin, tempMax: Double
        
        enum CodingKeys: String, CodingKey {
            case temp
            case tempMin = "temp_min"
            case tempMax = "temp_max"
        }
    }
    
    struct Weather: Decodable {
        let description, icon: String
    }
}
