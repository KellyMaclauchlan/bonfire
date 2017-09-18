//
//  Profile.swift
//  Bonfire
//
//  Created by Kelly Maclauchlan on 2016-10-10.
//  Copyright © 2016 Kelly Maclauchlan. All rights reserved.
//

import Foundation
import UIKit
class Profile : Serializable {
    internal var jsonProperties = ["id","names","summary","relationship","profileImage","location"];
    
    var friends = [Profile]();
    var events=[Event]();
    
    var groups=[Group]();
    var notifications=[Notification]();
    var location = "";
    var names = "";
    var summary = "";
    var relationship = "";// needs to be turned into an enum or type of some sort
    var profileImage = "1";// image
    var id = "";
    
    init(friend:[Profile], event:[Event], group: [Group],notification:[Notification]) {
        friends=friend;
        events=event;
        groups=group;
        notifications=notification;
        
    }
    init(){
        
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
        }else if( key == "names"){
            return self.names as AnyObject!;
        }else if( key == "summary"){
            return self.summary as AnyObject!;
        }else if( key == "relationship"){
            return self.relationship as AnyObject!;
        }else if( key == "profileImage"){
            return self.profileImage as AnyObject!;
        }else if( key == "locaiton"){
            return self.location as AnyObject!;
        }
        return "" as AnyObject!;
    }
    internal func setValueForKey(key: String!,value: String!)  {
        if(key == "id"){
            return self.id = value
        }else if( key == "names"){
            return self.names = value
        }else if( key == "summary"){
            return self.summary = value
        }else if( key == "relationship"){
            return self.relationship = value
        }else if( key == "profileImage"){
            return self.profileImage = value
        }else if( key == "locaiton"){
            return self.location = value
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
