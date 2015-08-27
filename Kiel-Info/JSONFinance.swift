//
//  JSONFinance.swift
//  Kiel-Info
//
//  Created by Bodo Schönfeld on 17/08/15.
//  Copyright (c) 2015 Bodo Schönfeld. All rights reserved.
//

import Foundation

class JSONFinance: NSObject {
    
    var financeArray = [FinanceData]()
    
    func readFromJSONMapDictionary(d: Dictionary<String, AnyObject>) -> [FinanceData] {
        
        let locations = d["locations"] as! Dictionary<String, AnyObject>
        
        for (location, value) in locations {
            
            var financeData = FinanceData.fromJSONObject(value as! Dictionary<String, AnyObject>)
            financeArray.append(financeData!)
            
        }
        return financeArray
        
    }
}