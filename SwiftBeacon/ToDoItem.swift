//
//  ToDoItem.swift
//  SwiftBeacon
//
//  Created by Paul Wallace on 6/30/15.
//  Copyright (c) 2015 Paul Wallace. All rights reserved.
//

import Foundation

class ToDoItem: NSObject {
    var completed : Bool = false;
    var subTopic : Bool = true;
    var title : NSString!
    
    init(title:String){
        self.title = title
    }
    
}
