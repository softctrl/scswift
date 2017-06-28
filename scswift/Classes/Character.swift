//
//  Character.swift
//  SCSwift
//
//  Created by Timoshenko on 18/05/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
//

import Foundation
import UIKit

public extension Character {
    
//    func isNumber() -> Bool {
//        Charat
//    }
    
    /// <#Description#>
    ///
    /// - Returns: <#return value description#>
    public func isNumber() -> Bool {

        return CharacterSet.decimalDigits.contains(String(self).unicodeScalars.first!)

    }
    
    /// <#Description#>
    ///
    /// - Returns: <#return value description#>
    public func unicodeScalar() -> UnicodeScalar {
        return String(self).unicodeScalars.first!
    }

}
