//
//  TwitterViewController.swift
//  Lion Football
//
//  Created by Tika Datta Pahadi on 1/11/15.
//  Copyright (c) 2015 Tika Pahadi. All rights reserved.
//
import UIKit
import TwitterKit
import Twitter
import Social


class TwitterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var bgImage: UIImageView!
    
    let user = "SluFootball"
    let name = "SLU Football"
    let defaults = NSUserDefaults.standardUserDefaults()

    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userScreenName: UILabel!
    @IBOutlet weak var coverPhoto: UIImageView!
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var middleBar: UIView!
    @IBOutlet weak var tweets_counter: UILabel!
    @IBOutlet weak var followers_count: UILabel!
    
    @IBOutlet weak var tweetTable: UITableView!
    
    
    @IBAction func viewProfile(sender: AnyObject) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("Web View") as WebPageViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
        vc.url = "http://www.twitter.com/\(user)"
        vc.pageTitle = "@\(user)"
        
    }

    
    var tweetData : NSDictionary =     [
        "cover_photo" : "https://pbs.twimg.com/profile_banners/45669193/1402264436",
        "description" : "The Official Twitter Page for Southeastern Louisiana University Athletics - NCAA Division I - Southland Conference - #LionUp #LionNation",
        "followers" : 0,
        "following" : 0,
        "location" : "Hammond, La.",
        "name" : "SLU Football",
        "profile_photo" : "http://pbs.twimg.com/profile_images/518601205065723904/mUJ24qvD.jpeg",
        "screen_name" : "sluathletics",
        "statuses_count" : 0
    ]
    var tweets : NSMutableArray = []

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("Twitter Loaded")
        self.title = "Twitter"
        
        
        scrollView.backgroundColor = UIColor.clearColor()
        scrollView.bounces = false // oder true
        scrollView.pagingEnabled = false
        profilePicture.layer.backgroundColor = UIColor.clearColor().CGColor
        profilePicture.layer.cornerRadius = 10.0;
        profilePicture.layer.masksToBounds = true;
        self.tweetTable.scrollEnabled = true;
        self.tweetTable.backgroundColor = UIColor.clearColor()
        self.tweetTable.separatorColor = UIColor.blackColor()
        self.tweetTable.tableFooterView = UIView(frame: CGRectZero)
        self.tweetTable.bounces = false
        self.tweetTable.rowHeight = 90
        
        
        
        
        //Getting the Offline Data
        
        
        //For TweetData
        if (defaults.objectForKey("tweetData") != nil) {
            var data : AnyObject? = defaults.objectForKey("tweetData")
            tweetData = data! as NSDictionary
        }

        
        //For Tweets
        if (defaults.objectForKey("tweets") != nil) {
            var data : AnyObject? = defaults.objectForKey("tweets")
            tweets = data! as NSMutableArray
        }
        
        
        refreshUser()           //Sets Name, Photo, etc.
        
        
        //Adding tweet Button
        

        //let navBtn = UIBarButtonItem(title: "Reply", style: .Plain, target: self, action: "newTweet:")
        
        let navBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem(rawValue: 7)!, target: self, action: "newTweet:")
        
        self.navigationItem.rightBarButtonItem = navBtn
      
        

        
    }
    func newTweet(sender: UIBarButtonItem) {
        var shareToTwitter : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        shareToTwitter.setInitialText(userScreenName.text)
        //shareToTwitter.addImage(UIImage(named: "32.png"))
        self.presentViewController(shareToTwitter, animated: true, completion: nil)
        
    }
    
        

    

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        //Showing Navigation
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        
        // For Guest Authentication
        Twitter.sharedInstance().logInGuestWithCompletion {
            (guestSession, error) -> Void in
            if (guestSession != nil) {
                // make API calls that do not require user auth
            } else {
                println("error: \(error.localizedDescription)");
            }
        }
        
        /* For User Authentication
        Twitter.sharedInstance().logInWithCompletion {
        (session, error) -> Void in
        if (session != nil) {
        println("signed in as \(session.userName)");
        } else {
        println("error: \(error.localizedDescription)");
        }
        }
        */
        prepare()
    }
    
    func prepare(){
        
        
        let statusesShowEndpoint = "https://api.twitter.com/1.1/statuses/user_timeline.json"
        let params = ["screen_name": user]
        var clientError : NSError?
        
        //Getting Request
        let request = Twitter.sharedInstance().APIClient.URLRequestWithMethod(
            "GET", URL: statusesShowEndpoint, parameters: params,
            error: &clientError)
        
        
        //Real Work Begins
        
        if request != nil {
            Twitter.sharedInstance().APIClient.sendTwitterRequest(request) {
                (response, data, connectionError) -> Void in
                if (connectionError == nil) {
                    var jsonError : NSError?
                    
                //Getting JSON Response as NSArray
                let jsonResponse =  NSJSONSerialization.JSONObjectWithData(data,
                        options: nil,
                        error: &jsonError) as NSArray
                    
                    //println(jsonResponse);
                //We got the JSON, We need to do two things
                    
                //1. Fetch User Data & Save them
                    let currentTweet : NSDictionary = jsonResponse[0] as NSDictionary;
                    let userData : NSDictionary = currentTweet["user"] as NSDictionary;
                    
                    
                    
                    self.tweetData = [
                        
                        "name"          : userData["name"]!,
                        "location"      : userData["location"]!,
                        "followers"     : userData["followers_count"]!,
                        "following"     : userData["friends_count"]!,
                        "screen_name"   : userData["screen_name"]!,
                        "statuses_count": userData["statuses_count"]!,
                        "cover_photo"   : userData["profile_banner_url"]!,
                        "profile_photo" : userData["profile_image_url"]!


                        
                    ]
                    
                //Saving the TweetData
                    self.defaults.setObject(self.tweetData, forKey: "tweetData")
                    self.defaults.synchronize()
                    
                    //One More thing for Profile Pic And Cover Photo
                    //This FUnction fetches the Images from Interenet and Saves them Offline
                    self.getImages();
                    
                 
                    
                //2. Now Let us go ahead with fetching each tweets
                    self.tweets = []
                    
                    for (var i = 0; i < jsonResponse.count; ++i) {
                        var currentTweet : NSDictionary = jsonResponse[i] as NSDictionary;
                        
                        //println(currentTweet["id"])
                        
                        var push : NSDictionary = [
                            "id"        : currentTweet["id_str"]!,
                            "text"      : currentTweet["text"]!,
                            "time"      : currentTweet["created_at"]!,
                            "retweets"  : currentTweet["retweet_count"]!,
                            "favs"      : currentTweet["favorite_count"]!
                            
                        ]
                        
                        //Now Pushing this dictionary to an Array
                        self.tweets[i] = push;
                        
                        
                        
                    }
                    
                //Also Let us Save these tweets for Offline Usage
                //Saving the Twitter Array
                    self.defaults.setObject(self.tweets, forKey: "tweets")
                    self.defaults.synchronize()
                   
                    
                    
                //At this Condition, tweets array has been reedited. Let us refresh everything once again
                    
                    self.refreshUser()
                    self.tweetTable.reloadData()
                
                    
                    
                }
                else {
                    println("Error: \(connectionError)");
                }
            }
            
        }
        else {
            println("Error: \(clientError)")
        }
    }
    
    func refreshUser(){

        //Refreshing Images
        let dirs : [String]? = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String]
        let dir = dirs![0] //Document Directory
        
        //CoverPhoto
        let pathC = dir.stringByAppendingPathComponent("cover_photo");
        let imgC = UIImage(contentsOfFile: pathC)
        self.coverPhoto.image = imgC;
        
        //Profile Picture
        let pathP = dir.stringByAppendingPathComponent("profile_photo");
        let imgP = UIImage(contentsOfFile: pathP)
        self.profilePicture.image = imgP;
        
        //Title, User, followers, tweets
        
        let name = self.tweetData["name"] as String
        let screen_name = self.tweetData["screen_name"] as String
        let tweets = self.tweetData["statuses_count"] as Int
        let followers = self.tweetData["followers"] as Int
        
        
        self.userName.text = name
        self.userScreenName.text = "@\(screen_name)"
        self.tweets_counter.text = "\(tweets)\ntweets"
        self.followers_count.text = "\(followers) followers"
        
        
    }
    
    func getImages(){
        
        
        let dirs : [String]? = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String]
        let dir = dirs![0] //Document Directory
        
        
        //1. Getting the Cover Photo
        
        //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            let pathC = dir.stringByAppendingPathComponent("cover_photo");
            let urlC: String = self.tweetData["cover_photo"] as String;
            
            let getImageC =  UIImage(data: NSData(contentsOfURL: NSURL(string: urlC)!)!)
            UIImageJPEGRepresentation(getImageC, 1.0).writeToFile(pathC, atomically: true)
        /*
            dispatch_async(dispatch_get_main_queue()) {
                let imgC = UIImage(contentsOfFile: pathC)
                self.coverPhoto.image = imgC;
            }
        */
            
        //}
        //2. Getting the Profile Photo
        
        //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            
            let pathP = dir.stringByAppendingPathComponent("profile_photo");
            var urlP: String = self.tweetData["profile_photo"] as String;
            
            //We need to change a little eith profileImage as it sends smaller Image            
            urlP = urlP.stringByReplacingOccurrencesOfString("_normal", withString: "")
            
            
            let getImageP =  UIImage(data: NSData(contentsOfURL: NSURL(string: urlP)!)!)
            UIImageJPEGRepresentation(getImageP, 1.0).writeToFile(pathP, atomically: true)
        /*
            dispatch_async(dispatch_get_main_queue()) {
                let imgP = UIImage(contentsOfFile: pathP)
                self.coverPhoto.image = imgP;
            }
        */
           
        //}
        
        
   
        
    }

    func getImageFromURL(url : String) -> UIImage{
        let urlString = url.stringByReplacingOccurrencesOfString("\\/", withString: "/")
        let urlImg = NSURL(string: urlString)
        let dataImg = NSData(contentsOfURL : urlImg!)
        let img = UIImage(data : dataImg!)
      
        
        return img!
        
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Table Reloaded with \(tweets.count) tweets")
        return tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //let cell: UITableViewCell = self.tweetTable.dequeueReusableCellWithIdentifier("tweetCell") as UITableViewCell

        let cell = UITableViewCell();
        
        let tweet: NSDictionary = self.tweets[indexPath.row] as NSDictionary
        
        

        var screenRect = UIScreen.mainScreen().bounds;
        var screenWidth : CGFloat = screenRect.size.width;
        var screenHeight : CGFloat = screenRect.size.height;
        
        
        
        var name = UILabel(frame: CGRectMake(60, 5,110, 20))
        name.textColor = UIColor.whiteColor()
        name.font = UIFont(name: name.font.fontName, size: 12)
        //name.backgroundColor = UIColor.grayColor()
        name.textAlignment = NSTextAlignment.Left
        name.lineBreakMode = NSLineBreakMode.ByWordWrapping
        name.numberOfLines = 1
        
        name.text = self.tweetData["name"] as? String
        cell.contentView.addSubview(name)
        
       
        
        var username = UILabel(frame: CGRectMake(170, 5,100, 20))
        username.textColor = UIColor.yellowColor()
        username.font = UIFont(name: username.font.fontName, size: 12)
        //username.backgroundColor = UIColor.greenColor()
        username.textAlignment = NSTextAlignment.Left
        username.lineBreakMode = NSLineBreakMode.ByWordWrapping
        username.numberOfLines = 1
        
        username.text = "@\(user)"
        cell.contentView.addSubview(username)
        
        
        
        var time = UILabel(frame: CGRectMake(screenWidth-60, 5, 55, 20))
        time.textColor = UIColor.yellowColor()
        time.font = UIFont(name: time.font.fontName, size: 12)
        //time.backgroundColor = UIColor.redColor()
        time.textAlignment = NSTextAlignment.Right
        time.lineBreakMode = NSLineBreakMode.ByWordWrapping
        time.numberOfLines = 1
        
        let txt : NSString = tweet["time"] as String
        time.text = txt.substringWithRange(NSRange(location: 4, length: 6))
        
        cell.contentView.addSubview(time)
        
        
        
        var label = UILabel(frame: CGRectMake(60, 20, screenWidth - 65, 60))
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name: label.font.fontName, size: 14)
        //label.backgroundColor = UIColor.grayColor()
        label.textAlignment = NSTextAlignment.Justified
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.numberOfLines = 3
        
        label.text = tweet["text"] as? String
        cell.contentView.addSubview(label)
        
        
        let imageView = UIImageView(image: self.profilePicture.image)
        imageView.frame = CGRect(x: 5, y: 5, width: 50, height: 50)
        
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5.0
        //imageView.layer.cornerRadius = imageView.frame.size.width / 2;
        cell.contentView.addSubview(imageView)
        
        
        if(indexPath.row % 2 == 1){
            cell.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.65)
        } else {
            cell.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.85)
        }
        
        cell.separatorInset = UIEdgeInsetsZero
        
        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        let tweet   = self.tweets[indexPath.row] as NSDictionary
        let id     = tweet["id"]! as String
        let url     = "https://mobile.twitter.com/SLUFootball/status/\(id)"
        
        //println("'\(url)'")
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("Web View") as WebPageViewController
        vc.url = url
        vc.pageTitle = "Tweet"
        self.navigationController?.pushViewController(vc, animated: true)

        
    }
    
    
    
    
}
