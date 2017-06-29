//
//  Data.swift
//  SCSwift
//
//  Created by Timoshenko on 29/06/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
//
import MapKit


extension MKMapView {
 
    
    /// <#Description#>
    ///
    /// - Parameter location: <#location description#>
    public func zoomToLocation(_ location: CLLocationCoordinate2D! = CLLocationCoordinate2D()) {
    
        self.showsUserLocation = true
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.delegate = self
//        
//        //Check for Location Services
//        if (CLLocationManager.locationServicesEnabled()) {
//            locationManager = CLLocationManager()
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            locationManager.requestAlwaysAuthorization()
//            locationManager.requestWhenInUseAuthorization()
//        }
//        locationManager.requestWhenInUseAuthorization()
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.startUpdatingLocation()
//        }
//        //Zoom to user location
//        let noLocation = CLLocationCoordinate2D()
        let viewRegion = MKCoordinateRegionMakeWithDistance(location, 200, 200)
        self.setRegion(viewRegion, animated: false)
//        DispatchQueue.main.async {
//            self.locationManager.startUpdatingLocation()
//        }

    }
    
}
