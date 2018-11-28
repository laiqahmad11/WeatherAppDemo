//
//  MultipleCityIdReq.swift
//  WeatherApp
//
//  Created by EasyPay on 19/10/18.
//  Copyright © 2018 Darshan Patel. All rights reserved.
//

import Foundation

class MultipleCityIdReq: BaseRequest {
    
    var id: String?
    var units: String?
    
    override init() {
        super.init()
    }
    
    override public func parameters() -> [String: Any] {
        
        var params = super.parameters()
        
        if let id = self.id {
            params["id"] = id
        }

        if let units = self.units, !units.isEmpty {
            params["units"] = units
        }
        return params
    }
}
