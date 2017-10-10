//
//  SessionClient.swift
//  OnTheMap
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 10/10/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import Foundation

struct SessionClient {
    
    static func postSession(_ completion: @escaping (_ success: Bool) -> Void) {
        let url = APIClient.buildURL(withHost: Constants.apiHostUdacity, withPathExtension: Constants.apiPathUdacitySession)
        let jsonBody = ["udacity": ["username": "account@domain.com", "password": "********"]] as [String: AnyObject]
        
        _ = APIClient.performRequestReturnsData(url, method: .POST, jsonBody: jsonBody, ignore5First: true, completion: { (data, error) in
            guard let data = data else {
                completion(false)
                return
            }
            
            if let decoded = try? JSONDecoder().decode(Session.self, from: data) {
                MemoryStorage.shared.session = decoded
                completion(true)
            }
        }) {
            
        }
    }
    
    
}
