//
//  StartViewController.swift
//  Kiel-Info
//
//  Created by Bodo Schönfeld on 30.07.15.
//  Copyright (c) 2015 Bodo Schönfeld. All rights reserved.
//

import UIKit

class StartViewController: UITableViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    
    lazy var jsonItem = JSONItems()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 64
        
        self.setup()
    }
    
    func setup() {
        
        let filePath = Bundle.main.path(forResource: "items",ofType:"json")
        
        var readError:NSError?
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath!),
                options: NSData.ReadingOptions.uncached)
                self.getData(data)
        } catch let error as NSError {
            readError = error
            print(readError ?? "Error")
        }
    }

    func getData(_ data: Data) {
        
        let jsonResult: AnyObject = (try! JSONSerialization.jsonObject(with: data,
            options: JSONSerialization.ReadingOptions.mutableContainers)) as! Dictionary<String, AnyObject> as AnyObject
        
        jsonItem.readFromJSONDictionary(jsonResult as! Dictionary<String, AnyObject>)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return jsonItem.jsonArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationItem", for: indexPath) 
        
        let item = jsonItem.jsonArray[indexPath.row]
        
        configureTextForCell(cell, withItemData: item)

        return cell
    }
    
    func configureTextForCell(_ cell: UITableViewCell, withItemData item: ItemData) {
        
        let nameLabel = cell.viewWithTag(1001) as! UILabel
        nameLabel.text = item.name
        let aboutLabel = cell.viewWithTag(1002) as! UILabel
        aboutLabel.text = item.about
    }

    func getNameLabel(_ cell: UITableViewCell) -> String {
        
        let nameLabel = cell.viewWithTag(1001) as! UILabel
        let name = nameLabel.text
        return name!
        
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowMap" {
            
            let selectedIndexPath = tableView.indexPathForSelectedRow
            let cell = tableView.cellForRow(at: selectedIndexPath!)
            let name = getNameLabel(cell!)
            
            if let navigationController = segue.destination as? UINavigationController {
                if let destination = navigationController.topViewController as? MapViewController {
                        destination.selectedMap = name
            
                }
            }
        }
    }
}

