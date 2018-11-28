//
//  WeatherClouds.swift
//  WeatherApp
//
//  Created by EasyPay on 17/10/18.
//  Copyright © 2018 Hype Ten. All rights reserved.
//

import Foundation

class WeatherClouds: Mappable {
    
    var all: NSNumber?
   
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        all <- map["all"]
      
    }
}
