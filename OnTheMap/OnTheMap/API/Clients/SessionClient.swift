//
//  SessionClient.swift
//  OnTheMap
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 10/10/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import Foundation

struct SessionClient {
    
    static func postSession() {
        let url = APIClient.buildURL(withHost: Constants.apiHostUdacity, withPathExtension: Constants.apiPathUdacitySession)
        let jsonBody = ["udacity": ["username": "**", "password": "***"]] as [String: AnyObject]
        
        _ = APIClient.performRequest(url, method: .POST, jsonBody: jsonBody, completion: { (dict, error) in
            print(dict)
        }) {
            
        }
    }
    
    
}
