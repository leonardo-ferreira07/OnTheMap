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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeFromKeyboardNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Actions
    
    @IBAction func deleteSessionPressed(_ sender: Any) {
        self.view.startLoadingAnimation()
        logoutButton(enabled: false)
        SessionClient.deleteSession { (success) in
            self.logoutButton(enabled: true)
            self.view.stopLoadingAnimation()
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                self.showAlert("Logout Error", message: "Opsss. Error while trying to log you out.")
            }
        }
    }
    
    @IBAction func refreshStudentsLocationsPressed(_ sender: Any) {
        
    }
    
    @IBAction func addStudentLocationPressed(_ sender: Any) {
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
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

// MARK: - Keyboard notifications

extension BaseOnTheMapViewController {
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
}
