import Foundation
import CoreData

class CoreDataQuery {
    
    static let sharedInstance = CoreDataQuery()
    
    let dbManager = CoreDataManager(modelName: "WeatherData")
    var managedObjectContext : NSManagedObjectContext? = nil
    
    private init() {}
    
    func coreDataStorage() {
        
        managedObjectContext = dbManager.managedObjectContext
    }
    
    func fetchAllCities() -> [City]? {
        
        let cityRecords = self.dbManager.fetchRecords(type: City.self)
        return cityRecords
    }
    
    func insertCity(response: TodayForcastRes) throws -> City? {
        
        guard let managedObjectContext = managedObjectContext else {
            return nil
        }
        
        guard let createRecord = dbManager.createRecord(type: City.self) else {
            return nil
        }
        
        let createRecordDB = createRecord
        
        createRecordDB.cityId = Int32(response.id)
        
        if let cityName = response.name {
            print("insertCity: " + cityName)
            createRecordDB.cityName = cityName
        }
        
        if let lat = response.lat {
            createRecordDB.latitude = lat.doubleValue
        }
        
        if let lon = response.lon {
            createRecordDB.longitude = lon.doubleValue
        }
        
        if let time = response.dt {
            createRecordDB.updatedTime = time.int64Value
        }

        if let main = response.main {
            createRecordDB.temperature = main.temp
        }

        try managedObjectContext.save()
        
        return createRecordDB
    }
    
    func updateCity(response: TodayForcastRes, categoryDB: City) throws {
        
        guard let managedObjectContext = managedObjectContext else {
            return
        }
        
        let updateRecord = categoryDB
        
        
        if let cityName = response.name {
            print("update City: " + cityName)
            updateRecord.cityName = cityName
        }
        
        if let lat = response.lat {
            updateRecord.latitude = lat.doubleValue
        }
        
        if let lon = response.lon {
            updateRecord.longitude = lon.doubleValue
        }
        
        if let time = response.dt {
            updateRecord.updatedTime = time.int64Value
        }

        
        if let main = response.main {
            updateRecord.temperature = main.temp
        }

        try managedObjectContext.save()
    }
    
    func updateCityByGroupResponse(city: ForecastList, cityRecord: City) throws {
        
        guard let managedObjectContext = managedObjectContext else {
            return
        }
        
        let updateRecord = cityRecord
        
        if let cityName = city.name {
            updateRecord.cityName = cityName
        }
        
        if let time = city.dt {
            updateRecord.updatedTime = time.int64Value
        }
        
        if let main = city.main {
            updateRecord.temperature = main.temp
        }
        
        try managedObjectContext.save()
    }
    func deleteCity(city: City) throws {
        
        guard let managedObjectContext = managedObjectContext else {
            return
        }
        
        managedObjectContext.delete(city)
        
        try managedObjectContext.save()
        
    }
    
    func deleteAllCities() throws {
      
        guard let managedObjectContext = managedObjectContext else {
            return
        }
        
        guard let cities = dbManager.fetchRecords(type: City.self) else {
            return
        }
        
        for city in cities {
            managedObjectContext.delete(city)
        }
        
        try managedObjectContext.save()
    }
}
