//
//  Object.swift
//  SCSwift
//
//  Created by Timoshenko on 11/05/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
//

import Foundation
import RealmSwift

/// <#Description#>
public protocol  SCObject {
    func insert()
    func update(_ upd : ()->())
    func persist()
    func delete()
}


extension Object : SCObject {

    /// <#Description#>
    public func insert() {
        let realm = try! Realm()
        try! realm.write {
            realm.add(self)
        }
    }
    
    /// <#Description#>
    ///
    /// - Parameter upd: <#upd description#>
    public func update(_ upd : ()->()) {
        let realm = try! Realm()
        try! realm.write {
            upd()
        }
    }
    
    /// <#Description#>
    open func persist() {
        // TODO:
    }

    
    /// <#Description#>
    public func delete() {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(self)
        }
    }
    
    /// Every Realm Object instance has the capability to access in a easy way a Realm manager.
    ///
    /// - Returns: <#return value description#>
    public static func rlm() -> Realm {
        return SCRealmDBManager.Rlm()
    }

}
