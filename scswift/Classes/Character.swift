//
//  Character.swift
//  SCSwift
//
//  Created by Timoshenko on 18/05/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
//

import Foundation
import UIKit

extension Character {
    
    /// Validate when a Character is a valid number or not.
    ///
    /// - Returns: true is it is a valid number otherwise false.
    public func isNumber() -> Bool {

        return CharacterSet.decimalDigits.contains(String(self).unicodeScalars.first!)

    }
    
    /// Convert a Character to a valid UnicodeSCalar.
    ///
    /// - Returns: a UnicodeScalar.
    public func unicodeScalar() -> UnicodeScalar {
        return String(self).unicodeScalars.first!
    }

}
