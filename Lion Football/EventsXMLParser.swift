//
//  XmlParserManager.swift
//  RSSwift
//
//  Created by Arled Kola on 20/10/2014.
//  Copyright (c) 2014 Arled. All rights reserved.
//

import Foundation

class EventsXMLParser: NSObject, NSXMLParserDelegate {
    
    var parser = NSXMLParser()
    var feeds = NSMutableArray()
    var elements = NSMutableDictionary()
    
    var element = NSString()
    
    
    var title = NSMutableString()
    var link = NSMutableString()
    var desc = NSMutableString()
    var gameID = NSMutableString()
    var date = NSMutableString()
    var time = NSMutableString()
    var oppLogo = NSMutableString()
    
    
    
    
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
            date = NSMutableString.alloc()
            date = ""
            time = NSMutableString.alloc()
            time = ""
            oppLogo = NSMutableString.alloc()
            oppLogo = ""
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
                elements.setObject(link.stringByReplacingOccurrencesOfString("\n", withString: ""), forKey: "description")
            }
            if date != ""{
                elements.setObject(date.stringByReplacingOccurrencesOfString("\n", withString: ""), forKey: "s:localstartdate")
            }
            if time != ""{
                elements.setObject(time.stringByReplacingOccurrencesOfString("\n", withString: ""), forKey: "s:localenddate")
            }
            if oppLogo != ""{
                elements.setObject(oppLogo.stringByReplacingOccurrencesOfString("\n", withString: ""), forKey: "s:opponentlogo")
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
        }else if element.isEqualToString("s:localstartdate") {
            date.appendString(string)
        }else if element.isEqualToString("s:localenddate") {
            time.appendString(string)
        }else if element.isEqualToString("s:opponentlogo") {
            oppLogo.appendString(string)
        }
    }
    
    
}