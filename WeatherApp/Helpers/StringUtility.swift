
import Foundation

class StringUtility {
    
    static func getTime(timeInterval: Int, isMinute: Bool) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timeInterval))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = TimeZone.current
        if isMinute == true {
            dateFormatter.dateFormat = "hh:MM a"
        }else{
            dateFormatter.dateFormat = "h a"
        }
        return dateFormatter.string(from: date)
    }
    
    static func getHour(timeInterval: Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(timeInterval))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = TimeZone.current
        let hour = dateFormatter.calendar.component(.hour, from: date as Date)
        return "\(hour)"
    }
    
    static func windDirection(degrees: Double) -> String {
        var directions =  ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
        let i = Int((degrees + 11.25) / 22.5)
        return directions[i % 16]
    }
    
    static func getDayName(timeInterval: Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(timeInterval))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat  = "EEEE"
        return dateFormatter.string(from: date as Date)
    }
    
    static func getImageUrl(logo: String) -> String{
        let url = "\(APIUrl.ImageUrl)\(logo).png"
        return url
    }
    
    static func getTemperature(temperature: Double) -> String {
            return"\(temperature)\u{00B0}"
    }
    
    static func getVisibility(visibility: Int) -> String {
        return "\(visibility / 1000) Km"
    }
    
    static func getPresure(presure: Int) -> String {
        return "\(presure) hPa"
    }
    
    static func getRainChances(rainChances: Int) -> String {
        return "\(rainChances)%"
    }
    
    static func getHumidity(humidity: Int) -> String {
        return "\(humidity)%"
    }
    
    static func getWind(degrees: Double, speed: Double) -> String {
        return "\(StringUtility.windDirection(degrees: degrees)) \(speed) km/hr"
    }
    
    
    
}
