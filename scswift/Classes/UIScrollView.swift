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
    /// - Parameter screenSize: <#screenSize description#>
    func setupContentSize(_ screenSize : CGSize! = CGSize.mainSize()) {
        self.contentSize = screenSize
    }
    
}
