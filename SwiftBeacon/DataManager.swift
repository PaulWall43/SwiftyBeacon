//
//  DataManager.swift
//  SwiftBeacon
//
//  Created by Paul Wallace on 7/6/15.
//  Copyright (c) 2015 Paul Wallace. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    
    class var SharedInstance : DataManager{
        struct Singleton {
            static let instance = DataManager()
        }
        return Singleton.instance
    }
    
    internal var contentArray : NSMutableArray = []
    internal var currentEventModel : EventModel = EventModel(title: "holder")
    //let eventTableViewController : EventTableViewController = EventTableViewController.SharedInstance
    
    func getCurrentEventModel(beaconUUID: String, didGetBeaconMajor beaconMajor: String, didGetBeaconMinor beaconMinor: String){
        //create a file path to the json file
        var jsonFilePath : String = NSBundle.mainBundle().pathForResource("testData", ofType: "json")!
        //Create a data object from this file path
        var jsonData : NSData = NSData(contentsOfFile: jsonFilePath)!
        var json = JSON(data: jsonData)
        if let eventArray = json["events"].array {
            /*Loop through the array and find the correct event based on Beacon information*/
            var eventNumber: Int = 0
            for(eventNumber; eventNumber < eventArray.count; eventNumber++){
                if(eventArray[eventNumber]["beaconUUID"].string == beaconUUID as String &&
                    eventArray[eventNumber]["beaconMinor"].string == beaconMinor){
                        break;
                }
            }
            if(eventNumber == eventArray.count){
                println("Event not here")
                return
            }
            /*Now we have found it lets store the contents into a EventModel*/
            currentEventModel = EventModel(title: eventArray[eventNumber]["title"].string!)
            currentEventModel.descriptionOfEvent = eventArray[eventNumber]["descriptionOfEvent"].string!
            currentEventModel.dateOfEvent = eventArray[eventNumber]["dateOfEvent"].string!
            //set the rest of the fields later when we need them
            /*Loop through to put the eventTopics into the eventTopicsArray*/
            if let eventTopicArray = json["events"][eventNumber]["eventTopicsArray"].array{
                //println(eventTopicArray.count)
                for(var i = 0; i < eventTopicArray.count; i++){
                    println(eventTopicArray[i]["eventTopicTitle"].string!)
                    currentEventModel.eventTopicsArray.addObject(eventTopicArray[i]["eventTopicTitle"].string!)
                }
            }
            //eventTableViewController.reloadData()
        }
    }
}
