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
        
        let filePath = NSBundle.mainBundle().pathForResource("items",ofType:"json")
        
        var readError:NSError?
        do {
            let data = try NSData(contentsOfFile:filePath!,
                options: NSDataReadingOptions.DataReadingUncached)
                self.getData(data)
        } catch let error as NSError {
            readError = error
            print(readError)
        }
    }

    func getData(data: NSData) {
        
        let jsonResult: AnyObject = (try! NSJSONSerialization.JSONObjectWithData(data,
            options: NSJSONReadingOptions.MutableContainers)) as! Dictionary<String, AnyObject>
        
        jsonItem.readFromJSONDictionary(jsonResult as! Dictionary<String, AnyObject>)
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return jsonItem.jsonArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("LocationItem", forIndexPath: indexPath) 
        
        let item = jsonItem.jsonArray[indexPath.row]
        
        configureTextForCell(cell, withItemData: item)

        return cell
    }
    
    func configureTextForCell(cell: UITableViewCell, withItemData item: ItemData) {
        
        let nameLabel = cell.viewWithTag(1001) as! UILabel
        nameLabel.text = item.name
        let aboutLabel = cell.viewWithTag(1002) as! UILabel
        aboutLabel.text = item.about
    }

    func getNameLabel(cell: UITableViewCell) -> String {
        
        let nameLabel = cell.viewWithTag(1001) as! UILabel
        let name = nameLabel.text
        return name!
        
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ShowMap" {
            
            let selectedIndexPath = tableView.indexPathForSelectedRow
            let cell = tableView.cellForRowAtIndexPath(selectedIndexPath!)
            let name = getNameLabel(cell!)
            
            if let navigationController = segue.destinationViewController as? UINavigationController {
                if let destination = navigationController.topViewController as? MapViewController {
                        destination.selectedMap = name
            
                }
            }
        }
    }
}

