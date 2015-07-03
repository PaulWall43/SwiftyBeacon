//
//  RootViewController.swift
//  SwiftBeacon
//
//  Created by Paul Wallace on 7/1/15.
//  Copyright (c) 2015 Paul Wallace. All rights reserved.
//

import UIKit
import CoreLocation

class RootViewController: UIViewController {
    

    
    var toDoItemArray : NSMutableArray = [] //just keeping for now
    let beaconFinder : BeaconFinder = BeaconFinder()
    
    @IBOutlet weak var eventsHostingButton: UIButton!
    @IBOutlet weak var eventsAttendingButton: UIButton!
    @IBOutlet weak var addOrEditEventButton: UIButton!
    @IBOutlet weak var eventsHappeningNowButton: UIButton!
    @IBOutlet weak var testTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //println(toDoItemArray.count)
        return toDoItemArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier : String = "testTableCell"
        var testCell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("testTableCell") as UITableViewCell
        var testToDoItem : ToDoItem = self.toDoItemArray.objectAtIndex(indexPath.row) as ToDoItem
        testCell.textLabel?.text = testToDoItem.title
        if testToDoItem.completed{
            testCell.accessoryType = .Checkmark
        }
        else{
            testCell.accessoryType = .None;
        }
        return testCell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        testTableView.deselectRowAtIndexPath(indexPath, animated: false)
        var tappedItem :ToDoItem = toDoItemArray.objectAtIndex(indexPath.row) as ToDoItem
        tappedItem.completed = !tappedItem.completed
        testTableView.reloadData()
    }

}
