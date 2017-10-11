//
//  ParserHelper.swift
//  OnTheMap
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 11/10/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import Foundation

// MARK: - Parser Helpers

struct ParserHelper {
    
    static func getString(from object: AnyObject?) -> String {
        if let stringValue = object as? String {
            return stringValue
        } else {
            return ""
        }
    }
    
    static func getDouble(from object: AnyObject?) -> Double {
        if let doubleValue = object as? Double {
            return doubleValue
        } else {
            return 0.0
        }
    }
    
}
