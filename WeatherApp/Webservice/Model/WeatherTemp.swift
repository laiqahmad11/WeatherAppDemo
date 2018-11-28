//
//  WeatherTemp.swift
//  WeatherApp
//
//  Created by EasyPay on 17/10/18.
//  Copyright © 2018 Hype Ten. All rights reserved.
//

import Foundation

class WeatherTemp: Mappable {
    
    var temp: Double = 0.0
    var humidity: Int = 0
    var pressure: Int = 0
    var temp_min: Int = 0
    var temp_max: Int = 0
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        temp <- map["temp"]
        humidity <- map["humidity"]
        pressure <- map["pressure"]
        temp_min <- map["temp_min"]
        temp_max <- map["temp_max"]
    }
}
