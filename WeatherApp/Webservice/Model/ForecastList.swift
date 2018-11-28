//
//  ForcastList.swift
//  WeatherApp
//
//  Created by EasyPay on 17/10/18.
//  Copyright © 2018 Hype Ten. All rights reserved.
//

import Foundation

class ForecastList: Mappable {
    
    var dt: NSNumber?
    var dt_txt: String?
    
    var main: WeatherTemp?
    var weatherInfo: [WeatherInfo]?
    var clouds: WeatherClouds?
    var wind: WeatherWind?
    var sys:  WeatherSys?
    
    // Multiple city ID response data
    var id: Int = 0
    var name: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        dt_txt <- map["dt_txt"]
        dt <- map["dt"]
        main <- map["main"]
        weatherInfo <- map["weather"]
        clouds <- map["clouds"]
        wind <- map["wind"]
        sys <- map["sys"]
        id <- map["id"]
        name <- map["name"]
    }
}
