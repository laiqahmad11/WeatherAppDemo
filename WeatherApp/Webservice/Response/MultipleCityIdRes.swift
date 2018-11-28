//
//  MultipleCityIdRes.swift
//  WeatherApp
//
//  Created by EasyPay on 19/10/18.
//  Copyright © 2018 Darshan Patel. All rights reserved.
//

import Foundation

class MultipleCityIdRes: APIResponse {
    
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
