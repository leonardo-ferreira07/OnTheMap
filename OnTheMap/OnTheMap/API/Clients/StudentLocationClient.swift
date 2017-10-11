//
//  StudentLocationClient.swift
//  OnTheMap
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 10/10/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import Foundation

struct StudentLocationClient {
    
    static func getStudentsLocations(_ completion: @escaping (_ success: Bool) -> Void) {
        let url = APIClient.buildURL(["limit": "100"] as [String: AnyObject], withHost: Constants.apiHostParseClasses, withPathExtension: Constants.apiPathUdacityParseStudentLocations)
        
        let headers: [String: String] = ["X-Parse-Application-Id": "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", "X-Parse-REST-API-Key": "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"]
        
        _ = APIClient.performRequest(url, headerValues: headers, completion: { (dict, error) in
            
            guard let dict = dict else {
                completion(false)
                return
            }
            
            if let array = dict[StudentLocationKeys.results.rawValue] as? [[String: AnyObject]] {
                for object in array {
                    MemoryStorage.shared.studentsLocations.removeAll()
                    MemoryStorage.shared.studentsLocations.append(StudentLocation(withDictionary: object))
                    print(MemoryStorage.shared.studentsLocations)
                }
            }
            
        }) {
            
        }
    }
    
}
