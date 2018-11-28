//
//  FiveDaysForecastRes.swift
//  WeatherApp
//
//  Created by Darshan Patel on 16/10/18.
//  Copyright © 2018 Hype Ten. All rights reserved.
//

import Foundation

class FiveDaysForecastRes: APIResponse {
    
    var message: NSNumber?
    var cnt: NSNumber?
    var city: WeatherCity?
    var list: [ForecastList]?
    
    override func mapping(map: Map) {
        
        super.mapping(map: map)
        
        city <- map["city"]
        list <- map["list"]
        message <- map["message"]
        cnt <- map["cnt"]
        
    }
}


