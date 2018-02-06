//
//  HomeVC.swift
//  photo-chat
//
//  Created by Andrew McGovern on 1/31/18.
//  Copyright © 2018 Andrew McGovern. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeVC: UIViewController {
    
    private var _currentUserFirstName: String?
    private var _currentUserLastName: String?
    private var _currentUserImageURL: String?
    
    var currentUserFirstName: String? {
        get {
            return _currentUserFirstName
        }
        set {
            _currentUserFirstName = newValue
        }
    }
    
    var currentUserLastName: String? {
        get {
            return _currentUserLastName
        }
        set {
            _currentUserLastName = newValue
        }
    }
    
    var currentUserImageURL: String? {
        get {
            return _currentUserImageURL
        }
        set {
            _currentUserImageURL = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let currentUser = Auth.auth().currentUser {
            DataService.instance.usersRef.observeSingleEvent(of: .value, with: { (snapshot) in
                let uid = Auth.auth().currentUser?.uid
                if let users = snapshot.value as? Dictionary<String, Dictionary<String, Any>> {
                    if let user = users[uid!] {
                        if let profile = user["profile"] as? Dictionary<String, Any> {
                            if let firstName = profile["firstName"] as? String {
                                self.currentUserFirstName = firstName
                            }
                            if let lastName = profile["lastName"] as? String {
                                self.currentUserLastName = lastName
                            }
                            if let imageURL = profile["imgURL"] as? String {
                                self.currentUserImageURL = imageURL
                            }
                        }
                    }
                }
            })
                        
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let profileVC = segue.destination as? ProfileVC {
            if let dict = sender as? Dictionary<String, String> {
//                if let nameString = dict["name"] as! String {
//                    profileVC.nameString = nameString
//                }
//                if let imageURL = dict["url"] as! String {
//                    profileVC.profileImgURL = imageURL
//                }
                profileVC.firstName = dict["firstName"]
                profileVC.lastName = dict["lastName"]
                profileVC.profileImgURL = dict["url"]
            }
        }
    }
    
    // Custom Methods
    func goToProfile(profileData: Dictionary<String, String>) {
        performSegue(withIdentifier: "ProfileVC", sender: profileData)
    }
    
    // Actions

    @IBAction func makeAMemoryButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "CameraVC", sender: nil)
    }
    

    @IBAction func profileButtonPressed(_ sender: Any) {
        let data = ["firstName": currentUserFirstName, "lastName": currentUserLastName, "url": currentUserImageURL]
        goToProfile(profileData: data as! Dictionary<String, String>)
    }
    
    
    @IBAction func discoverMemoriesBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "MapVC", sender: nil)
    }
}
