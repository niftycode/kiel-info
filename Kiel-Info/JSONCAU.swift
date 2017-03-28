//
//  JSONCAU.swift
//  Kiel-Info
//
//  Created by Bodo Schönfeld on 17/08/15.
//  Copyright (c) 2015 Bodo Schönfeld. All rights reserved.
//

import Foundation

class JSONCAU: NSObject {
    
    var cauArray = [CAUData]()
    
    func readFromJSONMapDictionary(_ d: Dictionary<String, AnyObject>) -> [CAUData] {
        
        let locations = d["locations"] as! Dictionary<String, AnyObject>
        
        for (_, value) in locations {
            
            let cauData = CAUData.fromJSONObject(value as! Dictionary<String, AnyObject>)
            cauArray.append(cauData!)
            
        }
        return cauArray
        
    }
}
