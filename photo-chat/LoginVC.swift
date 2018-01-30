//
//  LoginVC.swift
//  photo-chat
//
//  Created by Andrew McGovern on 1/26/18.
//  Copyright © 2018 Andrew McGovern. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var emailField: RounTextField!

    @IBOutlet weak var passwordField: RounTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // Actions

    @IBAction func loginPressed(_ sender: Any) {
        if let email = emailField.text, let pass = passwordField.text, (email.characters.count > 0 && pass.characters.count > 0) {
            // Call the login service
            AuthService.instance.login(email: email, password: pass, onComplete: { (errMsg, data) in
                guard errMsg == nil else {
                    let alert = UIAlertController(title: "Error Authentication", message: errMsg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            let alert = UIAlertController(title: "Username and Password Required", message: "You must enter both a username and a password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}
