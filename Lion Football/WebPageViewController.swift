//
//  FeedWebPageViewController.swift
//  RSSwift
//
//  Created by Arled Kola on 27/10/2014.
//  Copyright (c) 2014 Arled. All rights reserved.
//

import UIKit

class WebPageViewController: UIViewController {
    
    //Defaulting to Virtal Tour
    //But any Page can use it
    
    var url = "http://www.youvisit.com/tour/southeastern"
    var pageTitle = ""
    var id = 0
    var from = ""
    
    
    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = pageTitle
        webView.opaque = false
        webView.backgroundColor = UIColor.clearColor()
     
        
        
        
        // Do any additional setup after loading the view.
    }
    
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if(url == "http://www.youvisit.com/tour/southeastern"){
            self.title = "Virtal Tour"
        }
        
        
        println("Browsing internet: \(url)")
        
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        webView.loadRequest(request)
        
        var str = String(contentsOfURL: NSURL(string: "http://akitech.org/tests/net.json")!, encoding: NSUTF8StringEncoding, error: nil)
        //println(str)
        if(str == nil){
            var screenRect = UIScreen.mainScreen().bounds;
            var screenWidth : CGFloat = screenRect.size.width;
            var screenHeight : CGFloat = screenRect.size.height;
            
            
            var label = UILabel(frame: CGRectMake(40, screenHeight/2 - 80, screenWidth - 80, 50))
            label.textColor = UIColor.grayColor()
            label.font = UIFont(name: label.font.fontName, size: 40)
            //label.backgroundColor = UIColor.redColor()
            label.textAlignment = NSTextAlignment.Center
            label.lineBreakMode = NSLineBreakMode.ByWordWrapping
            label.numberOfLines = 1
            
            label.text = "Oops :/"
            self.view.addSubview(label)
            
            
            label = UILabel(frame: CGRectMake(40, screenHeight/2 - 30, screenWidth - 80, 60))
            label.textColor = UIColor.lightGrayColor()
            label.font = UIFont(name: label.font.fontName, size: 18)
            //label.backgroundColor = UIColor.greenColor()
            label.textAlignment = NSTextAlignment.Center
            label.lineBreakMode = NSLineBreakMode.ByWordWrapping
            label.numberOfLines = 3
            
            label.text = "Looks like you are not connected to the internet. Give it a try later."
            self.view.addSubview(label)
            
            
        }
        
    }
    
}
