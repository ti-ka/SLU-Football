//
//  NewsFeedTableViewController.swift
//  Lion Football
//
//  Created by Tika Datta Pahadi on 1/11/15.
//  Copyright (c) 2015 Tika Pahadi. All rights reserved.
//

import UIKit

class Events: UITableViewController, UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate  {
    
    
    var myFeed : NSArray = []
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var eventsData : NSMutableArray = []
    
    var url: NSURL = NSURL(string: "http://lionsports.net/calendar.ashx/calendar.rss?sport_id=2")!
    
    let dirs : [String]? = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String]
    var dir = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Cell height.
        self.tableView.rowHeight = 70
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.title = "Loading..."
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        println("Schedule Loaded")
        
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "bg-port")!)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.tableView.separatorColor = UIColor.grayColor()
        
        //Fetching News Feed Saved Data
        if (defaults.objectForKey("eventsData") != nil) {
            var data : AnyObject? = defaults.objectForKey("eventsData")
            self.eventsData = data! as NSMutableArray
            
            tableView.reloadData()
            
        }
        
        
    
    }
    
    override func viewDidAppear(animated: Bool) {
        self.dir = self.dirs![0]
        loadRss(self.url);
        self.title = "Schedule"
    }
    
    
    
    
    func loadRss(data: NSURL) {
        // XmlParserManager instance/object/variable
        var myParser : EventsXMLParser = EventsXMLParser.alloc().initWithURL(data) as EventsXMLParser
        // Put feed in array
        myFeed = myParser.feeds
        
        
        
        let dirs : [String]? = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String]
        let dir = dirs![0] //Document Directory
        
        if(myFeed.count != 0){
            eventsData = [] //Making Empty
            for(var i = 0; i < myFeed.count; i++){
                var title : NSString = myFeed.objectAtIndex(i).objectForKey("title") as NSString
                
                var description : NSString = myFeed.objectAtIndex(i).objectForKey("description") as NSString
                
                let _date : NSString = myFeed.objectAtIndex(i).objectForKey("s:localstartdate") as NSString
                let date = toDateTime(_date)
                
                
                let oppLogo : NSString = myFeed.objectAtIndex(i).objectForKey("s:opponentlogo") as NSString
               

                
                
                var link : String = myFeed.objectAtIndex(i).objectForKey("link") as String
                link = link.stringByReplacingOccurrencesOfString("\\/", withString: "/")
                link = link.stringByReplacingOccurrencesOfString(" ", withString: "")
                link = link.stringByReplacingOccurrencesOfString("\n", withString: "")
                
                
                let start  = title.rangeOfString("Football").location + 13
                let end = title.length - start
                
                let actualTitle = title.substringWithRange(NSRange(location: start, length: end))
              
                self.eventsData[i] = [
                    "title"     : actualTitle,
                    "link"      : link,
                    "time"      : date,
                    "oppLogo"   : oppLogo
                ]
                
                
                //Saving the Data for offline usage
                self.defaults.setObject(self.eventsData, forKey: "eventsData")
                self.defaults.synchronize()
                
                //Now Fetch images for offline usages
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
                    
                //Path for photo eg: oppLogo-img1
                    let pathP = self.dir.stringByAppendingPathComponent("oppLogo-img\(i)");
                    
                    
                    //Saving...
                    let getImageP =  UIImage(data: NSData(contentsOfURL: NSURL(string: oppLogo)!)!)
                    UIImagePNGRepresentation(getImageP).writeToFile(pathP, atomically: true)
                    

                }
                
                
                
                
                
            }
            
            //println(self.eventsData)
            
            tableView.reloadData()
            
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsData.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : EventCell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as EventCell
       
        
        
        cell.place?.text = eventsData[indexPath.row]["title"] as? String
        cell.date?.text = eventsData[indexPath.row]["time"] as? String
        
        
        let pathP = self.dir.stringByAppendingPathComponent("oppLogo-img\(indexPath.row+1)");
        
        let imgP = UIImage(contentsOfFile: pathP)
        cell.oppLogo?.image = imgP;
        
       
        
        if(indexPath.row % 2 == 1){
            cell.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.75)
        } else {
            cell.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.95)
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var indexPath: NSIndexPath = self.tableView.indexPathForSelectedRow()!
        
        var urlString: String = eventsData[indexPath.row]["link"] as String
        
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("Web View") as WebPageViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
        vc.url = urlString
        
        
        
    }

 
    
    func toDateTime(str : String) -> NSString
        
    {
        
        
        var z = replace("T", withString:" ", str: str)
        z = replace(".000Z", withString:"", str: z)
        
        
        //Create Date Formatter
        var dateFormatter = NSDateFormatter()
        
        //Specify Format of String to Parse
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        //Parse into NSDate
        let dateFromString : NSDate = dateFormatter.dateFromString(z)!
        
        
        
        
        //format date
        dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEE, MMM d yyyy" //format style. Browse online to get a format that fits your needs.
        var dateString = dateFormatter.stringFromDate(dateFromString)
        //println(dateString) //prints out 10:12
        
        
        
        //Return Parsed Date
        return dateString
    }
    
    
    func replace(target: String, withString: String, str : String) -> String
    {
        return str.stringByReplacingOccurrencesOfString(target, withString: withString, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
    
    
}
