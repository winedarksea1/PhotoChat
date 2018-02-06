//
//  UsersVC.swift
//  photo-chat
//
//  Created by Andrew McGovern on 1/28/18.
//  Copyright © 2018 Andrew McGovern. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseAuth

class UsersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    private var users = [User]()
    private var selectedUsers = Dictionary<String, User>()
    
    private var _snapData: Data?
    private var _videoURL: URL?
    
    private var _usersLatitude: Double?
    private var _usersLongitude: Double?
    
    var snapData: Data? {
        get {
            return _snapData
        }
        set {
            _snapData = newValue
        }
    }
    
    var videoURL: URL? {
        get {
            return _videoURL
        }
        set {
            _videoURL = newValue
        }
    }
    
    var usersLatitude: Double {
        get {
            return _usersLatitude!
        }
        set {
            _usersLatitude = newValue
        }
    }
    
    var usersLongitude: Double {
        get {
            return _usersLongitude!
        }
        set {
            _usersLongitude = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        DataService.instance.usersRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let users = snapshot.value as? Dictionary<String, Any> {
                for (key, value) in users {
                    if let dict = value as? Dictionary<String, Any> {
                        if let profile = dict["profile"] as? Dictionary<String, Any> {
                            if let firstName = profile["firstName"] as? String {
                                let uid = key
                                let user = User(uid: uid, firstName: firstName)
                                self.users.append(user)
                            }
                        }
                    }
                }
            }
            self.tableView.reloadData()
            print("Users \(self.users)")
        })
    }
    
    // Protocol Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationItem.rightBarButtonItem?.isEnabled = true
        
        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        cell.setCheckmark(selected: true)
        let user = users[indexPath.row]
        selectedUsers[user.uid] = user
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        cell.setCheckmark(selected: false)
        let user = users[indexPath.row]
        selectedUsers[user.uid] = nil
        
        if selectedUsers.count <= 0 {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        let user = users[indexPath.row]
        cell.updateUI(user: user)
        return cell
    }
    
    // Actions

    @IBAction func sendPRBtnPressed(_ sender: Any) {
        print("Send Button was pressed")
        if let url = _videoURL {
            let videoName = "\(NSUUID().uuidString)\(url)"
            print("Video Name: ")
            print(videoName)
            let ref = DataService.instance.videoStorageReference.child(videoName)
            
            _ = ref.putFile(from: url, metadata: nil, completion: { (meta, err) in
                if err != nil {
                    print("Error uploading video: \(err?.localizedDescription)")
                } else {
                    let downloadURL = meta?.downloadURL()
                    
                    DataService.instance.sendMediaPullRequest(senderUID: (Auth.auth().currentUser?.uid)!, sendingTo: self.selectedUsers, mediaURL: downloadURL!, usersLatitude: self.usersLatitude, usersLongitude: self.usersLongitude, textSnippet: "Coding today was legit")
                    
                }
            })
            self.dismiss(animated: true, completion: nil)
        } else if let snapData = _snapData {
            let ref = DataService.instance.imagesStorageRef.child("\(NSUUID().uuidString).jpg")
            
            _ = ref.putData(snapData, metadata: nil, completion: { (meta, err) in
                if err != nil {
                    print("Error uploading snapshot: \(err?.localizedDescription)")
                } else {
                    let downloadURL = meta?.downloadURL()
                }
            })
            self.dismiss(animated: true, completion: nil)
        }
    }

}
