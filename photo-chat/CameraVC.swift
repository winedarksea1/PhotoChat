//
//  CameraVC.swift
//  photo-chat
//
//  Created by Andrew McGovern on 1/22/18.
//  Copyright © 2018 Andrew McGovern. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

import MapKit


class CameraVC: AAPLCameraViewController, AAPLCameraVCDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var previewView: AAPLPreviewView!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var recordBtn: UIButton!
    
    let locationManager = CLLocationManager()
    let userLocation = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        locationManager.delegate = self
        
        delegate = self
        _previewView = previewView
        locationAuthStatus()
        
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        performSegue(withIdentifier: "LoginVC", sender: nil)
        guard Auth.auth().currentUser != nil else {
            performSegue(withIdentifier: "LoginVC", sender: nil)
            return
        }
        
        // Try again
        DataService.instance.usersRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let uid = Auth.auth().currentUser?.uid
            if let users = snapshot.value as? Dictionary<String, Any> {
                print(users[uid!]!)
            }
        })
//
        
            
        locationManager.startUpdatingLocation()
        print(userLocation.latitude)
    }
    
    // Actions

    @IBAction func recordBtnPressed(_ sender: Any) {
        toggleMovieRecording()
    }


    @IBAction func changeCameraBtnPressed(_ sender: Any) {
        changeCamera()
    }
    
    @IBAction func exitBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
            
                if let usersLatitude = (locationManager.location?.coordinate.latitude)! as? Double {
                    usersVC.usersLatitude = usersLatitude
                }
                
                if let usersLongitude = (locationManager.location?.coordinate.longitude)! as? Double {
                    usersVC.usersLongitude = usersLongitude
                }
                
            } else if let snapDict = sender as? Dictionary<String, Data> {
                let snapData = snapDict["snapshotData"]
                usersVC.snapData = snapData
            }
        }
    }
    
    // Inherited Location Methods
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location was updated")
        print((locationManager.location?.coordinate.latitude)! as Double)
    }
    
    
    // Custom Location Methods
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
}

