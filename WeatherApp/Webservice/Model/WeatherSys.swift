//
//  WeatherSys.swift
//  WeatherApp
//
//  Created by EasyPay on 17/10/18.
//  Copyright © 2018 Hype Ten. All rights reserved.
//

import Foundation

class WeatherSys: Mappable {
    
    var country: String?
    var sunrise: NSNumber?
    var sunset: NSNumber?
    var pod: String?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        country <- map["country"]
        sunrise <- map["sunrise"]
        sunset <- map["sunset"]
        pod <- map["pod"]
        
    }
}
