//
//  UINavigationItem.swift
//  SCSwift
//
//  Created by Timoshenko on 16/05/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
//

import UIKit

extension UINavigationItem {

    /// <#Description#>
    ///
    /// - Parameter color: <#color description#>
    func setTitleColor(_ color : UIColor = UIColor.black) {
        self.titleView?.tintColor = color
    }

}
