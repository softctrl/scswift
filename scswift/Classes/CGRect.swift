//
//  CGRect.swift
//  SCSwift
//
//  Created by Timoshenko on 15/05/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
//

import UIKit

extension CGRect {
    
    /// Returns the main bounds.
    ///
    /// - Returns: a CGRect for the main bounds.
    public static func mainBounds() -> CGRect {
        return UIScreen.main.bounds
    }
    
}

