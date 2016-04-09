//
//  FinanceData.swift
//  Kiel-Info
//
//  Created by Bodo Schönfeld on 17/08/15.
//  Copyright (c) 2015 Bodo Schönfeld. All rights reserved.
//

import Foundation
import MapKit

class FinanceData: NSObject, MKAnnotation {
    
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    let info: String
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.info = info
        
        super.init()
    }
    
    class func fromJSONObject (d: Dictionary<String, AnyObject>) -> FinanceData? {
        
        let weekday = ["Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "Sonntag"]
        
        let place = d["location"] as! String
        let address = d["address"] as! String
        let coordinates = d["coordinates"] as! Array as [Double]
        let latitude = coordinates[0]
        let longitude = coordinates[1]
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let days = d["days"] as! Array as [AnyObject]
        
        var mergedArray = [String]()
        
        var j: Int = 0
        
        for i in 0 ..< weekday.count {
            var temp:String = days[j] as! String
            if !(temp as NSString).containsString("null") {
                mergedArray.append("\(weekday[i]): \(days[j]) Uhr")
                
            }
            j += 1
        }
        
        var info = mergedArray.reduce("", combine: { $0 == "" ? $1 : $0 + "\n " + $1 })
        
        var title: String! {
            if place.isEmpty {
                return "(No Description)"
            } else {
                return place
            }
        }
        
        var subtitle: String {
            if address.isEmpty {
                return "no address"
            } else {
                return address
            }
        }
        
        return FinanceData(title: title, subtitle: subtitle, coordinate: coordinate, info: info)
        
    }
}
