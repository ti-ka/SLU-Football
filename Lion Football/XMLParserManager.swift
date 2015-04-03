//
//  XmlParserManager.swift
//  RSSwift
//
//  Created by Arled Kola on 20/10/2014.
//  Copyright (c) 2014 Arled. All rights reserved.
//

import UIKit
import Foundation

class XmlParserManager: NSObject, NSXMLParserDelegate {
    
    var parser = NSXMLParser()
    var feeds = NSMutableArray()
    var elements = NSMutableDictionary()
    
    var element = NSString()
    
    var title = NSMutableString()
    
    var link = NSMutableString()
    
    var desc = NSMutableString()
    
    var pubDate = NSMutableString()
    
    var image = NSMutableString()
    
    
    
    
    // initilise parser
    func initWithURL(url :NSURL) -> AnyObject {
        //print(url)
        startParse(url)
        return self
    }
    
    func startParse(url :NSURL) {
        feeds = []
        parser = NSXMLParser(contentsOfURL: url)!
        parser.delegate = self
        parser.shouldProcessNamespaces = false
        parser.shouldReportNamespacePrefixes = false
        parser.shouldResolveExternalEntities = false
        parser.parse()
    }
    
    func allFeeds() -> NSMutableArray {
        return feeds
    }
    
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName: String!, attributes attributeDict: NSDictionary!) {
        
        element = elementName
        
        if (element as NSString).isEqualToString("item") {
            elements = NSMutableDictionary.alloc()
            elements = [:]
            title = NSMutableString.alloc()
            title = ""
            link = NSMutableString.alloc()
            link = ""
            desc = NSMutableString.alloc()
            desc = ""
            pubDate = NSMutableString.alloc()
            pubDate = ""
            image = NSMutableString.alloc()
            image = ""
        }
        
    }
    
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
        
        if (elementName as NSString).isEqualToString("item") {
            if title != "" {
                elements.setObject(title.stringByReplacingOccurrencesOfString("\n", withString: ""), forKey: "title")
            }
            
            if link != "" {
                elements.setObject(link.stringByReplacingOccurrencesOfString("\n", withString: ""), forKey: "link")
            }
            
            if desc != ""{
                //Custom For this Site Only

                let str : String = desc as String
                
                var img = "http://www.lionsports.net/images/2015/1/30/stadium_fb_2013_action3_web.jpg"
                
                var index  = str.rangeOfString("<img src=\"")?.endIndex
                var _temp = str.substringFromIndex(index!)
                
                
                if(index != nil){                    index  = _temp.rangeOfString(".jpg")?.endIndex
                    if(index == nil){
                        index = _temp.rangeOfString(".jpeg")?.endIndex
                        if(index == nil){
                            _temp.rangeOfString(".png")?.endIndex
                        }
                    }
                    
                    if(index != nil){
                        _temp = _temp.substringToIndex(index!)
                        img = _temp
                    }
                }
                
                
                elements.setObject(img, forKey: "image")
                
                
            }
            if pubDate != ""{
                elements.setObject(pubDate.stringByReplacingOccurrencesOfString("\n", withString: ""), forKey: "pubDate")
            }
            
            
            
            feeds.addObject(elements)
            //print(elements)
            
            
        }
        
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        
        if element.isEqualToString("title") {
            title.appendString(string)
        } else if element.isEqualToString("link") {
            link.appendString(string)
        }else if element.isEqualToString("description") {
            desc.appendString(string)
        }else if element.isEqualToString("pubDate") {
            pubDate.appendString(string)
        }
    }
    
    
}