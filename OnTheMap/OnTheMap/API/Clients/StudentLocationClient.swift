//
//  StudentLocationClient.swift
//  OnTheMap
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 10/10/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import Foundation

struct StudentLocationClient {
    
    static fileprivate let headers: [String: String] = ["X-Parse-Application-Id": "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", "X-Parse-REST-API-Key": "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"]
    
    static func getStudentsLocations(_ completion: @escaping (_ success: Bool) -> Void) {
        let url = APIClient.buildURL(["limit": "100", "order": "-updatedAt"] as [String: AnyObject], withHost: Constants.apiHostParseClasses, withPathExtension: Constants.apiPathUdacityParseStudentLocations)
        
        _ = APIClient.performRequest(url, headerValues: headers, completion: { (dict, error) in
            
            guard let dict = dict else {
                completion(false)
                return
            }
            
            if let array = dict[StudentLocationKeys.results.rawValue] as? [[String: AnyObject]] {
                MemoryStorage.shared.studentsLocations.removeAll()
                for object in array {
                    MemoryStorage.shared.studentsLocations.append(StudentLocation(withDictionary: object))
                }
                completion(true)
            } else {
                completion(false)
            }
            
        }) {
            
        }
    }
    
    static func postStudentLocation(_ completion: @escaping (_ success: Bool) -> Void) {
        
        guard let id = MemoryStorage.shared.session?.account.id, let firstName = MemoryStorage.shared.user?.user.firstName, let lastName = MemoryStorage.shared.user?.user.lastName else {
            completion(false)
            return
        }
        
        let url = APIClient.buildURL(withHost: Constants.apiHostParseClasses, withPathExtension: Constants.apiPathUdacityParseStudentLocations)
        
        let jsonBody = ["uniqueKey": id,
                        "firstName": firstName,
                        "lastName": lastName,
                        "mapString": "Mountain View, CA",
                        "mediaURL": "https://udacity.com",
                        "latitude": 37.386052,
                        "longitude": -122.083851] as [String: AnyObject]
        
        _ = APIClient.performRequest(url, method: .POST, jsonBody: jsonBody, headerValues: headers, completion: { (dict, error) in
            
            guard dict != nil else {
                completion(false)
                return
            }
            
            completion(true)
            
        }) {
            
        }
    }
    
}
