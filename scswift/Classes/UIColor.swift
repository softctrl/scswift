//
//  UIColor.swift
//  SCSwift
//
//  Created by Timoshenko on 11/04/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
//

import UIKit

extension UIColor {

    /// <#Description#>
    ///
    /// - Parameter rgbValue: <#rgbValue description#>
    /// - Returns: <#return value description#>
    public static func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }

}
