//
//  MarketData.swift
//  Kiel-Info
//
//  Created by Bodo Schönfeld on 17/08/15.
//  Copyright (c) 2015 Bodo Schönfeld. All rights reserved.
//

import Foundation
import MapKit

class MarketData: NSObject, MKAnnotation {
    
    let title: String?
    let coordinate: CLLocationCoordinate2D
    let info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
        
        super.init()
    }
    
    class func fromJSONObject (d: Dictionary<String, AnyObject>) -> MarketData? {
        
        let weekday = ["Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "Sonntag"]
        
        let place = d["location"] as! String
        let coordinates = d["coordinates"] as! Array as [Double]
        let latitude = coordinates[0]
        let longitude = coordinates[1]
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let days = d["days"] as! Array as [AnyObject]
        
        var mergedArray = [String]()
        
        var j: Int = 0
        
        for var i = 0; i < weekday.count; i++ {
            var temp:String = days[j] as! String
            if !(temp as NSString).containsString("null") {
                mergedArray.append("\(weekday[i]): \(days[j]) Uhr")
                
            }
            j++
        }
        
        var title: String! {
            if place.isEmpty {
                return "(No Description)"
            } else {
                return place
            }
        }
        
        let info = mergedArray.reduce("", combine: { $0 == "" ? $1 : $0 + "\n " + $1 })
        
        return MarketData(title: title, coordinate: coordinate, info: info)
        
    }
    
    /*
    var subtitle: String {
        return ""
    }
    */
    
}
