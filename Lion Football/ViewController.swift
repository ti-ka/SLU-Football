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
    
    var menuItems = ["News Feed","Twitter","Videos","Schedule","More"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadBackground()
        
        
        
        println("Home Page Loaded")
    
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }

    override func viewDidAppear(animated: Bool) {
        self.menuTable?.tableFooterView = UIView(frame: CGRectZero)
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
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
        cell.backgroundColor = UIColor.clearColor()
        
                
        let img : UIImage = tint(UIImage(named: menuItems[indexPath.row])!,color: UIColor.yellowColor())
      
        cell.imageView?.image = img
        
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
    

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.textColor = UIColor.whiteColor()
        
        //println("Clicked \(menuItems[indexPath.row]) ")
        //let vc = self.storyboard?.instantiateViewControllerWithIdentifier("News Feed") as NewsFeedTableViewController
        //self.presentViewController(vc, animated: true, completion: nil)
      
    
        
        
        switch indexPath.row {
            
        case 0 :
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("News Feed") as NewsFeedTableViewController
            self.navigationController?.pushViewController(vc, animated: true)
            break;
        case 1 :
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("Twitter Page") as TwitterViewController

            self.navigationController?.pushViewController(vc, animated: true)
            break;
            
        case 2 :
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("Videos") as Videos
            self.navigationController?.pushViewController(vc, animated: true)
            break;
            
            
        case 3 :
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("Events") as Events
            self.navigationController?.pushViewController(vc, animated: true)
            break;
            
        case 4 :
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("More") as More
            self.navigationController?.pushViewController(vc, animated: true)
            break;
            
            
        default :
            break;
        }
        
        
        
    }

    
    
    
    
    
    
}

