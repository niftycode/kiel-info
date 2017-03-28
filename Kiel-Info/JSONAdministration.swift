//
//  JSONAdministration.swift
//  Kiel-Info
//
//  Created by Bodo Schönfeld on 01/11/15.
//  Copyright © 2015 Bodo Schönfeld. All rights reserved.
//

import Foundation

class JSONAdministration: NSObject {
    
    var administrationArray = [AdministrationData]()
    
    func readFromJSONMapDictionary(_ d: Dictionary<String, AnyObject>) -> [AdministrationData] {
        
        let locations = d["locations"] as! Dictionary<String, AnyObject>
        
        for (_, value) in locations {
            
            let adminData = AdministrationData.fromJSONObject(value as! Dictionary<String, AnyObject>)
            administrationArray.append(adminData!)
            
        }
        return administrationArray
        
    }
}
