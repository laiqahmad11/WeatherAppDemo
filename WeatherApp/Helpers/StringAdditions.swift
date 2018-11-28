
import Foundation

extension String {
    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

/*
 func fetchLocation(){
 Locator.currentPosition(accuracy: .city, onSuccess: { (location) -> (Void) in
 
 self.fetchTodayForecast(lat: location.coordinate.latitude, long: location.coordinate.longitude)
 
 }) { (error, last) -> (Void) in
 switch error {
 case .denied: break
 
 case .timedout: break
 
 case .notDetermined: break
 
 case .restricted: break
 
 case .disabled: break
 
 case .error: break
 
 case .other(_): break
 
 case .dataParserError: break
 
 case .missingAPIKey(let _): break
 
 case .failedToObtainData: break
 
 }
 }
 }*/
