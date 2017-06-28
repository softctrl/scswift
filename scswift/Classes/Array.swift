//
//  Array.swift
//  SCSwift
//
//  Created by Timoshenko on 08/05/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
//

import Foundation

// MARK: - <#Description#>
extension Array {

    /// <#Description#>
    ///
    /// - Parameter pretty: <#pretty description#>
    /// - Returns: <#return value description#>
    public func toJson(_ pretty : Bool = false) -> String {
        
        var json = "[]"
        do {
            var options : JSONSerialization.WritingOptions = []
            if pretty {
                options = [.prettyPrinted]
            }
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: options)
            json = String.init(data: jsonData, encoding: .utf8)!
        } catch let err {
            print(err.localizedDescription)
        }
        return json
        
    }
    
}
