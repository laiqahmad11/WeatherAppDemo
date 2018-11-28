//
//  APIUrl.swift
//  WeatherApp
//
//  Created by Darshan Patel on 16/10/18.
//  Copyright © 2018 Hype Ten. All rights reserved.
//

import Foundation

struct APIUrl{
    static let BaseURL = "http://api.openweathermap.org/"
    static let TodayForcast = "\(APIUrl.BaseURL)data/2.5/weather"
    static let FiveDaysForcast = "\(APIUrl.BaseURL)data/2.5/forecast"
    static let MultipleCityGroup = "\(APIUrl.BaseURL)data/2.5/group"
    
    static let ImageUrl = "http://openweathermap.org/img/w/"
}
