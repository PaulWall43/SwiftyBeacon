//
//  ToDoTableViewController.swift
//  SwiftBeacon
//
//  Created by Paul Wallace on 6/30/15.
//  Copyright (c) 2015 Paul Wallace. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    var toDoItems: NSMutableArray = []
    
    func loadinitialData(){
        var item1 = ToDoItem(title: "Vocabulary Lesson")
        self.toDoItems.addObject(item1)
        
        var item2 = ToDoItem(title: "Addition")
        self.toDoItems.addObject(item2)
        
        var item3 = ToDoItem(title: "Mathematics")
        self.toDoItems.addObject(item3)
    }
    
    override func viewDidLoad() {
        self.loadinitialData()
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.toDoItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier: NSString = "ToDoPrototypeCell"
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as UITableViewCell
        var todoitem: ToDoItem  = self.toDoItems.objectAtIndex(indexPath.row) as ToDoItem
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
        var tappedItem: ToDoItem = self.toDoItems.objectAtIndex(indexPath.row) as ToDoItem
        tappedItem.completed = !tappedItem.completed
        tableView.reloadData()
    }
}
