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
    @IBOutlet weak var eventsHappeningNowButton: UIButton!
    @IBOutlet weak var timeUntilNextClass: UILabel!
    var timer : NSTimer = NSTimer()
    var nextClassDate : NSDate!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpCountDownClock()
    }
    
    func setUpCountDownClock(){
        //var timeLeft : NSTimeInterval = NSDate.timeIntervalSinceDate(dataManager.getNextDate())
        //get the current time
        var nextDate : String = "07/08/2015"
        var format : NSDateFormatter = NSDateFormatter()
        format.dateFormat = "MM/dd/yyyy"
        nextClassDate  = format.dateFromString(nextDate)!
        var numberOfSecondsUntilNextClass : NSTimeInterval  = nextClassDate.timeIntervalSinceNow
        timer = NSTimer.scheduledTimerWithTimeInterval(0.5 , target: self, selector: "updateClock:", userInfo: nil, repeats: true)
    }
    
    func updateClock( theTimer: NSTimer){
        var now : NSDate = NSDate()
        if(nextClassDate.earlierDate(now) == nextClassDate){
            timer.invalidate()
        } else {
            var currCalendar : NSCalendar = NSCalendar.currentCalendar();
            //var gregorianCalendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
            //var componentHours = gregorianCalendar(components: DayCalendarUnit, fromDate: now, toDate: nextClassDate, options:0]
//            var componentHours = currCalendar.components(.DayCalendarUnit | .HourCalendarUnit | .MinuteCalendarUnit | .SecondCalendarUnit, fromDate: now)
            //println(componentHours)
            displayTime(nextClassDate.timeIntervalSinceNow)
            var flags : NSCalendarUnit = .HourCalendarUnit | .MinuteCalendarUnit | .SecondCalendarUnit
            var componentsOfNextDate = currCalendar.components(flags, fromDate: now, toDate: nextClassDate, options: nil)
            println("\(componentsOfNextDate.hour):\(componentsOfNextDate.minute):\(componentsOfNextDate.second)")
        }
    }
    func displayTime(timeLeftUntilNextClass : NSTimeInterval){
        //Get hours
        var mutableTimeLeftUntilNextClass = Int(timeLeftUntilNextClass)
        var hours = getHoursFromSeconds(mutableTimeLeftUntilNextClass)
        var minutes = getMinutesFromSeconds(mutableTimeLeftUntilNextClass)
        var seconds = getSecondsFromSeconds(mutableTimeLeftUntilNextClass)
        timeUntilNextClass.text = String(format: "%02u:%02u:%02u", hours, minutes, seconds)
    }
    
    func getHoursFromSeconds(totalSeconds:Int) -> Int{
        var toReturn : Int = totalSeconds / 3600
        return toReturn
    }
    
    func getMinutesFromSeconds(totalSeconds:Int) -> Int{
        var toReturn : Int = (totalSeconds % 3600) / 60
        return toReturn
    }
    
    func getSecondsFromSeconds(totalSeconds:Int) -> Int{
        var toReturn : Int = (totalSeconds % 3600) % 60
        return toReturn
    }
}
