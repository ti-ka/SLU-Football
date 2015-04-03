//
//  BasicViewController.swift
//  Lion Football
//
//  Created by Tika Datta Pahadi on 1/22/15.
//  Copyright (c) 2015 Tika Pahadi. All rights reserved.
//

import UIKit

class Hammond: UIViewController {
    
    
    @IBOutlet weak var bgImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBackground()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        //let v : UIImageView = self.view.viewWithTag(400) as UIImageView
        //v.frame = self.view.bounds
        
        
    }
    
    
    
    func loadBackground(){
        var bgImage = UIImage(named: "bg-port")
        let ciImage = CIImage(image: bgImage)
        let filter = CIFilter(name: "CIMultiplyCompositing")
        
        let colorFilter = CIFilter(name: "CIConstantColorGenerator")
        let ciColor = CIColor(color: UIColor(red: 64/225, green: 64/225, blue: 29/225, alpha: 1.0))
        colorFilter.setValue(ciColor, forKey: kCIInputColorKey)
        let colorImage = colorFilter.outputImage
        
        filter.setValue(colorImage, forKey: kCIInputImageKey)
        filter.setValue(ciImage, forKey: kCIInputBackgroundImageKey)
        
        /*
        var background   = UIImageView(frame: self.view.bounds);
        background.image = UIImage(CIImage: filter.outputImage)!
        background.tag = 400
        self.view.addSubview(background)
        self.view.sendSubviewToBack(background)
        */
        self.bgImage.image = UIImage(CIImage: filter.outputImage)!
    }
    
    
    
}
