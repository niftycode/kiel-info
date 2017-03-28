//
//  ItemData.swift
//  Kiel-Info
//
//  Created by Bodo Schönfeld on 17/08/15.
//  Copyright (c) 2015 Bodo Schönfeld. All rights reserved.
//

import Foundation

class ItemData: NSObject {
    
    var name: String = ""
    var about: String = ""
    
    func showJSONItems(_ d: Dictionary<String, AnyObject>) {
        
        name = d["name"] as! String
        about = d["description"] as! String
        
    }
    
}
