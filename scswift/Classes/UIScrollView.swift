//
//  UIScrollView.swift
//  SCSwift
//
//  Created by Timoshenko on 10/05/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
//

import UIKit

extension UIScrollView {

    /// <#Description#>
    ///
    /// - Parameters:
    ///   - screenSize: <#screenSize description#>
    ///   - plus: <#plus description#>
    public func setupContentSize(_ screenSize : CGSize! = CGSize.mainSize(), plus : CGFloat = 0) {
        self.contentSize =  CGSize(width: screenSize.width, height: (screenSize.height + plus))
    }
    
}
