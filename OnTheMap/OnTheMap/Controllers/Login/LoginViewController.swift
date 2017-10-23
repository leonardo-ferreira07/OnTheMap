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
        resignTextFields()
        self.view.startLoadingAnimation()
        if let email = emailTextField.text, let password = passwordTextField.text, email.isValidEmail(), password.characters.count > 0 {
            SessionClient.postSession(withEmail: email, password: password, completion: { (success) in
                if success {
                    
                    UserClient.getUserData(withId: MemoryStorage.shared.session?.account.id ?? "", completion: { (success) in
                        if success {
                            self.view.stopLoadingAnimation()
                            self.performSegue(withIdentifier: "goMainStoryboard", sender: nil)
                            print("success login")
                        } else {
                            self.showAlert("Login Error", message: "Opsss, we got an error trying to fetch your user data.")
                        }
                    })
                    
                } else {
                    self.showAlert("Login Error", message: "Email or password does not match.")
                }
            })
        } else {
            showAlert("Login Error", message: "Email or password is not in the correct format.")
        }
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        presentWebPageInSafari(withURLString: Constants.urlSignUp)
    }
    
}

// MARK: - TextFields configs

extension LoginViewController {
    func resignTextFields() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}
