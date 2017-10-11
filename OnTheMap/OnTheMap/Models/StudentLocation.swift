//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 11/10/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import Foundation

struct StudentLocation {
    
    var firstName: String
    var lastName: String
    var createdAt: String
    var latitude: Double
    var longitude: Double
    var mapString: String
    var mediaURL: String
    var objectId: String
    var uniqueKey: String
    var updatedAt: String
    
    init(withDictionary dictionary: [String: AnyObject]) {
        
        self.firstName = ParserHelper.getString(from: dictionary[StudentLocationKeys.firstName.rawValue])
        self.lastName = ParserHelper.getString(from: dictionary[StudentLocationKeys.lastName.rawValue])
        self.createdAt = ParserHelper.getString(from: dictionary[StudentLocationKeys.createdAt.rawValue])
        self.latitude = ParserHelper.getDouble(from: dictionary[StudentLocationKeys.latitude.rawValue])
        self.longitude = ParserHelper.getDouble(from: dictionary[StudentLocationKeys.longitude.rawValue])
        self.mapString = ParserHelper.getString(from: dictionary[StudentLocationKeys.mapString.rawValue])
        self.mediaURL = ParserHelper.getString(from: dictionary[StudentLocationKeys.mediaURL.rawValue])
        self.objectId = ParserHelper.getString(from: dictionary[StudentLocationKeys.objectId.rawValue])
        self.uniqueKey = ParserHelper.getString(from: dictionary[StudentLocationKeys.uniqueKey.rawValue])
        self.updatedAt = ParserHelper.getString(from: dictionary[StudentLocationKeys.updatedAt.rawValue])
        
    }
    
}

// MARK: - StudentLocation Keys

enum StudentLocationKeys: String {
    
    case results
    
    case firstName
    case lastName
    case createdAt
    case latitude
    case longitude
    case mapString
    case mediaURL
    case objectId
    case uniqueKey
    case updatedAt
    
}
