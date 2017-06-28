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
protocol  SCObject {
    func insert()
    func update(_ upd : ()->())
    func delete()
}

// MARK: - <#SCObject#>
extension Object : SCObject {

    /// <#Description#>
    func insert() {
        let realm = try! Realm()
        try! realm.write {
            realm.add(self)
        }
    }
    
    func update(_ upd : ()->()) {
        let realm = try! Realm()
        try! realm.write {
            upd()
        }
    }

    
    func delete() {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(self)
        }
    }
    
}
