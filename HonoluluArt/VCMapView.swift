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
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
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
                view.rightCalloutAccessoryView = UIButton(type:.DetailDisclosure) as UIView
            }
            return view
        }
         return nil
    }
    
    // delegates to provide the correct address when the callout button is tapped...
    
    // basically, when a user taps on a map annotation pin, the callout shows an info button
    // when the user taps the info button, calloutAccessoryControlTapped method is called!
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        
        // grabs Artwork object that the tap refers to
        
        let location = view.annotation as! Artwork
        
        // creates associated MKMapItem & calls openInMapsWithLaunchOptions upon the the map item
        // passes a Dictionary through this method
        // sets DirectionModeKeys to Driving 
        // - which will show driving directions from the user's location to the pin
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMapsWithLaunchOptions(launchOptions)
    }
}
