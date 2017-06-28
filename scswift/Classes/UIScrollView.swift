//
//  UIScrollView.swift
//  SCSwift
//
//  Created by Timoshenko on 10/05/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
//

import UIKit

public extension UIScrollView {

    /// <#Description#>
    ///
    /// - Parameter screenSize: <#screenSize description#>
    public func setupContentSize(_ screenSize : CGSize! = CGSize.mainSize()) {
        self.contentSize = screenSize
    }
    
}
