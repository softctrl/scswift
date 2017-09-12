//
//  Data.swift
//  SCSwift
//
//  Created by Timoshenko on 24/04/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
//

import Foundation

extension Data {
 
    /// Convert a data to his Hexadecimal String representation.
    ///
    /// - Parameter separator: a Separator.
    /// - Returns: a Hexadecimal String representation.
    public func hex(separator:String = "") -> String {
        return (self.map { String(format: "%02X", $0) }).joined(separator: separator)
    }
    
    /// Convert a data to his String representation.
    ///
    /// - Returns: String representation.
    public func toString() -> String? {
        return String(data: self, encoding: .utf8)
    }

}
