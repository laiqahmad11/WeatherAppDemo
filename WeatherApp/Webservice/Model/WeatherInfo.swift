//
//  WeatherInfo.swift
//  WeatherApp
//
//  Created by Darshan Patel on 17/10/18.
//  Copyright © 2018 Hype Ten. All rights reserved.
//

import Foundation

class WeatherInfo: Mappable {
    
    var id: NSNumber?
    var main: String?
    var description: String?
    var icon: String?
   
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        id <- map["id"]
        main <- map["main"]
        description <- map["description"]
        icon <- map["icon"]
    }
}
