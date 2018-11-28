import Foundation
import CoreData
extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var cityId: Int32
    @NSManaged public var cityName: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var temperature: Double
    @NSManaged public var updatedTime: Int64

}
