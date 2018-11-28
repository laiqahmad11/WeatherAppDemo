
import Foundation
import CoreLocation

class LocationDetail {
    var cityName: String!
    var coordinate: CLLocationCoordinate2D
    
    init() {
        self.cityName = ""
        self.coordinate = CLLocationCoordinate2DMake(0, 0)
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let _copy = LocationDetail()
        _copy.coordinate = coordinate
        _copy.cityName = cityName
        return _copy
    }
}
