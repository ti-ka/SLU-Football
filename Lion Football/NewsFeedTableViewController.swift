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
    var newsData : NSMutableArray = []
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Cell height.
        self.tableView.rowHeight = 70
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.title = "Loading..."
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        println("News Feed Loaded")
        
        
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "bg-port"))
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        //Fetching News Feed Saved Data
        if (defaults.objectForKey("newsData") != nil) {
            var data : AnyObject? = defaults.objectForKey("newsData")
            self.newsData = data! as NSMutableArray
            //println(self.newsData)
            tableView.reloadData()
            
        }
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        loadRss(self.url)
        self.title = "News Feed"
        
    }
    

    
    
    func loadRss(data: NSURL) {
        // XmlParserManager instance/object/variable
        var myParser : XmlParserManager = XmlParserManager.alloc().initWithURL(data) as XmlParserManager
        // Put feed in array
        myFeed = myParser.feeds
        
        
        let dirs : [String]? = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String]
        let dir = dirs![0] //Document Directory
        
        if(myFeed.count != 0){
        newsData = [] //Making Empty
        for(var i = 0; i < myFeed.count; i++){
            let title : String = myFeed.objectAtIndex(i).objectForKey("title") as String
            var pubDate : NSString = myFeed.objectAtIndex(i).objectForKey("pubDate") as NSString
            //Removing ":00 GMT"
            pubDate = pubDate.substringWithRange(NSRange(location: 0, length: pubDate.length-7))
            var image : String = myFeed.objectAtIndex(i).objectForKey("image") as String
            image = image.stringByReplacingOccurrencesOfString("\\/", withString: "/")
            var link : String = myFeed.objectAtIndex(i).objectForKey("link") as String
            link = link.stringByReplacingOccurrencesOfString("\\/", withString: "/")
            //var description : String = myFeed.objectAtIndex(i).objectForKey("description") as String
            
            
            self.newsData[i] = [
                "title"         : title,
                "pubDate"       : pubDate,
                "image"         : image,
                "link"          : link
            ]
            
            
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
                
                //Path for photo eg: youtube-img1
                let pathP = dir.stringByAppendingPathComponent("news-img\(i)");
                
                //Saving...
                let getImageP =  UIImage(data: NSData(contentsOfURL: NSURL(string: image)!)!)
                UIImageJPEGRepresentation(getImageP, 1.0).writeToFile(pathP, atomically: true)
                
            }
            
            
            
            //Saving the Video Data for offline usage
            self.defaults.setObject(self.newsData, forKey: "newsData")
            self.defaults.synchronize()

        
        }
        
        
        tableView.reloadData()
        
        }
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
            let selectedFURL: String = newsData[indexPath.row]["link"] as String
            //let selectedFImg: String = myFeed[indexPath.row].objectForKey("image") as String
            
            // Instance of our feedpageviewcontrolelr
            
            let fpvc: WebPageViewController = segue.destinationViewController as WebPageViewController
            
            fpvc.url = selectedFURL
            
        }
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let url = newsData[indexPath.row]["link"] as String
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("Web View") as WebPageViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
        vc.url  = url;
        vc.id   = indexPath.row;
        vc.from = "news"
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("feedCell", forIndexPath: indexPath) as UITableViewCell
        
    
        // Set cell properties.
        cell.textLabel?.text = self.newsData[indexPath.row]["title"] as? String
        cell.detailTextLabel?.text = self.newsData[indexPath.row]["pubDate"] as? String
        
        
        
        let dirs : [String]? = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String]
        
        let dir = dirs![0] //Document Directory
        let pathP = dir.stringByAppendingPathComponent("news-img\(indexPath.row)");
        
        let imgP = UIImage(contentsOfFile: pathP)
        cell.imageView?.image = imgP;
        
        
        
        if(indexPath.row % 2 == 1){
            cell.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.70)
        } else {
            cell.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.90)
        }
     
        
        
        
        
        return cell
    }


}
