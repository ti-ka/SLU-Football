//
//  Videos.swift
//  Lion Football
//
//  Created by Tika Datta Pahadi on 1/11/15.
//  Copyright (c) 2015 Tika Pahadi. All rights reserved.
//

import UIKit


class Videos: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    var pageTitle = "Videos"
    var listId = "PLRzBVSG-3qc4mnUPNdpbE0kxN1u3YQ8Qm"
    
    var URL = ""
    
    var videoData : NSMutableArray = []
    
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    
    let dirs : [String]? = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String]
    var dir = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Loading Videos..."
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "bg-port")!)
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        self.dir = self.dirs![0]
        self.URL = "https://www.googleapis.com/youtube/v3/playlistItems?playlistId=\(self.listId)&key=AIzaSyClRD4e8u-9TqoAXppSaWnWLGsd_zhPTfk&part=snippet&maxResults=25"
        
        self.title = self.pageTitle
        
        //Showing Navigation
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        //Fetching Youtube Saved Data
        if (defaults.objectForKey(self.pageTitle) != nil) {
            var data : AnyObject? = defaults.objectForKey(self.pageTitle)
            self.videoData = data! as NSMutableArray
            
            tableView.reloadData()
            
        }
        
        
        
        prepare()
        
    }
    
    func prepare(){
        
        let url = self.URL
        
        if(NSData(contentsOfURL: NSURL(string: url)!) != nil){
        
        let response = NSData(contentsOfURL: NSURL(string: url)!)!
        
        var json: JSON = JSON.nullJSON
        json = JSON(data:response)
        let videos = json["items"];
        
        
        
        if(json != nil){
            self.videoData = []
            
            
            for (var i = 0; i<videos.count; i++){
                
                let thisVideo = videos[i]["snippet"]
                
                let _time : NSString = thisVideo["publishedAt"].stringValue as NSString;
                let time = toDateTime(_time)
                
                
                self.videoData[i] = [
                    "id"    : thisVideo["resourceId"]["videoId"].stringValue,
                    "title" : thisVideo["title"].stringValue,
                    "time"  : time,
                    "image" : thisVideo["thumbnails"]["medium"]["url"].stringValue
                ]
                
                
                
                //Now Fetch images for offline usages
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
                
                //Path for photo eg: youtube-img1
                let pathP = self.dir.stringByAppendingPathComponent("\(self.pageTitle)-img\(i)");
                var urlP = thisVideo["thumbnails"]["medium"]["url"].stringValue;
                   
                
                //Saving...
                let getImageP =  UIImage(data: NSData(contentsOfURL: NSURL(string: urlP)!)!)
                UIImageJPEGRepresentation(getImageP, 0.5).writeToFile(pathP, atomically: true)
                
                
                }
                
                
                
                
            }
           
            
            
            //Saving the Video Data for offline usage
            self.defaults.setObject(self.videoData, forKey: self.pageTitle)
            self.defaults.synchronize()
            
            self.tableView.reloadData()
            
        }

        
        
        
        }
    
    
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videoData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("videoCell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = self.videoData[indexPath.row]["title"] as? String
        cell.detailTextLabel?.text = self.videoData[indexPath.row]["time"] as? String
        
        
        let pathP = self.dir.stringByAppendingPathComponent("\(self.pageTitle)-img\(indexPath.row+1)");
        
        let imgP = UIImage(contentsOfFile: pathP)
        cell.imageView?.image = imgP;
        
        
        if(indexPath.row % 2 == 1){
            cell.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.80)
        } else {
            cell.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.95)
        }
        
        cell.separatorInset = UIEdgeInsetsZero
        
        
        
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let videoID: String = videoData[indexPath.row]["id"] as String
        
        //println(youtubeData[indexPath.row])
        
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("Web View") as WebPageViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
        vc.url = "https://www.youtube.com/watch?v=\(videoID)";
        
        
        
    }
    
    func toDateTime(str : String) -> NSString
        
    {
        
        
        var z = replace("T", withString:" ", str: str)
        z = replace(".000Z", withString:"", str: z)
        
        
        //Create Date Formatter
        var dateFormatter = NSDateFormatter()
        
        //Specify Format of String to Parse
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
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
