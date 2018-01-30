//
//  AuthService.swift
//  photo-chat
//
//  Created by Andrew McGovern on 1/27/18.
//  Copyright © 2018 Andrew McGovern. All rights reserved.
//

import FirebaseAuth

typealias Completion = (_ errMsg: String?, _ data: Any?) -> Void

class AuthService {
    private static let _instance = AuthService()
    
    static var instance: AuthService {
        return _instance
    }
    
    func login(email: String, password: String, onComplete: @escaping Completion) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                if let errorCode = AuthErrorCode(rawValue: (error?._code)!) {
                    if errorCode == .userNotFound {
                        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil {
                                self.handleFirebaseError(error: error! as NSError, onComplete: onComplete)
                            } else {
                                if user?.uid != nil {
                                    // save the user to the Database
                                    DataService.instance.saveUser(uid: (user?.uid)!)
                                    // Sign in 
                                    Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                                        if error != nil {
                                            // Show error to user
                                            self.handleFirebaseError(error: error as! NSError, onComplete: onComplete)
                                        } else {
                                            // we have successfully logged in
                                            onComplete(nil, user)
                                        }
                                    })
                                }
                            }
                        })
                    }
                } else {
                    // Handle all other errors
                    self.handleFirebaseError(error: error as! NSError, onComplete: onComplete)
                }
            } else {
                onComplete(nil, user)
            }
        }
    }
    
    func handleFirebaseError(error: NSError, onComplete: Completion?) {
        print(error.debugDescription)
        if let errorCode = AuthErrorCode(rawValue: error.code) {
            switch(errorCode) {
            case .invalidEmail:
                onComplete?("Invalid email address", nil)
                break
            case .wrongPassword:
                onComplete?("Invalid password", nil)
                break
            case .emailAlreadyInUse, .accountExistsWithDifferentCredential:
                onComplete?("Could not create account. Email already in use", nil)
                break
            default:
                onComplete?("There was a problem authenticating. Try again.", nil)
            }
        }
    }
    
}
