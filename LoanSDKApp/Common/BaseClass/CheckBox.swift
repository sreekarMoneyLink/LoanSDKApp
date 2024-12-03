//
//  CheckBox.swift
//  LendingSDK
//
//  Created by Rex on 25/11/24.
//

import Foundation
import UIKit

class CheckBox: UIButton {
    var lightBlue=UIColor(red: 0, green: 186, blue: 242, alpha: 1)
    let roundedRectStrokeColor = UIColor(red: 0, green: 186, blue: 242, alpha: 1)
    var roundedRectFillColor = UIColor.white
    let checkmarkColor = UIColor.green
    var checkmarkLayer: CAShapeLayer = CAShapeLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.checkmarkLayer.fillColor   = nil;
        //
        // Draw checkbox with OFF state
        //
        let lineWidth:CGFloat = rect.size.width / 10
        //        let roundedRect = UIBezierPath(roundedRect: CGRectInset(rect, lineWidth/2, lineWidth/2), cornerRadius: 5)
        let roundedRect = UIBezierPath(roundedRect: rect.insetBy(dx: lineWidth/2, dy: lineWidth/2), cornerRadius: 25)
        roundedRect.lineWidth = lineWidth
        
        roundedRectStrokeColor.setStroke()
        roundedRect.stroke()
        roundedRectFillColor.setFill()
        roundedRect.fill()

        let checkmarkPath = UIBezierPath();

        if isSelected {
            
            self.alpha = 1
            self.checkmarkLayer.removeAllAnimations()
          
            checkmarkPath.move(to: CGPoint(x: self.bounds.width * 0.28, y: self.bounds.height * 0.5))
            checkmarkPath.addLine(to: CGPoint(x: self.bounds.width * 0.42, y: self.bounds.height * 0.66))
            checkmarkPath.addLine(to: CGPoint(x: self.bounds.width * 0.72, y: self.bounds.height * 0.36))
            checkmarkPath.lineCapStyle  = .square
            self.checkmarkLayer.path    = checkmarkPath.cgPath;
            self.checkmarkLayer.strokeColor = lightBlue.cgColor;
            self.checkmarkLayer.lineWidth   = 2.0;
            self.layer.addSublayer(self.checkmarkLayer);
            let checkmarkAnimation: CABasicAnimation = CABasicAnimation(keyPath:"strokeEnd")
            checkmarkAnimation.duration = 0.23
            checkmarkAnimation.isRemovedOnCompletion = false
            checkmarkAnimation.fillMode = CAMediaTimingFillMode.both
            checkmarkAnimation.fromValue = 0
            checkmarkAnimation.toValue = 1
            checkmarkAnimation.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
            self.checkmarkLayer.add(checkmarkAnimation, forKey:"strokeEnd")
            self.roundedRectFillColor=UIColor.white
           // self.roundedRectFillColor = UIColor.darkBlueColor2()

        } else {
            self.checkmarkLayer.removeAllAnimations()
            checkmarkPath.removeAllPoints()
            checkmarkLayer.removeFromSuperlayer()
            //self.roundedRectFillColor=UIColor.white
            self.roundedRectFillColor = UIColor.darkBlueColor2()
        }
        // updateSelectedState()
    }
    
    func updateSelectedState(){
        
        if isSelected == true {
            self.roundedRectFillColor = UIColor.darkBlueColor2()
        }
        else {
            self.roundedRectFillColor=UIColor.white
        }
    }
    
    func updateNormalState() {
        self.roundedRectFillColor=UIColor.white
    }
}
