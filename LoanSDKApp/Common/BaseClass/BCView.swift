//
//  BCView.swift
//  TalentEdgeApp
//
//  Created by Vinod Kumar on 19/05/2017.
//  Copyright © 2017 Vinod Sahu. All rights reserved.
//

import UIKit
import CoreGraphics


class BCView: UIView {
    
    private var isGredientShow = false


    override func layoutSubviews() {
        super.layoutSubviews()
        if self.isGredientShow {
            if let gradient = self.layer.sublayers?[0] {
                gradient.frame = self.bounds
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBInspectable var corner: CGFloat = 0.0 {
       
        didSet{
        
            self.layer.cornerRadius = self.corner
        }
        
        willSet{
        
            self.layer.cornerRadius = self.corner
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
       
    
    @IBInspectable var clip: Bool = false {
        
        didSet{
            
            self.clipsToBounds = self.clip
        }
        
        willSet{
           
            self.clipsToBounds = self.clip
        }
    }
    
    
    @IBInspectable var masktoBounds : Bool = false {
           
           didSet{
               
            self.layer.masksToBounds = self.masktoBounds
           }
           
           willSet{
              
              self.layer.masksToBounds = self.masktoBounds
           }
       }
       
       
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        
        didSet{
            
            self.layer.borderColor = self.borderColor.cgColor
        }
        
        willSet{
           
            self.layer.borderColor = self.borderColor.cgColor
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.clear {
        
        didSet{
            
            self.layer.shadowColor = self.shadowColor.cgColor
        }
        
        willSet{
            
            self.layer.shadowColor = self.shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.0 {
        
        didSet{
            
            self.layer.shadowOpacity = self.shadowOpacity
        }
        
        willSet{
         
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
        
        didSet{
            
            self.layer.shadowRadius = self.shadowRadius
        }
        
        willSet{
            
            self.layer.shadowRadius = self.shadowRadius
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
}
