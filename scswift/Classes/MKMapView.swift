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
        let viewRegion = MKCoordinateRegionMakeWithDistance(location, 600, 600)
        self.setRegion(viewRegion, animated: false)

    }
    
}
