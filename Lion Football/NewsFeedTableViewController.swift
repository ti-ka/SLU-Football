//
//  NewsFeedTableViewController.swift
//  Lion Football
//
//  Created by Tika Datta Pahadi on 1/11/15.
//  Copyright (c) 2015 Tika Pahadi. All rights reserved.
//

import UIKit

class NewsFeedTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate  {

    
    
    
    var myFeed : NSArray = []
    var url: NSURL = NSURL(string: "http://www.lionsports.net/rss.aspx?path=football")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Cell height.
        self.tableView.rowHeight = 70
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.title = "News Feed"
        
        // Call custom function.
        loadRss(self.url);
        
        println("News Feed Loaded")
        
        
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "bg-port"))
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        
    }

    

    
    
    func loadRss(data: NSURL) {
        // XmlParserManager instance/object/variable
        var myParser : XmlParserManager = XmlParserManager.alloc().initWithURL(data) as XmlParserManager
        // Put feed in array
        myFeed = myParser.feeds
        
        tableView.reloadData()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showNews" {
            
            var indexPath: NSIndexPath = self.tableView.indexPathForSelectedRow()!
            //let selectedFeedURL: String = feeds[indexPath.row].objectForKey("link") as String
            //let selectedFTitle: String = myFeed[indexPath.row].objectForKey("title") as String
            //let selectedFContent: String = myFeed[indexPath.row].objectForKey("description") as String
            let selectedFURL: String = myFeed[indexPath.row].objectForKey("link") as String
            //let selectedFImg: String = myFeed[indexPath.row].objectForKey("image") as String
            
            // Instance of our feedpageviewcontrolelr
            
            let fpvc: WebPageViewController = segue.destinationViewController as WebPageViewController
            
            fpvc.url = selectedFURL
            
        }
        
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFeed.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("feedCell", forIndexPath: indexPath) as UITableViewCell
        
        // Feeds dictionary.
        var dict : NSDictionary! = myFeed.objectAtIndex(indexPath.row) as NSDictionary
        
        // Set cell properties.
        cell.textLabel?.text = myFeed.objectAtIndex(indexPath.row).objectForKey("title") as? String
        
        var feedTime:NSString = myFeed.objectAtIndex(indexPath.row).objectForKey("pubDate") as NSString!

        let timeDisplay = feedTime.substringWithRange(NSRange(location: 0, length: feedTime.length-7)) //Removing ":00 GMT"
        
        
        cell.detailTextLabel?.text = timeDisplay;
        
        var urlString:String = myFeed.objectAtIndex(indexPath.row).objectForKey("image") as String
        
        urlString = urlString.stringByReplacingOccurrencesOfString("\\/", withString: "/")
        urlString = urlString.stringByReplacingOccurrencesOfString(" ", withString:"")
        urlString = urlString.stringByReplacingOccurrencesOfString("\n", withString:"")
        
        
        let urlImg = NSURL(string: urlString)
        
        
        
        let dataImg = NSData(contentsOfURL : urlImg!)
        let img = UIImage(data : dataImg!)
        
        
        cell.imageView?.image = img;
        
        if(indexPath.row % 2 == 1){
            cell.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.80)
        } else {
            cell.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.90)
        }
     
        
        
        
        
        return cell
    }


}
