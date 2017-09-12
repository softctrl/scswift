//
//  NSObject.swift
//  SCSwift
//
//  Created by Timoshenko on 24/04/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
//

import Foundation

extension NSObject {
    
    /// A initializer that receives a valid Json representation of this NSObject.
    ///
    /// - Parameter jsonStr: a Json String for this NSObject.
    public convenience init(_ jsonStr:String) {
        
        self.init()
        if let jsonData = jsonStr.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            self.loadFromData(jsonData)
        } else {
            print("json is of wrong format!\n\(jsonStr)")
        }
        
    }
    
    /// Performs a field load from a valid data parameter.
    ///
    /// - Parameter data: data.
    public final func loadFromData(_ data: Data!) {
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
            self.loadFromJson(json)
        } catch let error as NSError {
            print("\nFailed to load: \(error.localizedDescription)\nData: \(String(data: data, encoding: .utf8)!)\n")
            
        }
        
    }

    
    /// Performs a load from a valid Json String using reflection. You can also override this method to achieve better performances.
    ///
    /// - Parameter json: <#json description#>
    open func loadFromJson(_ json: [String: AnyObject]) {
        
        for (key, value) in json {
            let keyName = key as String
            let keyValue: String = value as! String
            // If property exists
            if (self.responds(to: NSSelectorFromString(keyName))) {
                self.setValue(keyValue, forKey: keyName)
            }
        }
        
    }


    /// It parses this NSObject to a valid Json String representation.
    ///
    /// - Parameter pretty: if true will format the generated Json String.
    /// - Returns: a Json String.
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
    open func toDictionary() -> Dictionary<String, Any>! {
        return [:]
    }
    
    /// <#Description#>
    ///
    /// - Parameter dict: <#dict description#>
    /// - Returns: <#return value description#>
    open func loadFromDictionary(_ dict : Dictionary<String, Any>) -> NSObject {
        return self
    }

}
