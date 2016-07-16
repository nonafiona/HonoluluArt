//
//  Artwork.swift
//  HonoluluArt
//
//  Created by Fiona Carty on 7/11/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation
import MapKit
import Contacts
// previously was : import AddressBook

class Artwork: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    class func fromJSON(json: [JSONValue]) -> Artwork? {
        // 1 
        // 
        var title: String
        if let titleOrNil = json[16].string {
            title = titleOrNil
        } else {
            title = ""
        }
        let locationName = json[12].string
        let discipline = json[15].string
        
        // 2
        let latitude = (json[18].string! as NSString).doubleValue
        let longitude = (json[19].string! as NSString).doubleValue
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        // 3 
        
        return Artwork(title: title, locationName: locationName!, discipline: discipline!, coordinate: coordinate)
    }
    var subtitle: String? {
        return locationName
    }
    
    
    
    // annotation callout info button opens this mapItem in Maps app
    
    // hahahaaahah !!! it worked !!! thank u stack overflow :") 
    // recasted objects and delegated them to self? 
    func mapItem() -> MKMapItem {
        
        
        
        let addressDictionary = [String(CNPostalAddressStreetKey): self.subtitle!]
        // experimental change ^ ^ ^ ^ ^
        // previously was : [String(kABPersonAddressStreetKey): self.subtitle as! AnyObject] ^ ^ ^ ^
        
        let placemark = MKPlacemark(coordinate: self.coordinate, addressDictionary: addressDictionary)
        let mapItem = MKMapItem(placemark: placemark)
        
        mapItem.name = self.title
        
        return mapItem
    }
}