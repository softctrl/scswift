//
//  DateUtils.swift
//  QApp
//
//  Created by Timoshenko on 06/04/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
//

import Foundation

class DateUtils {
    
    private static let DD_MM_YYYY_FMT = "dd/MM/yyyy"
    
    public static func str2Date(date : String, dateFormat : String = DateUtils.DD_MM_YYYY_FMT) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.date(from: date)
        return date
        
    }
    
    public static func date2Str(date : Date, dateFormat : String = DateUtils.DD_MM_YYYY_FMT) -> String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
        
    }
    
}
