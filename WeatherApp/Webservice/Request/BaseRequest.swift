//
//  BaseRequest.swift
//  WeatherApp
//
//  Created by Darshan Patel on 16/10/18.
//  Copyright © 2018 Hype Ten. All rights reserved.
//

import Foundation

class BaseRequest {
    
    /// apiKey in string
    var apiKey: String = Constants.APIkey
    
    init() {
        
    }
    
    /**
     
     This function will be used for Creating dictionary with API parameters
     
     @return dictionary of parameters
     
     */
    
    public func parameters() -> [String: Any] {
        var params = [String: Any]()
        
        params["appid"] = self.apiKey
        
        return params
    }
    
}
