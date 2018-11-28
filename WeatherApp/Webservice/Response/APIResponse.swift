//
//  APIResponse.swift
//  WeatherApp
//
//  Created by Darshan Patel on 16/10/18.
//  Copyright © 2018 Hype Ten. All rights reserved.
//

import Foundation

class APIResponse: NSObject, Mappable {
    
    let transform = TransformOf<Int, String>(fromJSON: { (value: String?) -> Int? in
        return Int(value!)
    }, toJSON: { (value: Int?) -> String? in
        if let value = value {
            return String(value)
        }
        return nil
    })
    /// status code returned from the API
    var statusCode: Int = -1
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init()
    }
    
    /// This function is the mapping function for mapping of json keys into model variables
    func mapping(map: Map) {
        if let _ = map.JSON["cod"] as? Int {
            statusCode <- map["cod"]
        } else {
            statusCode <- (map["cod"], transform)
        }
        
    }
}
