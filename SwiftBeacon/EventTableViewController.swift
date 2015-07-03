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
    
    var eventItems : NSMutableArray = []
    var informationSource : BeaconFinder = BeaconFinder.SharedInstance
    //let rootViewController : RootViewController = RootViewController()
    
    func loadinitialData(){
        //println(toDoItems)
        var item1 = ToDoItem(title: "Vocabulary Lesson")
        self.eventItems.addObject(item1)
        
        var item2 = ToDoItem(title: "Addition")
        self.eventItems.addObject(item2)
        
        var item3 = ToDoItem(title: "Mathematics")
        self.eventItems.addObject(item3)
    }
    

    
    override func viewDidLoad() {
        self.loadinitialData()
        eventItems.addObjectsFromArray(informationSource.contentsArray)
    }
    func getControllerArrayContents(sourceArray source: NSMutableArray){
        //eventItems.addObjectsFromArray(informationSource.contentsArray
        //eventItems = informationSource.contentsArray
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
        var todoitem: ToDoItem  = self.eventItems.objectAtIndex(indexPath.row) as ToDoItem
        cell.textLabel?.text = todoitem.title;
        if todoitem.completed{
            cell.accessoryType = .Checkmark
        }
        else {
            cell.accessoryType = .None
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        var tappedItem: ToDoItem = self.eventItems.objectAtIndex(indexPath.row) as ToDoItem
        tappedItem.completed = !tappedItem.completed
        tableView.reloadData()
    }
}
