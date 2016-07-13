//
//  VCMapView.swift
//  HonoluluArt
//
//  Created by Fiona Carty on 7/11/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation
import MapKit

extension ViewController: MKMapViewDelegate {
    
  // debug this entire block of code because it sucks :-/
    //1 
    // the method that gets called for every annotation you add to the map
    // similar to table view(_:cellForRowAtIndexPath:)
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView {
        if let annotation = annotation as? Artwork {
            let identifier = "pin"
            var view: MKPinAnnotationView
            // 2 
            // map views are set up to reuse annotation views when some are no longer visible
            // the code first checks to see if a reusable annotation view is available 
            // before creating a new one
            
            // when you dequeue a reusable annotation, you give it an identifier
            // if you have multiple styles of annotations make sure you use 
            // a unique identifier for each different style
            
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                // 3 
                // uses the title and the subtitle properties to determine what to show in the callout
                // the little bubble that pops up when the user taps the pin
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIView
            }
            return view
        }
        // return nil
    }
}
