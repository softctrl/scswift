//
//  SCBackgroundManager.swift
//  SCSwift
//
//  Created by Timoshenko on 17/05/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
//

import Foundation
import UIKit

/// <#Description#>
class SCBackgroundManager: NSObject {
    
    typealias Action = () -> ()

    /// <#Description#>
    struct Static {
        static var backgroundManager : SCBackgroundManager?
        static var onceToken : Int = 0
    }
    
    /// <#Description#>
    private static var __once: () = {
        Static.backgroundManager = SCBackgroundManager()
    }()
    
    
    var taskIdList : NSMutableArray
    var masterTaskId : UIBackgroundTaskIdentifier
    var beginAction : Action?
    var endAction : Action?
    
    /// <#Description#>
    override init() {
        
        self.taskIdList = NSMutableArray()
        self.masterTaskId = UIBackgroundTaskInvalid
        super.init()

    }
    
    func setup(_ begin : Action? = nil, _ end : Action? = nil) {
        self.beginAction = begin
        self.endAction = end
    }
    
    /// <#Description#>
    ///
    /// - Returns: <#return value description#>
    class func backgroundTaskManager() -> SCBackgroundManager? {
        _ = SCBackgroundManager.__once
        return Static.backgroundManager
    }

    /// <#Description#>
    ///
    /// - Returns: <#return value description#>
    func beginNewBackgroundTask() -> UIBackgroundTaskIdentifier? {
        
        print("SCBackgroundManager.beginNewBackgroundTask()\n")
        let application : UIApplication = UIApplication.shared
        var bgTaskId : UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
        bgTaskId = application.beginBackgroundTask(expirationHandler: {
            print("SCBackgroundManager - task \(bgTaskId as Int) expired\n")
            let application: UIApplication = UIApplication.shared
            application.endBackgroundTask(bgTaskId)
            _ = self.beginNewBackgroundTask()
        })
        
        if self.masterTaskId == UIBackgroundTaskInvalid {
            self.masterTaskId = bgTaskId
            print("SCBackgroundManager - started master task \(self.masterTaskId)\n")
        } else {
            // add this ID to our list
            print("SCBackgroundManager - started background task \(bgTaskId as Int)\n")
            self.taskIdList.add(bgTaskId)
            //self.endBackgr
        }
        self.beginAction?()
        return bgTaskId

    }
    
    /// <#Description#>
    func endBackgroundTask(){
        self.drainBGTaskList(false)
    }
    
    /// <#Description#>
    func endAllBackgroundTasks() {
        self.drainBGTaskList(true)
    }
    
    func drainBGTaskList(_ all:Bool) {
        //mark end of each of our background task
        let application: UIApplication = UIApplication.shared
//        let endBackgroundTask : Selector = #selector(SCBackgroundManager.endBackgroundTask)
        let count: Int = self.taskIdList.count
        for idx in (all==true ? 0:1) ..< count {
            let bgTaskId : UIBackgroundTaskIdentifier = self.taskIdList.object(at: idx) as! Int
            print("SCBackgroundManager - ending background task with id \(bgTaskId as Int)\n")
            application.endBackgroundTask(bgTaskId)
            self.taskIdList.removeObject(at: 0)
        }
        
        if self.taskIdList.count > 0 {
            print("SCBackgroundManager - kept background task id \(self.taskIdList.object(at: 0))\n")
        }
        
        if all == true {
            print("SCBackgroundManager - no more background tasks running\n")
            application.endBackgroundTask(self.masterTaskId)
            self.masterTaskId = UIBackgroundTaskInvalid
        } else {
            print("SCBackgroundManager - kept master background task id \(self.masterTaskId)\n")
        }
        self.endAction?()
        
    }

}
