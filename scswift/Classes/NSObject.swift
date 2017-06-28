//
//  NSObject.swift
//  SCSwift
//
//  Created by Timoshenko on 24/04/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
//

import Foundation

extension NSObject {
    
    /// <#Description#>
    ///
    /// - Parameter jsonStr: <#jsonStr description#>
    convenience init(_ jsonStr:String) {
        
        self.init()
        if let jsonData = jsonStr.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            self.loadFromData(jsonData)
        } else {
            print("json is of wrong format!\n\(jsonStr)")
        }
        
    }
    
    /// <#Description#>
    ///
    /// - Parameter data: <#data description#>
    final func loadFromData(_ data: Data!) {
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
            self.loadFromJson(json)
        } catch let error as NSError {
            print("\nFailed to load: \(error.localizedDescription)\nData: \(String(data: data, encoding: .utf8)!)\n")
            
        }
        
    }

    
    /// <#Description#>
    ///
    /// - Parameter json: <#json description#>
    func loadFromJson(_ json: [String: AnyObject]) {
        
        for (key, value) in json {
            let keyName = key as String
            let keyValue: String = value as! String
            // If property exists
            if (self.responds(to: NSSelectorFromString(keyName))) {
                self.setValue(keyValue, forKey: keyName)
            }
        }
        
    }


    /// <#Description#>
    ///
    /// - Parameter pretty: <#pretty description#>
    /// - Returns: <#return value description#>
    public final func toJson(_ pretty : Bool = false) -> String {
        
        var json = "{}"
        do {
            
            var options : JSONSerialization.WritingOptions = []
            if pretty {
                options = [.prettyPrinted]
            }
            let jsonData = try JSONSerialization.data(withJSONObject: self.toDictionary(), options: options)
            json = String.init(data: jsonData, encoding: .utf8)!
        } catch {
            print(error.localizedDescription)
        }
        return json

    }
    
    /// <#Description#>
    ///
    /// - Returns: <#return value description#>
    func toDictionary() -> Dictionary<String, Any>! {
        return [:]
    }
    
    func loadFromDictionary(_ dict : Dictionary<String, Any>) -> NSObject {
        return self
    }

}
