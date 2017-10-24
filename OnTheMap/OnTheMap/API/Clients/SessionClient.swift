//
//  SessionClient.swift
//  OnTheMap
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 10/10/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import Foundation

struct SessionClient {
    
    static fileprivate let url = APIClient.buildURL(withHost: Constants.apiHostUdacity, withPathExtension: Constants.apiPathUdacitySession)
    
    static func postSession(withEmail email: String, password: String, completion: @escaping (_ error: Error?) -> Void) {
        
        let jsonBody = ["udacity": ["username": email, "password": password]] as [String: AnyObject]
        
        _ = APIClient.performRequestReturnsData(url, method: .POST, jsonBody: jsonBody, ignore5First: true, completion: { (data, error) in
            guard let data = data else {
                completion(error)
                return
            }
            
            if let decoded = try? JSONDecoder().decode(Session.self, from: data) {
                MemoryStorage.shared.session = decoded
                completion(nil)
            }
        }) {
            
        }
    }
    
    static func deleteSession(_ completion: @escaping (_ success: Bool) -> Void) {
        
        var headers: [String: String] = [:]
        
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies where cookie.name == "XSRF-TOKEN" {
                headers["X-XSRF-TOKEN"] = cookie.value
            }
        }
        
        _ = APIClient.performRequestReturnsData(url, method: .DELETE, ignore5First: true, completion: { (data, error) in
            guard data != nil else {
                completion(false)
                return
            }
            
            completion(true)
        }) {
            
        }
    }
    
    
}
