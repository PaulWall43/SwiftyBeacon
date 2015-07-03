//
//  BeaconFinder.swift
//  SwiftBeacon
//
//  Created by Paul Wallace on 7/3/15.
//  Copyright (c) 2015 Paul Wallace. All rights reserved.
//

import UIKit
import CoreLocation

//Class responsible for finding the beacons
class BeaconFinder: NSObject, CLLocationManagerDelegate {
    
        class var SharedInstance : BeaconFinder {
            struct Singleton {
                static let instance = BeaconFinder()
            }
            return Singleton.instance
        }
    
   var myBeaconRegion : CLBeaconRegion = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "4568D9B6-F3F8-4E99-9AB6-350D92825A2E"), identifier:"com.ef.myRegion")
    var locationManager : CLLocationManager = CLLocationManager()
    var alreadyInRegion : Int = 0
    internal var contentsArray : NSMutableArray = []
    
    override init(){
        super.init()
        locationManager.delegate = self
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse) {
            locationManager.requestAlwaysAuthorization()
            //println("requesting")
        }
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringForRegion(myBeaconRegion)
        locationManager.startRangingBeaconsInRegion(myBeaconRegion)
        //locationManager(locationManager, didStartMonitoringForRegion: myBeaconRegion)
        requestNotificationAuth()
    }
    
    func requestNotificationAuth(){
        var types = UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound
        var mySettings = UIUserNotificationSettings(forTypes: types, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(mySettings)
        println("Hi from sweden")
    }
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        locationManager.startRangingBeaconsInRegion(myBeaconRegion)
        //println("DEnterR from Root
    }
    
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
        locationManager.stopRangingBeaconsInRegion(myBeaconRegion)
        notifyUser(description:"See ya later!")
        alreadyInRegion = 0;
        //println("DExitR from Root")
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        //println("Please")
        var beacon :CLBeacon = CLBeacon()
        if(beacons.count < 1){
            return
        }
        if(alreadyInRegion == 0){
            notifyUser(description: "Welcome to your zone!")
            sendUserInfo()
            //println("notify from range")
            alreadyInRegion++;
        }
        
    }
    
    func notifyUser(description aDescription: String){
        var currentSettings = UIApplication.sharedApplication().currentUserNotificationSettings()
        UIApplication.sharedApplication().registerUserNotificationSettings(currentSettings)
        var notification = UILocalNotification()
        notification.alertBody = aDescription
        notification.alertAction = "Notifications are working"
        notification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().presentLocalNotificationNow(notification)
    }
    
    func sendUserInfo(){
        //create a file path to the json file
        var jsonFilePath : String = NSBundle.mainBundle().pathForResource("testData", ofType: "json")!
        //Create a data object from this file path
        var jsonData : NSData = NSData(contentsOfFile: jsonFilePath)!
        //set NSError to nil
        var jsonError : NSError?
        //Create a swift object of these objects
        var swiftObject : AnyObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.AllowFragments, error: &jsonError)!
        //cast this down to a know type whatever it may be and log the result
        if let nsDictionaryObject = swiftObject as? NSDictionary {
            if let swiftDictionary = nsDictionaryObject as Dictionary? {
                println(swiftDictionary)
            }
        }
        if let nsArrayObject = swiftObject as? NSArray {
            if let swiftArray = nsArrayObject as Array? {
                println(swiftArray)
            }
        }
        
        /* Differet set of testing */
        var testToDoItem : ToDoItem = ToDoItem(title: "Get wrecked")
        contentsArray.addObject(testToDoItem)
        /* End of testing */
    }
}
