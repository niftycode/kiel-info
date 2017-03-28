//
//  JSONMarkets.swift
//  Kiel-Info
//
//  Created by Bodo Schönfeld on 17/08/15.
//  Copyright (c) 2015 Bodo Schönfeld. All rights reserved.
//

import Foundation

class JSONMarkets: NSObject {
    
    var marketsArray = [MarketData]()
    
    func readFromJSONMapDictionary(_ d: Dictionary<String, AnyObject>) -> [MarketData] {
        
        let locations = d["locations"] as! Dictionary<String, AnyObject>
        
        for (_, value) in locations {
            
            let marketData = MarketData.fromJSONObject(value as! Dictionary<String, AnyObject>)
            marketsArray.append(marketData!)
            
        }
        return marketsArray
        
    }
}
