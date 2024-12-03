//
//  BCUIButton.swift
//  TalentEdgeApp
//  Created by Rex on 30/09/2024.
//
//

import UIKit


class BCUIButton: UIButton {

    override func awakeFromNib() {
        
        //self.titleLabel?.font = UIFont.init(name: Utility.APP_FONT_NAME, size: (self.titleLabel?.font.pointSize)!)
    }
    
    @IBInspectable var bgColor : UIColor = .darkBlueColor2() {
        
        didSet {
            self.layer.backgroundColor = self.bgColor.cgColor
               }
               
               willSet {
                self.layer.backgroundColor = self.bgColor.cgColor
               }
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
    
    @IBInspectable var borderThikness: CGFloat = 0.0 {
        
        didSet {
            self.layer.borderWidth = self.borderThikness
        }
        
        willSet {
            self.layer.borderWidth = self.borderThikness
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
extension UIButton {

  /// Sets the background color to use for the specified button state.
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {

    let minimumSize: CGSize = CGSize(width: 1.0, height: 1.0)

    UIGraphicsBeginImageContext(minimumSize)

    if let context = UIGraphicsGetCurrentContext() {
      context.setFillColor(color.cgColor)
      context.fill(CGRect(origin: .zero, size: minimumSize))
    }

    let colorImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    self.clipsToBounds = true
    self.setBackgroundImage(colorImage, for: forState)
  }
}
