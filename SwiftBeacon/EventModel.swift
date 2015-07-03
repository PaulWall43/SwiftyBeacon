//
//  EventModel.swift
//  SwiftBeacon
//
//  Created by Paul Wallace on 6/30/15.
//  Copyright (c) 2015 Paul Wallace. All rights reserved.
//

import UIKit

class EventModel: NSObject {
    var title : String!
    var descriptionOfEvent : String?
    var dateOfEvent : NSDate?
    var beaconUUID : NSUUID?
    var beaconMajor: Int?
    var beaconMinor : Int?
    var location : String?
    var eventTopicsArray : NSMutableArray?
    var subTopic : Bool = false;
    var completed : Bool = false;
    
    init(title:String){
        super.init()
        self.title = title
    }
}
