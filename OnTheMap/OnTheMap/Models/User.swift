//
//  User.swift
//  OnTheMap
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 10/10/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import Foundation

struct User: Codable {
    
    let user: UserDetails
    
}

struct UserDetails: Codable {
    
    let firstName: String
    let lastName: String
    
    private enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
    }
    
}
