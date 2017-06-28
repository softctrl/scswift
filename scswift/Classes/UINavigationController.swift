//
//  SCSwiftUINavigationController.swift
//  SCSwift
//
//  Created by Timoshenko on 20/04/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    /// <#Description#>
    ///
    /// - Parameter rgbValue: <#rgbValue description#>
    public static func setup(rgbValue : UInt32) {
        
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = UIColor.white
        navigationBarAppearace.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationBarAppearace.barTintColor = UIColor.uicolorFromHex(rgbValue: rgbValue)
        
    }

    /// <#Description#>
    ///
    /// - Parameter value: <#value description#>
    func setViewController(_ value : UIViewController) {
        self.viewControllers = [value]
    }

}
