//
//  ViewController.swift
//  HonoluluArt
//
//  Created by Fiona Carty on 7/11/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setting initial location as Honolulu
        
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        centerMapOnLocation(initialLocation)
        
        // useless test obj.
        
        //let artwork = Artwork(title: "King David Kalakaua",
        //locationName: "Waikiki Gateway Park",
        //discipline: "Sculpture",
        //coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
        //mapView.addAnnotation(artwork)
        
        
        loadInitialData()
        mapView.addAnnotations(artworks)
        
        // mapView delegate
        mapView.delegate = self
    }
    
    var artworks = [Artwork]()
    
    func loadInitialData() {
        // 1
        let fileName = NSBundle.mainBundle().pathForResource("PublicArt", ofType: "json");
        var readError : NSError?
        var data: NSData = try! NSData(contentsOfFile: fileName!, options: NSDataReadingOptions(rawValue: (0)))
        
        // 2
        var error: NSError?
        let jsonObject: AnyObject!
        do {
            jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0))
        } catch var error1 as NSError {
            error = error1
            jsonObject = nil
        }
        
        
        // 3
        if let jsonObject = jsonObject as? [String: AnyObject] where error == nil,
            // 4
            let jsonData = JSONValue.fromObject(jsonObject)?["data"]?.array {
            for artworkJSON in jsonData {
                if let artworkJSON = artworkJSON.array,
                    // 5
                    artwork = Artwork.fromJSON(artworkJSON) {
                    artworks.append(artwork)
                }
            }
        }
    }

    

    

    let regionRadius: CLLocationDistance = 1000 // 1 km or 1000 meters or little bit over 1/2 mile
    func centerMapOnLocation(location: CLLocation) {
        // regionRadius * 2.0 works well because it is to scale with the public artwork data in the JSON file
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

}

