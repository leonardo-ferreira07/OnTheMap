//
//  ViewController.swift
//  OnTheMap
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 09/10/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        StudentLocationClient.getStudentsLocations { (success) in
            print(success)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func deleteSessionPressed(_ sender: Any) {
        SessionClient.deleteSession { (success) in
            if success {
                print("session deleted successfully")
            }
        }
    }
    
}

