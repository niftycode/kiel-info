//
//  MapViewController.swift
//  Kiel-Info
//
//  Created by Bodo Schönfeld on 01/08/15.
//  Copyright (c) 2015 Bodo Schönfeld. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    lazy var jsonMarkets = JSONMarkets()
    lazy var jsonCAU = JSONCAU()
    lazy var jsonFinance = JSONFinance()
    
    var location: String = ""
    var markets = [MarketData]()
    var cau = [CAUData]()
    var finance = [FinanceData]()
    var selectedMap: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        switch selectedMap {
        case "Wochenmärkte":
            location = "wochenmarkt"
        case "Christian-Albrechts-Universität zu Kiel":
            location = "cau"
        case "Finanzämter":
            location = "finanzamt"
        default:
            print("another place")
        }
        
        self.fetchDataFromJSONFile()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        updatePlaces()
    }
    
    // MARK: - JSON stuff
    
    func fetchDataFromJSONFile() {
        
        let filePath = NSBundle.mainBundle().pathForResource(location, ofType: "json")
        
        var err: NSError?
        do {
            let data = try NSData(contentsOfFile: filePath!, options: NSDataReadingOptions.DataReadingUncached)
            self.getData(data)
        } catch let error as NSError {
            err = error
        }
        
    }
    
    func getData(data: NSData) {
        
        let jsonResult = (try! NSJSONSerialization.JSONObjectWithData(data,
            options: NSJSONReadingOptions.MutableContainers)) as! Dictionary<String, AnyObject>
        
        switch selectedMap {
        case "Wochenmärkte":
            markets = jsonMarkets.readFromJSONMapDictionary(jsonResult)
        case "Christian-Albrechts-Universität zu Kiel":
            cau = jsonCAU.readFromJSONMapDictionary(jsonResult)
        case "Finanzämter":
            finance = jsonFinance.readFromJSONMapDictionary(jsonResult)
        default:
            print("another place")
        }
    }
    
    // MARK: - Add annotations
    
    func updatePlaces() {
        
        switch selectedMap {
        case "Wochenmärkte":
            mapView.removeAnnotations(markets)
            
            mapView.addAnnotations(markets)
            
            let region = regionForAnnotations(markets)
            mapView.setRegion(region, animated: true)
        case "Christian-Albrechts-Universität zu Kiel":
            mapView.removeAnnotations(cau)
            
            mapView.addAnnotations(cau)
            
            let region = regionForAnnotations(cau)
            mapView.setRegion(region, animated: true)
        case "Finanzämter":
            mapView.removeAnnotations(finance)
            
            mapView.addAnnotations(finance)
            
            let region = regionForAnnotations(finance)
            mapView.setRegion(region, animated: true)
        default:
            print("another place")
        }
    }
    
    func regionForAnnotations(annotations: [MKAnnotation]) -> MKCoordinateRegion {
        
        var region: MKCoordinateRegion
        
        switch annotations.count {
        case 0:
            region = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 1000, 1000)
        case 1:
            let annotation = annotations[annotations.count - 1]
            region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 1000, 1000)
        default:
            var topLeftCoord = CLLocationCoordinate2D(latitude: -90, longitude: 180)
            var bottomRightCoord = CLLocationCoordinate2D(latitude: 90, longitude: -180)
            
            for annotation in annotations {
                topLeftCoord.latitude = max(topLeftCoord.latitude, annotation.coordinate.latitude)
                topLeftCoord.longitude = min(topLeftCoord.longitude, annotation.coordinate.longitude)
                bottomRightCoord.latitude = min(bottomRightCoord.latitude, annotation.coordinate.latitude)
                bottomRightCoord.longitude = max(bottomRightCoord.longitude, annotation.coordinate.longitude)
            }
            
            let center = CLLocationCoordinate2D(latitude: topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) / 2, longitude: topLeftCoord.longitude - (topLeftCoord.longitude - bottomRightCoord.longitude) / 2)
            
            let extraSpace = 1.2
            let span = MKCoordinateSpan(latitudeDelta: abs(topLeftCoord.latitude - bottomRightCoord.latitude) * extraSpace, longitudeDelta: abs(topLeftCoord.longitude - bottomRightCoord.longitude) * extraSpace)
            
            region = MKCoordinateRegion(center: center, span: span)
        }
        return mapView.regionThatFits(region)
        
    }
    
    // MARK: - actions
    
    @IBAction func done(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
