//
//  Roster.swift
//  Lion Football
//
//  Created by Tika Datta Pahadi on 1/12/15.
//  Copyright (c) 2015 Tika Pahadi. All rights reserved.
//

import UIKit

class Roster: UITableViewController {
    
    let roster = [
        ("1","2942","Harlan Miller","Defensive Back, Sr."),
        ("1","2953","Xavier Roberson","Running Back, Sr."),
        ("2","2914","Micah Eugene","Defensive Back, Sr."),
        ("2","2920","Rasheed Harrell","Running Back, Sr."),
        ("3","2977","Will Hines","Defensive Back, Sr."),
        ("4","2950","Derrick Raymond","Defensive Back, Sr."),
        ("4","2965","Kody Sutton","Running Back, Sr."),
        ("5","2978","Brandon Acker","Wide Receiver, Jr."),
        ("5","2897","Jordan Batiste","Defensive Back, Sr."),
        ("6","2980","Larry Cutbirth","Quarterback, Jr."),
        ("6","2979","Javon Tillman","Defensive Back, Jr."),
        ("7","2964","Da'Quan Smith","Wide Receiver, Jr."),
        ("8","2925","Kaelyn Henderson","Defensive Back, Jr."),
        ("8","2946","Kendrick Peeples","Wide Receiver, Gr."),
        ("9","2967","Denzel Thompson","Defensive Back, Jr."),
        ("10","2935","D'Shaie Landor","Quarterback Jr."),
        ("11","2922","Marquis Hatcher","Defensive Back, Sr."),
        ("12","2899","Jarrell Bennett","Wide Receiver, Jr."),
        ("13","2919","Trey Hallman","Wide Receiver, Jr."),
        ("14","2962","Jeff Smiley","Wide Receiver, Sr."),
        ("15","2954","Dereck Robinson","Linebreaker, Sr."),
        ("16","2928","Kiley Huddleston","Quarterback, Fr."),
        ("17","2932","Isaiah Kepley","Wide Receiver, Sr."),
        ("18","2900","Eugene Bethea","Running Back, So."),
        ("20","2910","Aaron Craig","Defensive Back, Fr."),
        ("21","2959","JQ Sandolph","Defensive Back, Jr."),
        ("24","2911","Josh Dakin","Defensive Back, Sr."),
        ("25","2937","Reggie Lesueur","Defensive Back, Sr."),
        ("26","2961","Ryan Sigers","Defensive Back, So."),
        ("27","2955","Juwaan Rogers","Fullback, Sr."),
        ("28","2918","Darrius Guy","Running Back, Sr."),
        ("29","2958","Courtney Rutledge","Defensive Back, So."),
        ("30","2936","Cole LeBlanc","Defensive Back, Jr."),
        ("32","2981","Demareyeh Lane","Defensive Back, So."),
        ("33","2982","Antreon Bennett","Linebacker, Jr."),
        ("33","2940","Julius Maraclin","Running Back, Fr."),
        ("34","2960","Jordan Showalter","Fullback, So."),
        ("36","2986","Harris Beall","Kicker/Punter, Fr."),
        ("36","2907","Tim Callian","Kicker/Punter, Sr."),
        ("38","2904","Andrew Breeland","Defensive Back, Fr."),
        ("38","2938","Tyler Lockhart","Defensive Back, Fr."),
        ("39","2983","Harrison Heim","Kicker/Punter Fr."),
        ("40","2936","Alex Herbert","Kicker So."),
        ("41","2921","Herbert Harris","Linebacker, Sr."),
        ("42","2972","TJ West","Linebacker, Sr."),
        ("43","2974","Caleb Young","Linebacker, Jr."),
        ("45","2903","A.J. Bowen","Defensive Line, Sr."),
        ("46","2939","Ja'Hmal Macklin","Linebacker, Fr."),
        ("47","2930","Taylor Jenkins","Tight End, Sr."),
        ("48","2944","Anthony Murphy","Defensive Line, Sr."),
        ("49","2948","Aaron Price","Defensive Line, Sr."),
        ("50","2975","Jalal Yousofzai","Linebacker, Jr."),
        ("51","2951","Aaron Reed","Offensive Lineman, Sr."),
        ("52","2908","Sean Clavelle","Linkbacker, Fr."),
        ("53","2941","Shaq McClain","Offensive Line, Fr."),
        ("54","2927","Brophy Hiatt","Offensive Line, Jr."),
        ("55","2956","Taylor Romero","Offensive Line, Jr."),
        ("56","2949","Laurence Ramsey","Offensive Line, Sr."),
        ("57","2933","Caleb Kerstens","Defensive Line, Fr."),
        ("58","2934","Walt Ladne","Offensive Line, Fr."),
        ("59","2969","Michael Vick","Offensive Line, So."),
        ("63","2896","Sean Barrette","Offensive Line, Fr."),
        ("64","2971","Brent Wagner","Offensive Line, Jr."),
        ("65","2976","Cory Zunker","Offensive Line, Jr."),
        ("66","2916","Conner Gerage","Offensive Line, So."),
        ("68","2957","Travis Romero","Offensive Line, So."),
        ("70","2898","Myles Becnel","Offensive Line, Fr."),
        ("71","2917","Joe Graves","Offensive Line, Sr.."),
        ("72","2909","Taylor Cochran","Defensive Line, So."),
        ("73","2970","Pierson Villarubia","Offensive Line, Jr."),
        ("75","2943","Josue Miranda","Offensive Line, Sr."),
        ("76","2963","Byron Smith","Offensive Line, Sr."),
        ("77","2945","Javari Nichols","Offensive Line, Jr."),
        ("78","2984","Justin Barksdale","Offensive Line, Jr."),
        ("79","2924","Daniel Henderson","Offensive Line, So."),
        ("80","2902","Dylan Bossier","Wide Receiver, Sr."),
        ("80","2929","Jake Ingraffia","Wide Receiver, Fr."),
        ("81","2905","Chris Briggs","Wide Receiver, Sr."),
        ("83","2906","Toby Briggs","Tight End, So."),
        ("84","2912","Cameron Dobbins","Wide Receiver, Fr."),
        ("85","2931","Byron Johnson","Wide Receiver, Sr."),
        ("86","2952","Kaylan Richardson","Wide Receiver, Sr."),
        ("87","2915","Ross Foreman","Wide Receiver, Fr."),
        ("88","2901","Brice Bishop","Long Snapper, Jr."),
        ("89","2966","Jonathon Tatum","Kicker, Fr."),
        ("93","2923","Ashton Henderson","Defensive Line Sr."),
        ("94","2985","Trent Williams","Defensive Line, Jr."),
        ("96","2895","Tupou Aleamotua","Defensive Line, Sr."),
        ("97","2947","Terangi Phifer","Defensive Line, Sr."),
        ("","2913","Garrin Dunbar","Defensive Back, Fr."),
        ("","2968","Ben Todd","Quarterback, So.")
        
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.backgroundView = UIImageView(image: tint(UIImage(named: "bg-port")!,color: UIColor.yellowColor()))
        self.tableView.separatorColor = UIColor.blackColor()
        self.title = "Roster"
        self.tableView.rowHeight = 60
        
    }
    
    func tint(image: UIImage, color: UIColor) -> UIImage{
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
        return roster.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("rosterCell", forIndexPath: indexPath) as UITableViewCell

        //let cell = UITableViewCell()
        
        
        
        let (jersey, rosterNo, name, position) = roster[indexPath.row]
        
        
    
        
        let w = self.view.bounds.width
        let h = self.view.bounds.height
        
        
        var subViews  = cell.contentView.subviews
        for subview in subViews as [UIView]   {
            subview.removeFromSuperview()
        }
        
        
        
        let pic = UIImageView(frame: CGRectMake(10, 5, 40, 50))
        
        
        
        if(UIImage(named: rosterNo) != nil){
            pic.image = UIImage(named: rosterNo)
        } else {
            pic.image = UIImage(named: "Person.jpg")
        }
        
        cell.contentView.addSubview(pic)
        
        
        let label = UILabel(frame: CGRectMake(60, 5, 50, 50))
        label.textColor = UIColor(red: 1, green : 215/255 , blue:0, alpha :1.0)
        label.font = UIFont(name: label.font.fontName, size: 35)
        label.backgroundColor = UIColor(red: 0, green : 80/255 , blue:0, alpha :1.0)
        label.textAlignment = NSTextAlignment.Center
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.numberOfLines = 1
        cell.contentView.addSubview(label)
        
        let nameLabel = UILabel(frame: CGRectMake(120, 10, w-125, 20))
        nameLabel.textColor = UIColor.yellowColor()
        nameLabel.font = UIFont(name: nameLabel.font.fontName, size: 20)
        //label.backgroundColor = UIColor.grayColor()
        nameLabel.textAlignment = NSTextAlignment.Left
        nameLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        nameLabel.numberOfLines = 1
        cell.contentView.addSubview(nameLabel)
        
        
        let infoLabel = UILabel(frame: CGRectMake(120, 35, w-125, 20))
        infoLabel.textColor = UIColor.grayColor()
        infoLabel.font = UIFont(name: infoLabel.font.fontName, size: 18)
        //label.backgroundColor = UIColor.grayColor()
        infoLabel.textAlignment = NSTextAlignment.Left
        infoLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        infoLabel.numberOfLines = 1
        cell.contentView.addSubview(infoLabel)
        
        
        
        label.text = jersey
        nameLabel.text = name
        infoLabel.text = position
        
        
        
        cell.textLabel?.backgroundColor = UIColor.clearColor()
        cell.detailTextLabel?.backgroundColor = UIColor.clearColor()
        
    
        
        
        if(indexPath.row % 2 == 1){
            cell.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.70)
        } else {
            cell.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.90)
        }

        
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let (jersey,rosterNo, name, position) = roster[indexPath.row]
        
        
        let urlString = "http://lionsports.net/roster.aspx?rp_id=\(rosterNo)";
        
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("Web View") as WebPageViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
        vc.url = urlString;
        vc.pageTitle = "Player Info"
        
        
        
    }


    
    

}
