//
//  More.swift
//  Lion Football
//
//  Created by Tika Datta Pahadi on 1/12/15.
//  Copyright (c) 2015 Tika Pahadi. All rights reserved.
//

import UIKit

class More: UITableViewController {
    
    let moreMenu = ["Academics","Coaches", "Roster","Game Day Experience","Southeastern at a Glance","Virtual Tour","Hammond Town Info","Contact Information","About"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        self.tableView.backgroundView = UIImageView(image: tint(UIImage(named: "bg-port")!,color: UIColor(red: 64/225, green: 64/225, blue: 29/225, alpha: 1.0)))
        self.tableView.separatorColor = UIColor.yellowColor()
        self.title = "More"
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        //Showing Navigation
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
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


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.moreMenu.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("moreCell", forIndexPath: indexPath) as UITableViewCell

            cell.textLabel?.text = self.moreMenu[indexPath.row]
            cell.textLabel?.textColor = UIColor.yellowColor()
            cell.backgroundColor = UIColor.clearColor()
        

        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        println("Clicked \(moreMenu[indexPath.row]) ")
        //let vc = self.storyboard?.instantiateViewControllerWithIdentifier("News Feed") as NewsFeedTableViewController
        //self.presentViewController(vc, animated: true, completion: nil)
        
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        switch indexPath.row {
            
        case 0 :
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("Academics") as Academics
            
            self.navigationController?.pushViewController(vc, animated: true)
            break;
            
            
        case 1 :
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("Coaches") as Coaches
            
            self.navigationController?.pushViewController(vc, animated: true)
            break;
            
        case 2 :
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("Roster") as Roster
            
            self.navigationController?.pushViewController(vc, animated: true)
            break;
            
        case 3 :
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("Videos") as Videos
            
            vc.listId = "PLRzBVSG-3qc7dksIt2Yxc4gjqVdG-5bWt"
            vc.pageTitle = "GameDay"
            
            self.navigationController?.pushViewController(vc, animated: true)
            break;
            
        case 4 :
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("Southeastern") as Southeastern
            
            self.navigationController?.pushViewController(vc, animated: true)
            break;
            
            
        case 5 :
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("Web View") as WebPageViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
            break;
            
            
            
        case 6 :
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("Hammond") as Hammond
            
            self.navigationController?.pushViewController(vc, animated: true)
            break;
            
            
        case 7 :
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("Contact") as Contact
            
            self.navigationController?.pushViewController(vc, animated: true)
            break;
            
            
            
        case 8 :
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("About") as About
            
            self.navigationController?.pushViewController(vc, animated: true)
            break;
            
            
            
            
        default :
            break;
        }
        
        
        
    }
    

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
