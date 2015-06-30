//
//  ViewController.swift
//  SwiftBeacon
//
//  Created by Paul Wallace on 6/30/15.
//  Copyright (c) 2015 Paul Wallace. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    var myBeaconRegion : CLBeaconRegion = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "4568D9B6-F3F8-4E99-9AB6-350D92825A2E"), identifier:"com.ef.myRegion")
    var locationManager : CLLocationManager = CLLocationManager()
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var UUIDLabel: UILabel!
    @IBOutlet weak var MajorLabel: UILabel!
    @IBOutlet weak var MinorLabel: UILabel!
    @IBOutlet weak var AccuracyLabel: UILabel!
    @IBOutlet weak var DistanceLabel: UILabel!
    @IBOutlet weak var RSSILabel: UILabel!
    
    var alreadyInRegion = 0
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //statusLabel.backgroundColor = UIColor(red: 0, green: 100, blue: 100, alpha: 1)
        locationManager.delegate = self
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse) { locationManager.requestAlwaysAuthorization() }
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringForRegion(myBeaconRegion)
        locationManager(locationManager, didStartMonitoringForRegion: myBeaconRegion as CLBeaconRegion)
        println("Hey")
    }
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        locationManager.startRangingBeaconsInRegion(myBeaconRegion)
        //notify the user
    }
    
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
        locationManager.stopRangingBeaconsInRegion(myBeaconRegion)
        statusLabel.backgroundColor = UIColor(red: 0, green: 100, blue: 100, alpha: 1)
    }
    
    func locationManager(manager: CLLocationManager!, didStartMonitoringForRegion region: CLRegion!) {
        locationManager.startRangingBeaconsInRegion(myBeaconRegion)
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
//        if(beacons.count < 1){return}
        if(alreadyInRegion == 0){/*notify the user*/ alreadyInRegion++}
        var beacon :CLBeacon = CLBeacon()
        if(beacons.count < 1){
            statusLabel.text = "Disconnected"
            statusLabel.backgroundColor = UIColor(red: 0, green: 255, blue: 0, alpha: 1)
            UUIDLabel.text = "null"
            MajorLabel.text = "null"
            MinorLabel.text = "null"
            AccuracyLabel.text = "-1"
            RSSILabel.text = "0"
            return
        }
        beacon = beacons[0] as CLBeacon
        statusLabel.text = "Connected"
        statusLabel.backgroundColor = UIColor(red: 0, green: 78, blue: 12, alpha: 1)
        UUIDLabel.text = beacon.proximityUUID.UUIDString
        MajorLabel.text = NSString(string: "\(beacon.major)")
        MinorLabel.text = NSString(string: "\(beacon.minor)")
        AccuracyLabel.text = NSString(string:  "\(beacon.accuracy)")
        RSSILabel.text = NSString(string: "\(beacon.rssi)")
        //Assign the distanceLabel
        if(beacon.proximity == CLProximity.Unknown){
            DistanceLabel.text = "Unknown proximity"
        }
        if(beacon.proximity == CLProximity.Far){
            DistanceLabel.text = "Far"
        }
        if(beacon.proximity == CLProximity.Near){
            DistanceLabel.text = "Near"
        }
        if(beacon.proximity == CLProximity.Immediate){
            DistanceLabel.text = "Immediate"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

