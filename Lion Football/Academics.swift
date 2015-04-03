//
//  Academics.swift
//  Lion Football
//
//  Created by Tika Datta Pahadi on 1/12/15.
//  Copyright (c) 2015 Tika Pahadi. All rights reserved.
//

import UIKit

class Academics: UIViewController,UIScrollViewDelegate {

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var pageImages: [UIImage] = []
    var pageViews: [UIImageView?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Academics"
        loadBackground()
        
        scrollView.bounces = false

        
        
        // 1
        pageImages = [
            UIImage(named:"image-19.jpg")!,
            UIImage(named:"image-04.jpg")!,
            UIImage(named:"image-05.jpg")!,
            UIImage(named:"image-06.jpg")!,
            UIImage(named:"image-07.jpg")!,
            UIImage(named:"image-08.jpg")!,
            UIImage(named:"image-09.jpg")!,
            UIImage(named:"image-20.jpg")!
        ]
        
        let pageCount = pageImages.count
        
        // 2
        pageControl.currentPage = 0
        pageControl.numberOfPages = pageCount
        
        // 3
        for _ in 0..<pageCount {
            pageViews.append(nil)
        }
        
        // 4
        
        scrollView.pagingEnabled = true
        
      
        
        
        // 5
        loadVisiblePages()
        

        
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        loadVisiblePages()
    }
    
    
    func loadPage(page: Int) {
        
        if page < 0 || page >= pageImages.count {
            // If it's outside the range of what you have to display, then do nothing
            return
        }
        
        // 1
        if let pageView = pageViews[page] {
            // Do nothing. The view is already loaded.
        } else {
            // 2
            var frame = scrollView.bounds
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0.0
            
            if(UIApplication.sharedApplication().statusBarOrientation.isPortrait){
                //If portrait twice the width & origin because we show half image
                frame.size.width = frame.size.width * 2
                frame.origin.x = frame.size.width * CGFloat(page)
                
                
            }
            
            
            // 3
            let newPageView = UIImageView(image: pageImages[page])
            //newPageView.contentMode = .ScaleAspectFit
            newPageView.frame = frame
            scrollView.addSubview(newPageView)
            
            // 4
            pageViews[page] = newPageView
        }
    }
    
    
    
    func purgePage(page: Int) {
        
        if page < 0 || page >= pageImages.count {
            // If it's outside the range of what you have to display, then do nothing
            return
        }
        
        // Remove a page from the scroll view and reset the container array
        if let pageView = pageViews[page] {
            pageView.removeFromSuperview()
            pageViews[page] = nil
        }
        
    }
    
    func loadVisiblePages() {
        
        let pagesScrollViewSize = scrollView.frame.size
        
        if(UIApplication.sharedApplication().statusBarOrientation.isPortrait){
            //If portrait twice the width because we show half image
            scrollView.contentSize = CGSizeMake(
                pagesScrollViewSize.width * CGFloat(pageImages.count) * 2,
                pagesScrollViewSize.height
            )
        } else {
            scrollView.contentSize = CGSizeMake(
                pagesScrollViewSize.width * CGFloat(pageImages.count),
                pagesScrollViewSize.height
            )
        }
        
        
        // First, determine which page is currently visible
        let pageWidth = scrollView.frame.size.width
        var page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        
        if(UIApplication.sharedApplication().statusBarOrientation.isPortrait){
            //If portrait we have double page size, so divide by 2
            page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0))) / 2
        }

        
        // Update the page control
        pageControl.currentPage = page
        
        // Work out which pages you want to load
        let firstPage = page - 1
        let lastPage = page + 1
        
        
        // Purge anything before the first page
        for var index = 0; index < self.pageViews.count; ++index {
            purgePage(index)
        }
        
        // Load pages in our range
        for var index = firstPage; index <= lastPage; ++index {
            loadPage(index)
        }
        
        // Purge anything after the last page
        for var index = lastPage+1; index < pageImages.count; ++index {
            purgePage(index)
        }
    }
    
    
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        // Load the pages that are now on screen
        loadVisiblePages()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func viewDidAppear(animated: Bool) {
    /*
        let buttonPuzzle:UIButton = UIButton(frame: CGRectMake(100, 400, 100, 50))
        buttonPuzzle.backgroundColor = UIColor.greenColor()
        buttonPuzzle.setTitle("Puzzle", forState: UIControlState.Normal)
        buttonPuzzle.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        buttonPuzzle.tag = 22;
        self.view.addSubview(buttonPuzzle)
    */
        
        
    }
    
    /*
    func buttonAction(sender:UIButton!)
    {
        var btnsendtag:UIButton = sender
        if btnsendtag.tag == 22 {
            println("Button tapped tag 22")
        }
    }
    
    */
    

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


    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        println("Zooming")
        return self.view;
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
