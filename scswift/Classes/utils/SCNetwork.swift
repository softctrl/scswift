//
//  SCNetwork.swift
//  SCSwift
//
//  Created by Timoshenko on 19/05/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
//

import Foundation
import SystemConfiguration

class SCNetwork {
    
    static func isConnected() -> Bool {
        
        var zeroAddress : sockaddr_in = {
            var za = sockaddr_in()
            za.sin_len = UInt8(MemoryLayout.size(ofValue: za))
            za.sin_family = sa_family_t(AF_INET)
            return za
        }()
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
        
    }
    
}
