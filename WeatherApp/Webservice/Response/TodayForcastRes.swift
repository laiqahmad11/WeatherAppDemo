//
//  TodayForcastRes.swift
//  WeatherApp
//
//  Created by Darshan Patel on 16/10/18.
//  Copyright © 2018 Hype Ten. All rights reserved.
//

import Foundation

class TodayForcastRes: APIResponse {
    
     var dt: NSNumber?
     var id: Int = 0
     var name: String?
     var lat: NSNumber?
     var lon: NSNumber?
     var sys: WeatherSys?
     var weatherInfo: [WeatherInfo]?
     var main: WeatherTemp?
     var wind: WeatherWind?
     var rain: WeatherRain?
     var clouds: WeatherClouds?
     var visibility: Int = 0
    
    override func mapping(map: Map) {
        
        super.mapping(map: map)
        dt <- map["dt"]
        id <- map["id"]
        name <- map["name"]
        lat <- map["coord.lat"]
        lon <- map["coord.lon"]
        sys <- map["sys"]
        weatherInfo <- map["weather"]
        main <- map["main"]
        wind <- map["wind"]
        rain <- map["rain"]
        clouds <- map["clouds"]
        visibility <- map["visibility"]
    }
}

