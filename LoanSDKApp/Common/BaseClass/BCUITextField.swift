//
//  BCUITextField.swift
//  PayLink
//
//  Created by Santosh Gupta on 30/08/19.
//  Copyright © 2019 Santosh Gupta. All rights reserved.
//

import UIKit

protocol BCUITextFieldDelegate {
    func textFieldDidDelete(textField: UITextField)
}

class BCUITextField: UITextField {
    
    var deleteDelegate: BCUITextFieldDelegate?
    
    override func deleteBackward() {
        super.deleteBackward()
        deleteDelegate?.textFieldDidDelete(textField: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.titleLabel?.font = UIFont.init(name: Utility.APP_FONT_NAME, size: (self.titleLabel?.font.pointSize)!)
    }
    
    @IBInspectable var corner: CGFloat = 0.0 {
        
        didSet {
            self.layer.cornerRadius = self.corner
        }
        
        willSet {
            self.layer.cornerRadius = self.corner
        }
    }
    
    @IBInspectable var clip: Bool = false {
        
        didSet {
            self.clipsToBounds = self.clip
        }
        
        willSet {
            self.clipsToBounds = self.clip
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        
        didSet {
            self.layer.borderColor = self.borderColor.cgColor
        }
        
        willSet {
            self.layer.borderColor = self.borderColor.cgColor
        }
    }
    
    @IBInspectable var cornerThickness: CGFloat = 0.0 {
            
            didSet {
                self.layer.borderWidth = self.cornerThickness
            }
            
            willSet {
                self.layer.borderWidth = self.cornerThickness
            }
        }
    
    @IBInspectable var shadowColor: UIColor = UIColor.clear {
        didSet {
            self.layer.shadowColor = self.shadowColor.cgColor
        }
        willSet{
            self.layer.shadowColor = self.shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.0 {
        
        didSet {
            self.layer.shadowOpacity = self.shadowOpacity
        }
        willSet {
            self.layer.shadowOpacity = self.shadowOpacity
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0.0, height: 0.0) {
        didSet {
            self.layer.shadowOffset = self.shadowOffset
        }
        willSet {
            self.layer.shadowOffset = self.shadowOffset
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        
        didSet {
            self.layer.shadowRadius = self.shadowRadius
        }
        
        willSet {
            self.layer.shadowRadius = self.shadowRadius
        }
    }
}
