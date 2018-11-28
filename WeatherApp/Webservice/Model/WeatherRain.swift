//
//  WeatherRain.swift
//  WeatherApp
//
//  Created by EasyPay on 17/10/18.
//  Copyright © 2018 Hype Ten. All rights reserved.
//

import Foundation

class WeatherRain: Mappable {
    
    var threeHours: Int = 0
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        threeHours <- map["3h"]
        
    }
}
