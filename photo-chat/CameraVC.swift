//
//  CameraVC.swift
//  photo-chat
//
//  Created by Andrew McGovern on 1/22/18.
//  Copyright © 2018 Andrew McGovern. All rights reserved.
//

import UIKit
import FirebaseAuth

class CameraVC: AAPLCameraViewController, AAPLCameraVCDelegate {
    @IBOutlet weak var previewView: AAPLPreviewView!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var recordBtn: UIButton!

    override func viewDidLoad() {
        delegate = self
        _previewView = previewView
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard Auth.auth().currentUser != nil else {
            performSegue(withIdentifier: "LoginVC", sender: nil)
            return
        }
    }
    
    // Actions

    @IBAction func recordBtnPressed(_ sender: Any) {
        toggleMovieRecording()
    }


    @IBAction func changeCameraBtnPressed(_ sender: Any) {
        changeCamera()
    }
        
    // Protocol Methods
    
    func shouldEnableCameraUI(_ enable: Bool) {
        cameraBtn.isEnabled = enable
        print("Should enable camera UI: \(enable)")
    }
    
    func shouldEnableRecordUI(_ enable: Bool) {
        recordBtn.isEnabled = enable
        print("Should enable record UI: \(enable)")
    }
    
    func recordingHasStarted() {
        print("Recording has started")
    }
    
    func canStartRecording() {
        print("Can start recording")
    }
    
    func videoRecordingComplete(_ videoURL: URL!) {
        print("Recording complete")
        performSegue(withIdentifier: "UsersVC", sender: ["videoURL": videoURL])
    }
    
    func videoRecordingFailed() {
        print("Recording failed")
    }
    
    func snapshotTaken(_ snapshotData: Data!) {
        print("Snapshot taken")
        performSegue(withIdentifier: "UsersVC", sender: ["snapshotData": snapshotData])
    }
    
    func snapshotFailed() {
        print("Snapshot failed")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let usersVC = segue.destination as? UsersVC {
            if let videoDict = sender as? Dictionary<String, URL> {
                let url = videoDict["videoURL"]
                usersVC.videoURL = url
            } else if let snapDict = sender as? Dictionary<String, Data> {
                let snapData = snapDict["snapshotData"]
                usersVC.snapData = snapData
            }
        }
    }
}

