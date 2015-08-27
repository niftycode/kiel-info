//
//  Annotations.swift
//  Kiel-Info
//
//  Created by Bodo Schönfeld on 09/08/15.
//  Copyright (c) 2015 Bodo Schönfeld. All rights reserved.
//

import MapKit

/*
enum UIAlertControllerStyle: Int {
    case ActionSheet
    case Alert
}
*/

extension MapViewController: MKMapViewDelegate {
    
    // add annotation callout
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        let identifier = "Places"
        
        if annotation.isKindOfClass(MarketData.self) || annotation.isKindOfClass(FinanceData.self) {
            
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
            
            if annotationView == nil {
                
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView.canShowCallout = true
                
                let btn = UIButton.buttonWithType(.DetailDisclosure) as! UIButton
                annotationView.rightCalloutAccessoryView = btn
                
                
            } else {
                
                annotationView.annotation = annotation
                
            }
            return annotationView
        }
        return nil
        
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        
        if selectedMap == "Wochenmärkte" {
            if let item = view.annotation as? MarketData {
                let alert = UIAlertController(title: item.title, message: item.info, preferredStyle: .ActionSheet)
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                presentViewController(alert, animated: true, completion: nil)
            }
        } else {
            if let item = view.annotation as? FinanceData {
                let alert = UIAlertController(title: item.title, message: item.info, preferredStyle: .ActionSheet)
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                presentViewController(alert, animated: true, completion: nil)
            }
        }
        
        
    }
}
