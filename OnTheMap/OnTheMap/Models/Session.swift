//
//  Session.swift
//  OnTheMap
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 10/10/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import Foundation

struct Session: Codable {
    
    let account: Account
    let session: SessionInfos
    
}

struct Account: Codable {
    let registered: Bool
    let id: String
    
    private enum CodingKeys: String, CodingKey {
        case registered
        case id = "key"
    }
}

struct SessionInfos: Codable {
    let id: String
    let expiration: String
}
