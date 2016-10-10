//
//  ViewController.swift
//  HealthApp
//
//  Created by Niranjan Ravichandran on 10/7/16.
//  Copyright © 2016 uncc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let appdelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.layer.cornerRadius = 18
        usernameTextField.layer.borderWidth = 1
        usernameTextField.layer.borderColor = Utility.dayButtonHighlightColor.cgColor
        passwordTextfield.layer.cornerRadius = 18
        passwordTextfield.layer.borderWidth = 1
        passwordTextfield.layer.borderColor = Utility.dayButtonHighlightColor.cgColor
        
        usernameTextField.text = "P103"
        passwordTextfield.text = "p103"
        
        loginButton.layer.cornerRadius = 18
        loginButton.addTarget(self, action: #selector(self.loginUser), for: .touchUpInside)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginUser() {
        if usernameTextField.text != "" && passwordTextfield.text != "" {
            NetworkManager.sharedManager.loginWithUsername(username: usernameTextField.text!, password: passwordTextfield.text!, onsuccess: { currentUser in
                self.appdelegate.currentUser = currentUser
                let firstVc = self.storyboard?.instantiateViewController(withIdentifier: "FirstViewController")
                self.present(UINavigationController(rootViewController: firstVc!), animated: true, completion: nil)
            }) {
                //Handle error here
                Utility.showAlert(with: "Error", message: "Invalid User credentails", viewController: self)
            }
        }else {
            Utility.showAlert(with: "Alert", message: "Please enter suername and password.", viewController: self)
        }
    }

}

