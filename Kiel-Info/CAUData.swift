//
//  CAUData.swift
//  Kiel-Info
//
//  Created by Bodo Schönfeld on 17/08/15.
//  Copyright (c) 2015 Bodo Schönfeld. All rights reserved.
//

import Foundation
import MapKit

class CAUData: NSObject, MKAnnotation {
    
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        
        super.init()
    }
    
    class func fromJSONObject (_ d: Dictionary<String, AnyObject>) -> CAUData? {
        
        let place = d["location"] as! String
        let additionalInfo = d["info"] as! String
        let coordinates = d["coordinates"] as! Array as [Double]
        let latitude = coordinates[0]
        let longitude = coordinates[1]
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        var title: String! {
            if place.isEmpty {
                return "(No Description)"
            } else {
                return place
            }
        }
        
        var subtitle: String {
            if additionalInfo.isEmpty {
                return "no additional info"
            } else {
                return additionalInfo
            }
        }
        
        return CAUData(title: title, subtitle: subtitle, coordinate: coordinate)
        
    }
}
