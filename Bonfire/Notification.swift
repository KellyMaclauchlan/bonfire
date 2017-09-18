//
//  Notification.swift
//  Bonfire
//
//  Created by Kelly Maclauchlan on 2016-10-10.
//  Copyright © 2016 Kelly Maclauchlan. All rights reserved.
//

import Foundation
class Notification:Serializable {
    internal var jsonProperties = ["id","senderId","text"];
    
    var id = "";
    var senderId = "";
    var text = "";
    var sender:Profile?;
    
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
        }else if( key == "text"){
            return self.text as AnyObject!;
        }else if( key == "senderId"){
            return self.senderId as AnyObject!;
        }
        return "" as AnyObject!;
    }
    internal func setValueForKey(key: String!,value: String!)  {
        if(key == "id"){
            return self.id = value
        }else if( key == "text"){
            return self.text = value
        }else if( key == "senderId"){
            return self.senderId = value
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
