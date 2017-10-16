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
        
        SessionClient.postSession { (success) in
            print(success)
            if success {
                UserClient.getUserData(withId: MemoryStorage.shared.session?.account.id ?? "", completion: { (success1) in
                    print(success1)
                    print(MemoryStorage.shared.user?.user.firstName)
                    
                    StudentLocationClient.postStudentLocation({ (success) in
                        print(success)
                    })
                })
            }
        }
        
        StudentLocationClient.getStudentsLocations { (success) in
            print(success)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

