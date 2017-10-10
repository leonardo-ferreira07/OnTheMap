//
//  UserClient.swift
//  OnTheMap
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 10/10/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import Foundation

struct UserClient {
    
    static func getUserData(withId id: String, completion: @escaping (_ success: Bool) -> Void) {
        let url = APIClient.buildURL(withHost: Constants.apiHostUdacity, withPathExtension: Constants.apiPathUdacityUserData + "/" + id)
        
        _ = APIClient.performRequestReturnsData(url, ignore5First: true, completion: { (data, error) in
            guard let data = data else {
                completion(false)
                return
            }
            
            completion(true)
            
//            if let decoded = try? JSONDecoder().decode(Session.self, from: data) {
//                MemoryStorage.shared.session = decoded
//                completion(true)
//            }
        }) {
            
        }
    }
    
    
}
