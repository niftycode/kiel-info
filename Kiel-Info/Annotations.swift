//
//  Annotations.swift
//  Kiel-Info
//
//  Created by Bodo Schönfeld on 09/08/15.
//  Copyright (c) 2015 Bodo Schönfeld. All rights reserved.
//

import MapKit

extension MapViewController: MKMapViewDelegate {
    
    // add annotation callout
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "Places"
        
        if annotation.isKind(of: MarketData.self) || annotation.isKind(of: FinanceData.self) {
            
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = true
                
                let btn = UIButton(type: .detailDisclosure)
                annotationView!.rightCalloutAccessoryView = btn
                
                
            } else {
                
                annotationView!.annotation = annotation
                
            }
            return annotationView
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if selectedMap == "Wochenmärkte" {
            if let item = view.annotation as? MarketData {
                let alert = UIAlertController(title: item.title, message: item.info, preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        } else {
            if let item = view.annotation as? FinanceData {
                let alert = UIAlertController(title: item.title, message: item.info, preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        }
    }
}
