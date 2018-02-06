//
//  VideoMemoryVC.swift
//  photo-chat
//
//  Created by Andrew McGovern on 2/5/18.
//  Copyright © 2018 Andrew McGovern. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideoMemoryVC: UIViewController {
    
    private var _videoName: String!
    private var _videoURL: String!
    
    var videoName: String {
        get {
            return _videoName
        }
        set {
            _videoName = newValue
        }
    }
    
    var videoURL: String {
        get {
            return _videoURL
        }
        set {
            _videoURL = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Video Name: \(videoName)")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        if let currentUser = Auth.auth().currentUser {
//            DataService.instance.usersRef.observeSingleEvent(of: .value, with: { (snapshot) in
//                let uid = Auth.auth().currentUser?.uid
//                if let users = snapshot.value as? Dictionary<String, Dictionary<String, Any>> {
//                    if let user = users[uid!] {
//                        if let profile = user["profile"] as? Dictionary<String, Any> {
//                            if let firstName = profile["firstName"] as? String {
//                                self.currentUserFirstName = firstName
//                            }
//                            if let lastName = profile["lastName"] as? String {
//                                self.currentUserLastName = lastName
//                            }
//                            if let imageURL = profile["imgURL"] as? String {
//                                self.currentUserImageURL = imageURL
//                            }
//                        }
//                    }
//                }
//            })
//            
//        }
        
        DataService.instance.mainRef.child("pullRequests").observeSingleEvent(of: .value, with: { (snapshot) in
            if let pullRequests = snapshot.value as? Dictionary<String, Dictionary<String, Any>> {
                if let pullRequest = pullRequests[self.videoName] {
                    if let mediaURL = pullRequest["mediaURL"] {
                        self.videoURL = mediaURL as! String
                    }
                }
            }
            let videoURL = URL(string: self.videoURL)
            let player = AVPlayer(url: videoURL!)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = self.view.bounds
            self.view.layer.addSublayer(playerLayer)
            player.play()
            
        })
        
    }

}
