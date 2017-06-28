//
//  UITableView.swift
//  SCSwift
//
//  Created by Timoshenko on 28/04/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
//

import Foundation
import UIKit

public extension UITableView {

    /// <#Description#>
    ///
    /// - Parameters:
    ///   - controller: <#controller description#>
    ///   - automaticDimension: <#automaticDimension description#>
    ///   - estimatedRowHeight: <#estimatedRowHeight description#>
    public func setup(_ controller : UIViewController, automaticDimension : Bool = false, estimatedRowHeight : CGFloat = 20) {

        self.delegate = controller as? UITableViewDelegate
        self.dataSource = controller as? UITableViewDataSource
        if automaticDimension {
            self.rowHeight = UITableViewAutomaticDimension
        }
        self.estimatedRowHeight = estimatedRowHeight

    }
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - nibName: <#nibName description#>
    ///   - reuseIdentifier: <#reuseIdentifier description#>
    public func registerNib(_ nibName : String!, reuseIdentifier : String? = nil) {
        
        var ri = nibName
        if let reuseId = reuseIdentifier as String! {
            ri = reuseId
        }
        self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: ri!)

    }

    
}
