//
//  SCLogger.swift
//  SCSwift
//
//  Created by Timoshenko on 17/05/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
//

import Foundation
import XCGLogger

public class SCLogger : NSObject {
    
    private static let SC_LOGGER = "SCLogger"
    
    let __log: XCGLogger!
    
    private static var SELF : SCLogger? = nil
    
    private init(_ identifier : String = SCLogger.SC_LOGGER, _ includeDefaultDestinations : Bool = false) {
        self.__log = {

            let log = XCGLogger(identifier: identifier, includeDefaultDestinations: includeDefaultDestinations)
            // Customize as needed
            
            // Create a destination for the system console log (via NSLog)
            let systemDestination = AppleSystemLogDestination(identifier: "\(identifier).systemDestination")
            
            // Optionally set some configuration options
            systemDestination.outputLevel = .debug
            systemDestination.showLogIdentifier = false
            systemDestination.showFunctionName = true
            systemDestination.showThreadName = true
            systemDestination.showLevel = true
            systemDestination.showFileName = true
            systemDestination.showLineNumber = true
            systemDestination.showDate = true
            
            
            // Process this destination in the background
            systemDestination.logQueue = XCGLogger.logQueue
            
            // Add the destination to the logger
            log.add(destination: systemDestination)
            
            // Add basic app info, version info etc, to the start of the logs
            log.logAppDetails()

            return log
        }()
        super.init()
    }
    
    /// <#Description#>
    ///
    /// - Returns: <#return value description#>
    public static func getInstance() -> SCLogger {
        return SCLogger.SELF!
    }
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - id: <#id description#>
    ///   - idd: <#idd description#>
    /// - Returns: <#return value description#>
    public static func setup(_ id : String = SCLogger.SC_LOGGER, _ idd : Bool = false) -> SCLogger {
        SCLogger.SELF = SCLogger(id, idd)
        return SCLogger.SELF!
    }
    
    /// <#Description#>
    ///
    /// - Returns: <#return value description#>
    public func log() -> XCGLogger {
        return (SCLogger.SELF?.__log)!
    }

}
