//
//  String.swift
//  SCSwift
//
//  Created by Timoshenko on 24/04/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
//

import Foundation

extension String {
    
    func md5() -> String {
        return "under development"
    }
    
    /// <#Description#>
    ///
    /// - Returns: <#return value description#>
    func quoted() -> String {
        return "\"\(self)\""
    }
    
    static func isNilOrEmpty(_ value : String? = nil) -> Bool {
        return (value == nil || value!.isEmpty)
    }
    
    /// Based on:
    /// http://stackoverflow.com/questions/24092884/get-nth-character-of-a-string-in-swift-programming-language
    ///
    /// - Parameter i: <#i description#>
    func character(at: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: at)]
    }
    
    func uniChar(at: Int) -> unichar {
        return unichar(self[self.index(self.startIndex, offsetBy: at)].unicodeScalar().value)
    }
    
    /// <#Description#>
    ///
    /// - Returns: <#return value description#>
    func count() -> Int {
        return self.characters.count
    }
    
}
