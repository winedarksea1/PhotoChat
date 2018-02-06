//
//  ProfileVC.swift
//  photo-chat
//
//  Created by Andrew McGovern on 1/31/18.
//  Copyright © 2018 Andrew McGovern. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    
    
    private var _firstName: String?
    private var _lastName: String?
    private var _profileImgURL: String?
    
    var firstName: String? {
        get {
            return _firstName
        }
        set {
            _firstName = newValue
        }
    }
    
    var lastName: String? {
        get {
            return _lastName
        }
        set {
            _lastName = newValue
        }
    }
    
    var profileImgURL: String? {
        get {
            return _profileImgURL
        }
        set {
            _profileImgURL = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = firstName!
    }
    
    // Actions
    @IBAction func exitBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
