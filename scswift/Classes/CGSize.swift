//
//  CGSize.swift
//  SCSwift
//
//  Created by Timoshenko on 15/05/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
//

import UIKit

extension CGSize {
    
    /// Returns the CGSize of the main screen.
    ///
    /// - Returns: a CGSize.
    public static func mainSize() -> CGSize {
        let mainBound = CGRect.mainBounds()
        return CGSize(width: mainBound.width, height: mainBound.height)
    }

    
}
