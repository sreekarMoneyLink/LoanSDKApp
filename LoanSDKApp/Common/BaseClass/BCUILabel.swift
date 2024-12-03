//
//  BCUILabel.swift
//  PayLink
//
//  Created by Santosh Gupta on 30/08/19.
//  Copyright © 2019 Santosh Gupta. All rights reserved.
//

import UIKit

class BCUILabel: UILabel {
    
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
    
    @IBInspectable var borderThickness: CGFloat = 0.0 {
        
        didSet {
            self.layer.borderWidth = self.borderThickness
        }
        
        willSet {
            self.layer.borderWidth = self.borderThickness
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
    
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        
        didSet {
            self.layer.shadowRadius = self.shadowRadius
        }
        
        willSet {
            self.layer.shadowRadius = self.shadowRadius
        }
    }
    
}
