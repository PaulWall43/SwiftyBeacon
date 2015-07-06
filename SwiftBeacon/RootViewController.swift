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
    let dataManager : DataManager = DataManager.SharedInstance
    //let eventTableViewController : EventTableViewController = EventTableViewController.SharedInstance
    
    @IBOutlet weak var eventsHostingButton: UIButton!
    @IBOutlet weak var eventsAttendingButton: UIButton!
    @IBOutlet weak var addOrEditEventButton: UIButton!
    @IBOutlet weak var eventsHappeningNowButton: UIButton!
    @IBOutlet weak var testTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
