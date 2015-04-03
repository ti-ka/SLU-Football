//
//  ViewController.swift
//  Lion Football
//
//  Created by Tika Datta Pahadi on 1/1/15.
//  Copyright (c) 2015 Tika Pahadi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var menuTable: UITableView!
    
    var menuItems = ["News Feed","Twitter","Videos","Events","More"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadBackground()
        
                
        self.menuTable?.tableFooterView = UIView(frame: CGRectZero)
        self.menuTable?.separatorColor = UIColor.yellowColor()
        
        //self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        
        println("Home Page Loaded")
    
    }
    
    func loadBackground(){
        if(UIApplication.sharedApplication().statusBarOrientation.isPortrait){
            let img : UIImage = tint(UIImage(named: "bg-port")!,color: UIColor(red: 96/225, green: 96/225, blue: 13/225, alpha: 0.8));
            self.background?.image = img;
        } else {
            let img : UIImage = tint(UIImage(named: "bg-land")!,color: UIColor(red: 96/225, green: 96/225, blue: 13/225, alpha: 0.8));
            self.background?.image = img;
        }
        
        
    }

    
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        loadBackground()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("menuCell") as UITableViewCell
        
        
        cell.textLabel?.text = menuItems[indexPath.row]
        cell.textLabel?.textColor = UIColor.yellowColor()
        
        //let img : UIImage = tint(UIImage(named: menuItems[indexPath.row])!,color: UIColor.yellowColor())
      
        
        //cell.imageView?.image = img
        
        
        return cell
        
    }
    
    func tint(image: UIImage, color: UIColor) -> UIImage
    {
        let ciImage = CIImage(image: image)
        let filter = CIFilter(name: "CIMultiplyCompositing")
        
        let colorFilter = CIFilter(name: "CIConstantColorGenerator")
        let ciColor = CIColor(color: color)
        colorFilter.setValue(ciColor, forKey: kCIInputColorKey)
        let colorImage = colorFilter.outputImage
        
        filter.setValue(colorImage, forKey: kCIInputImageKey)
        filter.setValue(ciImage, forKey: kCIInputBackgroundImageKey)
        
        return UIImage(CIImage: filter.outputImage)!
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        println("Clicked \(menuItems[indexPath.row]) ")
        //let vc = self.storyboard?.instantiateViewControllerWithIdentifier("News Feed") as NewsFeedTableViewController
        //self.presentViewController(vc, animated: true, completion: nil)
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("News Feed") as NewsFeedTableViewController
        self.presentViewController(vc, animated: true, completion: nil)
        
        
        /*
        
        switch indexPath.row {
            
        case 0 :
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("News Feed") as NewsFeedTableViewController
            self.navigationController?.pushViewController(vc, animated: true)
            break;
        case 1 :
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("Twitter Page") as TwitterViewController
            self.presentViewController(vc, animated: true, completion: nil)
            
            
            break;
            
        case 2 :
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("Videos") as VideoViewController
            self.navigationController?.pushViewController(vc, animated: true)
            break;
            
            
        default :
            break;
        }
        */
        
        
        
    }
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     
        if segue.identifier == "showNewsFeed" {
            
            //var indexPath: NSIndexPath = self.tableView.indexPathForSelectedRow()!
            //let selectedFeedURL: String = feeds[indexPath.row].objectForKey("link") as String
            //let selectedFTitle: String = myFeed[indexPath.row].objectForKey("title") as String
            //let selectedFContent: String = myFeed[indexPath.row].objectForKey("description") as String
            //let selectedFURL: String = myFeed[indexPath.row].objectForKey("link") as String
            //let selectedFImg: String = myFeed[indexPath.row].objectForKey("image") as String
            
            // Instance of our feedpageviewcontrolelr
            
            let fpvc: NewsFeedTableViewController = segue.destinationViewController as NewsFeedTableViewController
            
          
            
        }
        
        
    }
*/
    
    
    
    
    
    
}

