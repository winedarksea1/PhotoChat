//
//  CameraVC.swift
//  photo-chat
//
//  Created by Andrew McGovern on 1/22/18.
//  Copyright © 2018 Andrew McGovern. All rights reserved.
//

import UIKit

class CameraVC: AAPLCameraViewController, AAPLCameraVCDelegate {
    @IBOutlet weak var previewView: AAPLPreviewView!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var recordBtn: UIButton!

    override func viewDidLoad() {
        delegate = self
        _previewView = previewView
        super.viewDidLoad()

    }

    @IBAction func recordBtnPressed(_ sender: Any) {
        toggleMovieRecording()
    }


    @IBAction func changeCameraBtnPressed(_ sender: Any) {
        changeCamera()
    }
    
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
    }
    
    func videoRecordingFailed() {
        print("Recording failed")
    }
    
    func snapshotTaken(_ snapshotData: Data!) {
        print("Snapshot taken")
    }
    
    func snapshotFailed() {
        print("Snapshot failed")
    }
}

