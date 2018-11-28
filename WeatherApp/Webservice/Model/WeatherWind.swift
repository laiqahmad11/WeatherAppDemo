//
//  WeatherWind.swift
//  WeatherApp
//
//  Created by EasyPay on 17/10/18.
//  Copyright © 2018 Hype Ten. All rights reserved.
//

import Foundation

class WeatherWind: Mappable {
    
    var speed: Double = 0.0
    var deg: Double = 0.0
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        speed <- map["speed"]
        deg <- map["deg"]
    }
}
