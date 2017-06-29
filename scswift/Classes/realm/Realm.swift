//
//  SCRealmDBManager.swift
//  SCSwift
//
//  Created by Timoshenko on 28/06/17.
//  Copyright © 2017 SoftCtrl.com. All rights reserved.
//

import RealmSwift

extension Realm {
    
    /// Just a convenient initiator for a Realm instance that will use the Configuration on the project.
    ///
    /// - Throws: <#throws value description#>
    convenience init() throws {
        try! self.init(configuration: SCRealmDBManager.RlmConfig())
    }
    
}

extension Results {
    
    /// Validates if exists any result for this Results instance.
    ///
    /// - Returns: True or False
    open func exists() -> Bool {
        return (self.count > 0)
    }
    
}
