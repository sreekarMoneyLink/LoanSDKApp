//
//  UIColorExtension.swift
//  Wellthy
//
//  Created by Rohit Kumar on 07/12/17.
//  Copyright © 2017 Kiruthika Selvavinayagam. All rights reserved.
//

import UIKit

extension UIColor {
    
//    static func fromHexCode(hex:String) -> UIColor {
//        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
//        
//        if (cString.hasPrefix("#")) {
//            cString.remove(at: cString.startIndex)
//        }
//        
//        if ((cString.count) != 6) {
//            return UIColor.gray
//        }
//        
//        var rgbValue:UInt32 = 0
//        Scanner(string: cString).scanHexInt64(&rgbValue)
//        
//        return UIColor(
//            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
//            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
//            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
//            alpha: CGFloat(1.0)
//        )
//    }
    
    static func fromHexCode(hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        // Remove the leading "#" if present
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        // Ensure the hex string is 6 characters
        if cString.count != 6 {
            return UIColor.gray
        }

        var rgbValue: UInt64 = 0

        // Use scanHexInt64 to support newer iOS versions
        let scanner = Scanner(string: cString)
        if scanner.scanHexInt64(&rgbValue) {
            return UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: 1.0
            )
        }

        // Return gray if the scan fails
        return UIColor.gray
    }

    
    static func skyBlueColor() -> UIColor {
        return UIColor(red: 77.0/255, green: 185.0/255, blue: 237.0/255, alpha: 1.0)
    }
    static func darkGrayColor() -> UIColor {
        return UIColor(red: 153.0/255, green: 153.0/255, blue: 153.0/255, alpha: 1.0)
    }
    
    static func darkBlueColor() -> UIColor {
        //return UIColor(red: 34/255, green: 53/255, blue: 103/255, alpha: 1.0)
        return UIColor(red: 35/255, green: 52/255, blue: 105/255, alpha: 1.0)
    }
    
    static func currentStepColor() -> UIColor {
       return UIColor(red: 255/255, green: 192/255, blue: 0/255, alpha: 1)
    }
    
    static func upcomingStepTextColor() -> UIColor {
       return UIColor(red: 127/255, green: 127/255, blue: 127/255, alpha: 1)
        
    }

    static func previousStepColor() -> UIColor {
        return UIColor(red: 0/255, green: 32/255, blue: 96/255, alpha: 1)
    }
    
    static func orangeColor() -> UIColor {
       return UIColor(red: 35/255, green: 52/255, blue: 105/255, alpha: 1.0)
    }
    
    static func greenColor() -> UIColor{
        return UIColor(red: 104/255, green: 201/255, blue: 59/255, alpha: 1.0)
    }
    
    static func navigationBarColor() -> UIColor{
        return UIColor(red: 38/255, green: 54/255, blue: 105/255, alpha: 1.0)
    }
    
    static func inputTextColor() -> UIColor{
        return UIColor(red: 38/255, green: 54/255, blue: 105/255, alpha: 1.0)
    }
    
    static func inputTextBorderColor() -> UIColor{
        return UIColor(red: 205/255, green: 204/255, blue: 210/255, alpha: 1.0)
    }
    
    static func inputTextFieldBGColor() -> UIColor{
        return UIColor(red: 232/255, green: 232/255, blue: 232/255, alpha: 1.0)
    }
    
    static func inputTextFieldBorderColor() -> UIColor{
        return UIColor(red: 135/255, green: 133/255, blue: 147/255, alpha: 1.0)
    }
    
    static func lightGrayBGColor() -> UIColor{
        return UIColor(red: 231/255, green: 235/255, blue: 238/255, alpha: 1.0)
    }
    
    
    
    static func darkBlueColor2() -> UIColor {
    return UIColor(red: 32/255, green: 51/255, blue: 107/255, alpha: 1)
        
       // return UIColor(red: 26/255, green: 39/255, blue: 90/255, alpha: 1)
    }
    
    static func lightSkyBlueColor() -> UIColor {
        return UIColor.fromHexCode(hex: "BFEAF8")
    }
    
    static func inputFieldBlueColor() -> UIColor {
        return UIColor.fromHexCode(hex: "CAEEFA")
    }
    
    static func textColor() -> UIColor {
        return UIColor.fromHexCode(hex: "#22376D")
    }
    
    
        

    
    
}
