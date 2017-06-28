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
    func delete()
}

// MARK: - <#SCObject#>
extension Object : SCObject {

    /// <#Description#>
    public func insert() {
        let realm = try! Realm()
        try! realm.write {
            realm.add(self)
        }
    }
    
    public func update(_ upd : ()->()) {
        let realm = try! Realm()
        try! realm.write {
            upd()
        }
    }

    
    public func delete() {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(self)
        }
    }
    
}
