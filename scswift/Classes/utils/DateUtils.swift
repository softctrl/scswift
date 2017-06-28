//
//  DateUtils.swift
//  QApp
//
//  Created by Timoshenko on 06/04/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
//

import Foundation

public class DateUtils {
    
    private static let DD_MM_YYYY_FMT = "dd/MM/yyyy"
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - date: <#date description#>
    ///   - dateFormat: <#dateFormat description#>
    /// - Returns: <#return value description#>
    public static func str2Date(date : String, dateFormat : String = DateUtils.DD_MM_YYYY_FMT) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.date(from: date)
        return date
        
    }
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - date: <#date description#>
    ///   - dateFormat: <#dateFormat description#>
    /// - Returns: <#return value description#>
    public static func date2Str(date : Date, dateFormat : String = DateUtils.DD_MM_YYYY_FMT) -> String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
        
    }
    
}
