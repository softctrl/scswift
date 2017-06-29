//
//  SCRealmDBManager.swift
//  SCSwift
//
//  Created by Timoshenko on 27/03/17.
//  Copyright © 2017 SoftCtrl.com. All rights reserved.
//

//import Foundation
import RealmSwift


/// SCRealmDBManager - Realm database manager.
public class SCRealmDBManager: NSObject {
    
    /// Default Salt when the user do not inform any salt:
    private static var DEFAULT_DBNAME = "base"
    private static var DEFAULT_SALT = "@#$%ˆ&"
    
    private var dbPath : URL!
    private var realm : Realm!
    private static var config : Realm.Configuration!
    
    public static func RlmConfig() -> Realm.Configuration! {
        return SCRealmDBManager.config
    }
    
    /// Default constructor.
    ///
    /// - Parameters:
    ///   - dbname: Inform a database name.
    ///   - salt: Inform a valid salt for the informed user.
    public init(dbname: String, salt: String, truncate: Bool = false) {

        super.init()

        SCRealmDBManager.config = Realm.Configuration.defaultConfiguration
        
        self.dbPath = SCRealmDBManager.config.fileURL!.deletingLastPathComponent()
            .appendingPathComponent("\(dbname).realm")

//        config.encryptionKey = SHA256(secret: dbname, salt: salt)
        
        SCRealmDBManager.config.fileURL = self.dbPath
        
        print("self.dbPath: \(self.dbPath.absoluteString)\n")
        
        self.realm = try! Realm(configuration: SCRealmDBManager.config)
        
        if truncate {
            self.deleteAll()
        }

    }
    
    /// Constructor with default salt.
    ///
    /// - Parameter dbname: Inform a database name.
    public convenience init(dbname: String = DEFAULT_DBNAME, truncate: Bool = false) {
        
        self.init(dbname: dbname, salt:SCRealmDBManager.DEFAULT_SALT, truncate: truncate)
        
    }
    
    /// <#Description#>
    ///
    /// - Returns: <#return value description#>
    public func rlm() -> Realm {
        return try! Realm(configuration: SCRealmDBManager.config)
    }
    
    /// <#Description#>
    ///
    /// - Returns: <#return value description#>
    public static func Rlm() -> Realm {
        return try! Realm(configuration: SCRealmDBManager.config)
    }
    
    /// Persist a entity value.
    ///
    /// - Parameter entity: A valid instance of realm object.
    public func persist(entity : Object) {
        
        try! self.realm.write {
            self.realm.add(entity)
        }

    }

    /// Remove a instance of a realm object.
    ///
    /// - Parameter entity: A valid instance of realm object.
    public func remove(entity : Object) {

        try! self.realm.write {
            self.realm.delete(entity)
        }

    }
    
    /// <#Description#>
    public func find() {}
    
    /// <#Description#>
    public func deleteAll() {
        
//        let realm = try! Realm()
        try! self.realm.write {
            self.realm.deleteAll()
        }
    }

}
