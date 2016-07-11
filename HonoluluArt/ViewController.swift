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
    }


}

