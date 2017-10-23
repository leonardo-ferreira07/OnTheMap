//
//  OnTheMapViewController.swift
//  OnTheMap
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 23/10/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import UIKit

class BaseOnTheMapViewController: UIViewController {
    
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var refreshButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Actions
    
    @IBAction func deleteSessionPressed(_ sender: Any) {
        logoutButton(enabled: false)
        SessionClient.deleteSession { (success) in
            self.logoutButton(enabled: true)
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func refreshStudentsLocationsPressed(_ sender: Any) {
        
    }
    
    @IBAction func addStudentLocationPressed(_ sender: Any) {
        
    }
    
}

// MARK: - UI Controls

extension BaseOnTheMapViewController {
    func logoutButton(enabled: Bool) {
        logoutButton.isEnabled = enabled
    }
    
    func refreshButton(enabled: Bool) {
        refreshButton.isEnabled = enabled
    }
}
