//
//  TodayForcastRequest.swift
//  WeatherApp
//
//  Created by Darshan Patel on 16/10/18.
//  Copyright © 2018 Hype Ten. All rights reserved.
//

import Foundation

class TodayForcastReq: BaseRequest {
    
    var latitude: NSNumber?
    var longitude: NSNumber?
    var units: String?
    
    override init() {
        super.init()
    }
    
    override public func parameters() -> [String: Any] {
        
        var params = super.parameters()
        
        if let latitude = self.latitude {
            params["lat"] = latitude
        }
        
        if let longitude = self.longitude {
            params["lon"] = longitude
        }
        
        if let units = self.units, !units.isEmpty {
            params["units"] = units
        }
        
        return params
    }
}
