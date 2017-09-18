//
//  Event.swift
//  Bonfire
//
//  Created by Kelly Maclauchlan on 2016-10-10.
//  Copyright © 2016 Kelly Maclauchlan. All rights reserved.
//

import Foundation
import UIKit
class Event: Serializable {
    internal var jsonProperties = ["id","name","summary","date","time","location","creatorId","groupId"];
    
    var id = "";
    var name = "";
    var date = "";
    var time = "";
    var summary = "";
    var location = "";
    var peopleGoing:[Profile]?;
    var image = "1";
    var creatorId = "";
    var groupId = "";
    var groupName = "";
    init() {
        peopleGoing=[];
    }
    init(JSONString: String) {
        
        do {
            let jsonDict = convertStringToDictionary(text: JSONString);
            let jsonData = try JSONSerialization.data(withJSONObject: jsonDict, options: .prettyPrinted)
            // here "jsonData" is the dictionary encoded in JSON data
            
            let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
            // here "decoded" is of type `Any`, decoded from JSON data
            
            // you can now cast it with the right type
            if let dictFromJSON = decoded as? [String:String] {
                for(key,value) in dictFromJSON{
                    let keyName = key as String
                    let keyValue = value as String;
                    
                    setValueForKey(key: keyName, value: keyValue);
                    
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        
    }
    internal func valueForKey(key: String!) -> AnyObject! {
        if(key == "id"){
            return self.id as AnyObject!;
        }else if( key == "name"){
            return self.name as AnyObject!;
        }else if( key == "summary"){
            return self.summary as AnyObject!;
        }else if( key == "time"){
            return self.time as AnyObject!;
        }else if( key == "date"){
            return self.date as AnyObject!;
        }else if( key == "locaiton"){
            return self.location as AnyObject!;
        }else if( key == "creatorId"){
            return self.creatorId as AnyObject!;
        }else if( key == "groupId"){
            return self.groupId as AnyObject!;
        }
        return "" as AnyObject!;
    }
    internal func setValueForKey(key: String!,value: String!)  {
        if(key == "id"){
            return self.id = value
        }else if( key == "name"){
            return self.name = value
        }else if( key == "summary"){
            return self.summary = value
        }else if( key == "date"){
            return self.date = value
        }else if( key == "time"){
            return self.time = value
        }else if( key == "locaiton"){
            return self.location = value
        }else if( key == "creatorId"){
            return self.creatorId = value
        }
        else if( key == "groupId"){
            return self.groupId = value
        }
        
    }
    public func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
}
