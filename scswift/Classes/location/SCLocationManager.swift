//
//  SCLocationManager.swift
//  SCSwift
//
//  Created by Timoshenko on 11/05/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

public class SCLocationManager: NSObject, CLLocationManagerDelegate {

    private var on = false
    private var bg : SCBackgroundManager = (SCBackgroundManager.backgroundTaskManager())!
    
    public typealias LocationHandler = (CLLocationManager, [CLLocation]) -> ()
    public typealias FutureAction = () -> ()

    /// <#Description#>
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters // kCLLocationAccuracyBestForNavigation
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        return manager
    }()
    
    private var locHandler : LocationHandler? = nil
    
    /// <#Description#>
    ///
    /// - Parameter locHandler: <#locHandler description#>
    public func setHandler(_ locHandler : LocationHandler!) {
        self.locHandler = locHandler
    }
    
    /// <#Description#>
    public func  start() {
        
        OperationQueue.main.addOperation {
            if !self.on {
                self.locationManager.startUpdatingLocation()
                self.on = true
                _ = self.bg.beginNewBackgroundTask()
            }
        }

    }
    
    /// <#Description#>
    public func  stop() {
        
        OperationQueue.main.addOperation {
            if self.on {
                self.locationManager.stopUpdatingLocation()
                self.on = false
                self.bg.endAllBackgroundTasks()
            }
        }

    }
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - manager: <#manager description#>
    ///   - locations: <#locations description#>
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard locations.last != nil else {
            return
        }
        locHandler?(manager, locations)
/*
        // Add another annotation to the map.
        let annotation = MKPointAnnotation()
        annotation.coordinate = mostRecentLocation.coordinate
        
        // Also add to our map so we can remove old values later
        self.locations.append(annotation)
        
        // Remove values if the array is too big
        while locations.count > 100 {
            let annotationToRemove = self.locations.first!
            self.locations.remove(at: 0)
            
            // Also remove from the map
            mapView.removeAnnotation(annotationToRemove)
        }
        
        if UIApplication.shared.applicationState == .active {
            mapView.showAnnotations(self.locations, animated: true)
        } else {
            print("App is backgrounded. New location is %@", mostRecentLocation)
        }
*/
    }

    /// <#Description#>
    ///
    /// - Parameters:
    ///   - always: <#always description#>
    ///   - f: <#f description#>
    public func checkForLocationAccess(always:Bool = false, andThen f: FutureAction? = nil) {
        // no services? fail but try get alert
        guard CLLocationManager.locationServicesEnabled() else {
            print("no location services")
            self.start()
            return
        }
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            f?()
        case .notDetermined:
//            self.doThisWhenAuthorized = f
            always ?
                self.locationManager.requestAlwaysAuthorization() :
                self.locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // do nothing
            break
        case .denied:
            print("denied")
            // do nothing, or beg the user to authorize us in Settings
            break
        }
    }

}
