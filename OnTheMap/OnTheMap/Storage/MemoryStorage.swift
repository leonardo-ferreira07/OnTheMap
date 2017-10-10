//
//  MemoryStorage.swift
//  OnTheMap
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 10/10/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import Foundation

class MemoryStorage {
    
    static let shared = MemoryStorage()
    
    private init() {}
    
    var session: Session?
}
