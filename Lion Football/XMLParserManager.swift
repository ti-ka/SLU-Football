//
//  XmlParserManager.swift
//  RSSwift
//
//  Created by Arled Kola on 20/10/2014.
//  Copyright (c) 2014 Arled. All rights reserved.
//

import Foundation

class XmlParserManager: NSObject, NSXMLParserDelegate {
    
    var parser = NSXMLParser()
    var feeds = NSMutableArray()
    var elements = NSMutableDictionary()
    
    var element = NSString()
    var ftitle = NSMutableString()
    var flink = NSMutableString()
    var fdescription = NSMutableString()
    var fdate = NSMutableString()
    var fimage = NSMutableString()
    
    
    
    // initilise parser
    func initWithURL(url :NSURL) -> AnyObject {
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
            ftitle = NSMutableString.alloc()
            ftitle = ""
            flink = NSMutableString.alloc()
            flink = ""
            fdescription = NSMutableString.alloc()
            fdescription = ""
            fdate = NSMutableString.alloc()
            fdate = ""
            fimage = NSMutableString.alloc()
            fimage = ""
        }
        
    }
    
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
        
        if (elementName as NSString).isEqualToString("item") {
            if ftitle != "" {
                elements.setObject(ftitle, forKey: "title")
            }
            
            if flink != "" {
                elements.setObject(flink, forKey: "link")
            }
            
            if fdescription != ""{
                
                //Custom For this Site Only
                
                let start  = fdescription.rangeOfString("<br /><br />").location + 12
                let end = fdescription.length - start
                let actualDesc = fdescription.substringWithRange(NSRange(location: start, length: end))
                
                let start2  = fdescription.rangeOfString("<img src=").location + 10
                let end2 = fdescription.rangeOfString(".jpg").location + 4 - start2
                let img = fdescription.substringWithRange(NSRange(location: start2, length: end2))
                
                
                
                elements.setObject(actualDesc, forKey: "description")
                elements.setObject(img, forKey: "image")
            }
            
            if fdate != "" {
                elements.setObject(fdate, forKey: "pubDate")
            }
            
            feeds.addObject(elements)
        }
        
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        
        if element.isEqualToString("title") {
            ftitle.appendString(string)
        } else if element.isEqualToString("link") {
            flink.appendString(string)
        }else if element.isEqualToString("description") {
            fdescription.appendString(string)
        }else if element.isEqualToString("pubDate") {
            fdate.appendString(string)
        }else if element.isEqualToString("image") {
            fimage.appendString(string)
        }
    }
    
    
}