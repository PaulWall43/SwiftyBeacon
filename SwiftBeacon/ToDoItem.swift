//
//  ToDoItem.swift
//  SwiftBeacon
//
//  Created by Paul Wallace on 6/30/15.
//  Copyright (c) 2015 Paul Wallace. All rights reserved.
//

import Foundation

class ToDoItem: NSObject {
    var title : NSString!
    var subTopic : Bool = false;
    var completed : Bool = false;
    
    init(title:String){
        self.title = title
    }
    
}
