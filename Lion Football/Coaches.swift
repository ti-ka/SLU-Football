//
//  Coaches.swift
//  Lion Football
//
//  Created by Tika Datta Pahadi on 1/12/15.
//  Copyright (c) 2015 Tika Pahadi. All rights reserved.
//

import UIKit

class Coaches: UITableViewController {

    let coaches = [
        ("Ron Roberts","Head Football Coach","Ron.Roberts@southeastern.edu","Ron Roberts","424"),
        ("Brandon Lacy","Asst. Coach/Recr. Coordinator","Brandon.Lacy@southeastern.edu","Brandon Lacy","430"),
        ("Travis Mikel","Assistant Coach","Travis.Mikel-Allen@southeastern.edu","Travis Mikel","426"),
        ("Sean O'Sullivan","Assistant Coach","Sean.OSullivan@southeastern.edu","Sean O'Sullivan","432"),
        ("Chet Pobolish","Assistant Coach","Chet.Pobolish@southeastern.edu","Chet Pobolish","427"),
        ("Wesley Satterfield","Assistant Coach","wesley.satterfield@selu.edu","Wesley Satterfield","433"),
        ("Patrick Toney","Assistant Coach","patrick.toney@selu.edu","Patrick Toney","434"),
        ("Aaron Schwanz","Assistant Coach","Aaron.Schwanz@southeastern.edu","Aaron Schwanz","440"),
        ("Tyler Hennes","Assistant Coach","Tyler.Hennes@southeastern.edu","Tyler Hennes","441"),
        ("Blake Williams","Assistant Coach","Blake.Williams-2@southeastern.edu","Blake Williams","504")
    ];
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "bg-port"))
        self.tableView.separatorColor = UIColor.grayColor()
        self.title = "Coaches"
        self.tableView.rowHeight = 80
        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    

    
    override func viewDidAppear(animated: Bool) {
        //Showing Navigation
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
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
        return coaches.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        let cell = UITableViewCell()
        
        
        let (name,title,email,image,rosterID) = coaches[indexPath.row]
        
        cell.textLabel?.text = ""
        cell.detailTextLabel?.text = ""
        
        if(UIImage(named: image) != nil){
            let img = UIImage(named: "\(image)")
            cell.imageView?.image = img!;
        } else {
            let img = UIImage(named: "Person.jpg")
            cell.imageView?.image = img!;
        }
        
        
        let width = self.view.bounds.width
        let height = self.view.bounds.height
        
        
        
        
        var label = UILabel(frame: CGRectMake(85, 5, width-90, 30))
        label.textColor = UIColor.yellowColor()
        label.font = UIFont(name: label.font.fontName, size: 20)
        //label.backgroundColor = UIColor.grayColor()
        label.textAlignment = NSTextAlignment.Left
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.numberOfLines = 1
        label.text = name
        cell.contentView.addSubview(label)
        
        
        label = UILabel(frame: CGRectMake(85, 30, width-90, 25))
        label.textColor = UIColor.grayColor()
        label.font = UIFont(name: label.font.fontName, size: 18)
        //label.backgroundColor = UIColor.grayColor()
        label.textAlignment = NSTextAlignment.Left
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.numberOfLines = 1
        label.text = title
        cell.contentView.addSubview(label)
        
        
        label = UILabel(frame: CGRectMake(85, 50, width-90, 25))
        label.textColor = UIColor.grayColor()
        label.font = UIFont(name: label.font.fontName, size: 17)
        //label.backgroundColor = UIColor.grayColor()
        label.textAlignment = NSTextAlignment.Left
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.numberOfLines = 1
        label.text = email
        cell.contentView.addSubview(label)
        
        
        
        
        
        
        cell.textLabel?.backgroundColor = UIColor.clearColor()
        cell.detailTextLabel?.backgroundColor = UIColor.clearColor()
        
        
        
        
        
        
        
        if(indexPath.row % 2 == 1){
            cell.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.80)
        } else {
            cell.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.90)
        }
        
        
        
        
    
        return cell
    }


    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let (name,title,email,image,rosterID) = coaches[indexPath.row]
        
        let urlString = "http://lionsports.net/coaches.aspx?rc=\(rosterID)";

        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("Web View") as WebPageViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
        vc.url = urlString;
        vc.pageTitle = "Coach Info"
        
        
        
    }

}
