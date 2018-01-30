//
//  RoundTextField.swift
//  photo-chat
//
//  Created by Andrew McGovern on 1/25/18.
//  Copyright © 2018 Andrew McGovern. All rights reserved.
//

import UIKit

@IBDesignable
class RounTextField: UITextField {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var bgColor: UIColor? {
        didSet {
            backgroundColor = bgColor
        }
    }
    
    @IBInspectable var placeholderColor: UIColor? {
        didSet {
            let rawString = attributedPlaceholder?.string != nil ? attributedPlaceholder!.string : ""
            let str = NSAttributedString(string: attributedPlaceholder!.string, attributes: [NSForegroundColorAttributeName: placeholderColor!])
            self.attributedPlaceholder = str
        }
    }
}

