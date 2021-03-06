//
//  JSONItems.swift
//  Kiel-Info
//
//  Created by Bodo Schönfeld on 17/08/15.
//  Copyright (c) 2015 Bodo Schönfeld. All rights reserved.
//

import Foundation

class JSONItems: NSObject {
    
    var jsonArray = [ItemData]()
    
    // places names
    func readFromJSONDictionary(_ d: Dictionary<String, AnyObject>) {
        
        let locations = d["location"] as! Dictionary<String, AnyObject>
        
        for (_, value) in locations {
            
            let i = ItemData()
            i.showJSONItems(value as! Dictionary<String, NSObject>)
            jsonArray.append(i)
        }
    }
}
