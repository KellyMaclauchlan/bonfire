//
//  Account.swift
//  Bonfire
//
//  Created by Kelly Maclauchlan on 2016-10-10.
//  Copyright © 2016 Kelly Maclauchlan. All rights reserved.
//

import Foundation
class Account: Serializable {
    internal var jsonProperties = ["id","nameOne","emailOne","nameTwo","emailTwo","password"];
    var id = "";
    var emailOne = "";
    var nameOne = "";
    var emailTwo = "";
    var nameTwo = "";
    var password = "";
    
    var profile:Profile?;
    var profileID = "";
    
   
    
    init() {
        
    }
    init(profileInit: Profile) {
        profile=profileInit;
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
        }else if( key == "nameOne"){
            return self.nameOne as AnyObject!;
        }else if( key == "emailOne"){
            return self.nameTwo as AnyObject!;
        }else if( key == "nameTwo"){
            return self.nameTwo as AnyObject!;
        }else if( key == "emailTwo"){
            return self.emailTwo as AnyObject!;
        }else if( key == "password"){
            return self.password as AnyObject!;
        }
        return "" as AnyObject!;
    }
    internal func setValueForKey(key: String!,value: String!)  {
        if(key == "id"){
            return self.id = value
        }else if( key == "nameOne"){
            return self.nameOne = value
        }else if( key == "emailOne"){
            return self.nameTwo = value
        }else if( key == "nameTwo"){
            return self.nameTwo = value
        }else if( key == "emailTwo"){
            return self.emailTwo = value
        }else if( key == "password"){
            return self.password = value
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
