//
//  WeatherCity.swift
//  WeatherApp
//
//  Created by EasyPay on 17/10/18.
//  Copyright © 2018 Hype Ten. All rights reserved.
//

import Foundation

class WeatherCity: Mappable {
    
    var id: NSNumber?
    var name: String?
    var country: String?
    var population: NSNumber?
    var latitude: NSNumber?
    var longitude: NSNumber?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        country <- map["country"]
        population <- map["population"]
        latitude <- map["coord.lat"]
        longitude <- map["coord.lon"]
    }
}
