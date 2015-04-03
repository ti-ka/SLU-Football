//
//  Base.swift
//  Lion Football
//
//  Created by Tika Datta Pahadi on 1/12/15.
//  Copyright (c) 2015 Tika Pahadi. All rights reserved.
//

import UIKit

class Base: UIViewController {
    
    override func viewDidLoad() {
        loadBackground()
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
    
    
    
    func loadBackground(){
        
        var bgImage = UIImage(named: "bg-port")
        
        if(UIApplication.sharedApplication().statusBarOrientation.isLandscape){
            var bgImage = UIImage(named: "bg-land")
        }
        
        
        let ciImage = CIImage(image: bgImage)
        let filter = CIFilter(name: "CIMultiplyCompositing")
        
        let colorFilter = CIFilter(name: "CIConstantColorGenerator")
        let ciColor = CIColor(color: UIColor(red: 64/225, green: 64/225, blue: 29/225, alpha: 1.0))
        colorFilter.setValue(ciColor, forKey: kCIInputColorKey)
        let colorImage = colorFilter.outputImage
        
        filter.setValue(colorImage, forKey: kCIInputImageKey)
        filter.setValue(ciImage, forKey: kCIInputBackgroundImageKey)
        
        
        
        var background   = UIImageView(frame: self.view.bounds);
        background.image = UIImage(CIImage: filter.outputImage)!
        
        self.view.addSubview(background)
        self.view.sendSubviewToBack(background)
        
        
    }
    

    
    

    
    
}
