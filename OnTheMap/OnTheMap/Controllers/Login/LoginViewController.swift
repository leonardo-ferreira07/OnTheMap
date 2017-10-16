//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 16/10/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Actions
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text, email.characters.count > 0 && password.characters.count > 0 {
            SessionClient.postSession(withEmail: email, password: password, completion: { (success) in
                if success {
                    self.performSegue(withIdentifier: "goMainStoryboard", sender: nil)
                    print("success login")
                }
            })
        }
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        
    }
    
    

}
