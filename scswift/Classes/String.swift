//
//  String.swift
//  SCSwift
//
//  Created by Timoshenko on 24/04/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
//

import Foundation

extension String {
//                                     "^(http:\\/\\/|https:\\/\\/)?(www.)?([a-zA-Z0-9]+).[a-zA-Z0-9]*.[a-z]{3}.?([a-z]+)?$"
//    private static let URL_PATTERN = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
    
    public func md5() -> String {
        return "under development"
    }
    
    /// <#Description#>
    ///
    /// - Returns: <#return value description#>
    public func quoted() -> String {
        return "\"\(self)\""
    }
    
    public static func isNilOrEmpty(_ value : String? = nil) -> Bool {
        return (value == nil || value!.isEmpty)
    }
    
    /// Based on:
    /// http://stackoverflow.com/questions/24092884/get-nth-character-of-a-string-in-swift-programming-language
    ///
    /// - Parameter i: <#i description#>
    public func character(at: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: at)]
    }
    
    /// <#Description#>
    ///
    /// - Parameter at: <#at description#>
    /// - Returns: <#return value description#>
    public func uniChar(at: Int) -> unichar {
        return unichar(self[self.index(self.startIndex, offsetBy: at)].unicodeScalar().value)
    }
    
    /// <#Description#>
    ///
    /// - Returns: <#return value description#>
    public func count() -> Int {
        return self.characters.count
    }
    
    /// Validate when a string is a valid url or not.
    ///
    /// - Returns: True if is a valid url, False otherwise.
//    public func isUrl() -> Bool {
//        return NSPredicate(format: "SELF MATCHES %@", String.URL_PATTERN).evaluate(with: self)
//    }

}
