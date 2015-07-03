//
//  ToDoTableViewController.swift
//  SwiftBeacon
//
//  Created by Paul Wallace on 6/30/15.
//  Copyright (c) 2015 Paul Wallace. All rights reserved.
//

import UIKit

class EventTableViewController: UITableViewController {
    
    class var SharedInstance : EventTableViewController {
        struct Singleton {
            static let instance = EventTableViewController()
        }
        return Singleton.instance
    }
    
    var color : UIColor?
    var eventItems : NSMutableArray = []
    var informationSource : BeaconFinder = BeaconFinder.SharedInstance
    //let rootViewController : RootViewController = RootViewController()
    
    func loadinitialData(){
    }
    
    override func viewDidLoad() {
        self.loadinitialData()
        if(informationSource.contentArray.count > 0){
            eventItems.addObjectsFromArray(informationSource.contentArray)
        }
    }
    func getControllerArrayContents(sourceArray source: NSMutableArray){
        //eventItems.addObjectsFromArray(informationSource.contentArray
        //eventItems = informationSource.contentArray
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier: NSString = "ToDoPrototypeCell"
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as UITableViewCell
        var eventModel: EventModel  = self.eventItems.objectAtIndex(indexPath.row) as EventModel
        cell.textLabel?.text = eventModel.title;
        if eventModel.completed{
            cell.accessoryType = .Checkmark
        }
        else {
            cell.accessoryType = .None
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        var tappedItem: EventModel = self.eventItems.objectAtIndex(indexPath.row) as EventModel
        tappedItem.completed = !tappedItem.completed
        tableView.reloadData()
    }
}
