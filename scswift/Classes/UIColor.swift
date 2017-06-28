//
//  UIColor.swift
//  SCSwift
//
//  Created by Timoshenko on 11/04/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
//

import UIKit

extension UIColor {

//    /// <#Description#>
//    ///
//    /// - Parameters:
//    ///   - red: <#red description#>
//    ///   - green: <#green description#>
//    ///   - blue: <#blue description#>
//    convenience init(red: Int, green: Int, blue: Int) {
//        assert(red >= 0 && red <= 255, "Invalid red component")
//        assert(green >= 0 && green <= 255, "Invalid green component")
//        assert(blue >= 0 && blue <= 255, "Invalid blue component")
//        
//        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
//    }
//    
//    /// <#Description#>
//    ///
//    /// - Parameter rgb: <#rgb description#>
//    convenience init(rgb: Int) {
//        self.init(
//            red: (rgb >> 16) & 0xFF,
//            green: (rgb >> 8) & 0xFF,
//            blue: rgb & 0xFF
//        )
//    }
    
    public static func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }

}
