//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 16/10/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import UIKit

class LoginViewController: BaseOnTheMapViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var topLogoConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackView: UIStackView!
    
    
    let reachability = Reachability()!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Actions
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        resignTextFields()
        self.view.startLoadingAnimation()
        
        guard reachability.connection != .none else {
            self.showAlert("Connection Error", message: "Seems that you don't have internet connection.")
            return
        }
        if let email = emailTextField.text, let password = passwordTextField.text, email.isValidEmail(), password.characters.count > 0 {
            SessionClient.postSession(withEmail: email, password: password, completion: { (success) in
                if success {
                    
                    UserClient.getUserData(withId: MemoryStorage.shared.session?.account.id ?? "", completion: { (success) in
                        if success {
                            self.view.stopLoadingAnimation()
                            self.performSegue(withIdentifier: "goMainStoryboard", sender: nil)
                            print("success login")
                        } else {
                            self.view.stopLoadingAnimation()
                            self.showAlert("Login Error", message: "Opsss, we got an error trying to fetch your user data.")
                        }
                    })
                    
                } else {
                    self.view.stopLoadingAnimation()
                    self.showAlert("Login Error", message: "Email or password does not match.")
                }
            })
        } else {
            self.view.stopLoadingAnimation()
            showAlert("Login Error", message: "Email or password is not in the correct format.")
        }
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        presentWebPageInSafari(withURLString: Constants.urlSignUp)
    }
    
    override func keyboardWillShow(_ notification: Notification) {
        self.topLogoConstraint.constant = -92
        self.stackView.spacing = 4
    }
    
    override func keyboardWillHide(_ notification: Notification) {
        self.topLogoConstraint.constant = 92
        self.stackView.spacing = 10
    }
    
}

// MARK: - TextFields configs

extension LoginViewController {
    func resignTextFields() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
}
