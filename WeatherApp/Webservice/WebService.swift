//
//  WebService.swift
//  WeatherApp
//
//  Created by Darshan Patel on 16/10/18.
//  Copyright © 2018 Hype Ten. All rights reserved.
//

import Foundation

import Alamofire

class WebService {
    
    static let sharedInstance = WebService()
    
    private init() {}
    
    // MARK: GET Request
    func doCallGetAPI<T: Mappable>(_ url: String!, params: [String: Any], completion: @escaping (T?, Result<String>) -> Void ) {
        
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil)
            
            .responseString { response in
                
                switch response.result {
                    
                case .success(let value):
                    
                    if let dataInfo = value.convertToDictionary() {
                        let generateResponse = T(JSON: dataInfo)
                        completion(generateResponse!, response.result)
                        
                    } else {
                        completion(nil, response.result)
                    }
                    
                case .failure:
                    completion(nil, response.result)
                }
        }
    }
}
