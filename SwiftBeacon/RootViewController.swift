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
    

    
    var eventModelArray : NSMutableArray = [] //just keeping for now
    let beaconFinder : BeaconFinder = BeaconFinder.SharedInstance
    
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
        return eventModelArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier : String = "testTableCell"
        var testCell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("testTableCell") as UITableViewCell
        var testEventModel : EventModel = self.eventModelArray.objectAtIndex(indexPath.row) as EventModel
        testCell.textLabel?.text = testEventModel.title
        if testEventModel.completed{
            testCell.accessoryType = .Checkmark
        }
        else{
            testCell.accessoryType = .None;
        }
        return testCell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        testTableView.deselectRowAtIndexPath(indexPath, animated: false)
        var tappedItem : EventModel = eventModelArray.objectAtIndex(indexPath.row) as EventModel
        tappedItem.completed = !tappedItem.completed
        testTableView.reloadData()
    }

}
