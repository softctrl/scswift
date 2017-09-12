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
        let viewRegion = MKCoordinateRegionMakeWithDistance(location, 2400, 2400)
        self.setRegion(viewRegion, animated: false)

    }

    /// Based on:
    /// https://gist.github.com/andrewgleave/915374
    /// Author: https://gist.github.com/ekussberg
    public func fitMapViewToAnnotaionList() -> Void {

        let mapEdgePadding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        var zoomRect:MKMapRect = MKMapRectNull
        
        for index in 0..<self.annotations.count {
            let annotation = self.annotations[index]
            let aPoint:MKMapPoint = MKMapPointForCoordinate(annotation.coordinate)
            let rect:MKMapRect = MKMapRectMake(aPoint.x, aPoint.y, 0.1, 0.1)
            
            if MKMapRectIsNull(zoomRect) {
                zoomRect = rect
            } else {
                zoomRect = MKMapRectUnion(zoomRect, rect)
            }
        }
        self.setVisibleMapRect(zoomRect, edgePadding: mapEdgePadding, animated: true)

    }
    
}
