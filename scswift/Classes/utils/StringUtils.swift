//
//  StringUtils.swift
//  SCSwift
//
//  Created by Timoshenko on 25/04/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
//

import Foundation

public class StringUtils {

    /// <#Description#>
    ///
    /// - Parameter value: <#value description#>
    /// - Returns: <#return value description#>
    public static func isNullOrEmpty(_ value : String?) -> Bool {
        return (value ?? "").isEmpty
    }
    
}
