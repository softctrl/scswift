//
//  Data.swift
//  SCSwift
//
//  Created by Timoshenko on 24/04/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
//

import Foundation

extension Data {
 
    /// <#Description#>
    ///
    /// - Parameter separator: <#separator description#>
    /// - Returns: <#return value description#>
    public func hex(separator:String = "") -> String {
        return (self.map { String(format: "%02X", $0) }).joined(separator: separator)
    }

}
