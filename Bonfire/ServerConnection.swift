//
//  ServerConnection.swift
//  Bonfire
//
//  Created by Kelly Maclauchlan on 2016-10-26.
//  Copyright © 2016 Kelly Maclauchlan. All rights reserved.
//

import Foundation
class ServerConnection{
     var myProfile:Profile;
    var baseurl = "http://"
    var ip = "192.168.2.14"   //"192.168.1.6"
    var port = ":8080/Bonfire/"
    var endpointAccount = "account/"
    var endpointProfile = "profile/"
    var signup = "makeaccount?"
    var login = "login?"
    var editProfile = "editProfile?"
    var createGroup = "createGroup?"
    var createEvent = "createEvent?"
    var editGroup = "editGroup?"
    var editEvent = "editEvent?" 
    var joinGroup = "joinGroup?"
    var joinEvent = "joinEvent?"
    var addFriend = "addFriend?"
    var getRandomProfileURL = "getRandomProfile?"
    var getGroup = "getGroup?"
    var getEvent = "getEvent?"
    var getProfile = "getProfile?"
    var getFriends = "getFriends?"
    var getEvents = "getEvents?"
    var getGroups = "getGroups?"
    var getMembers = "getMembers?"
    var getGoing = "getGoing?"
    var getEventsForGroup = "getEventsForGroup?"
    var getGroupsInCommon = "getGroupsInCommon?"
    var getFriendsInCommon = "getFriendsInCommon?"
    var findProfiles = "findProfiles"
    var findGroups = "findGroups?"
    var findEvents = "findEvents?"
    var sendMessage = "sendMessage?"
    var getConversation = "getConversation?"
    var getConversationsForProfile = "getConversationsForProfile?"
    
    
    init(){
        myProfile = Profile(friend: [],event: [],group: [],notification: []);
    }
   
    func login(email:String,password:String) -> String {
        //get profile that matches this and set it as myProfile
        let semaphore = DispatchSemaphore(value: 0);
        
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointAccount
        url=url+login;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "email="+email+"&password="+password
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        var responseS = "true"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
           let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            print("responseString = \(responseString)")
            if(responseString == "false"){
                responseS="false"
            }
            var profile = self.profileFromJson(json: responseString!);
            self.myProfile=profile;
            print("responseString = \(responseString)")
            semaphore.signal();
        }

        task.resume()
         semaphore.wait(timeout: .distantFuture);
        
        return responseS;
        
    }
    
    //get full
    func getFullProfile(profile:Profile)->Profile{
        let semaphore = DispatchSemaphore(value: 0);
        var id = profile.id;
        var fullProfile = Profile();
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointProfile
        url=url+self.getProfile;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "input="+id
        print(postString);
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
           let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            print("responseString = \(responseString)")
            
            fullProfile = self.profileFromJson(json: responseString!);
            
            print("responseString = \(responseString)")
            semaphore.signal();
        }
        //get profile with id
        
        task.resume()
         semaphore.wait(timeout: .distantFuture);
        return fullProfile;
    }
    func getFullEvent(event:Event)->Event{
        let semaphore = DispatchSemaphore(value: 0);
        var id = event.id;
        var fullEvent = Event();
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointProfile
        url=url+getEvent;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "input="+id
        print(postString);
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
           let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            print("responseString = \(responseString)")
            fullEvent = self.eventFromJson(json: responseString!);
            
            
            print("responseString = \(responseString)")
            semaphore.signal();
        }
        //get event with id
        task.resume()
         semaphore.wait(timeout: .distantFuture);
        return fullEvent;
    }
    
    func getFullGroup(group:Group)->Group{
        let semaphore = DispatchSemaphore(value: 0);
        var id = group.id;
        //get group with id
        var fullGroup = Group();
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointProfile
        url=url+getGroup;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "input="+id
        print(postString);
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
           let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            print("responseString = \(responseString)")
            fullGroup = self.groupFromJson(json: responseString!);
            
            print("responseString = \(responseString)")
            semaphore.signal();
        }
        task.resume()
        semaphore.wait(timeout: .distantFuture);
        return fullGroup;
    }
    //create
    func createEvent(event:Event)->Event{
        //send event to server 
        //get event back from server
        let semaphore = DispatchSemaphore(value: 0);
        var fullEvent = Event();
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointProfile
        url=url+createEvent;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "input="+self.eventToJson(event: event)
        print(postString);
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
           let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            print("responseString = \(responseString)")
            fullEvent = self.eventFromJson(json: responseString!);
            
            print("responseString = \(responseString)")
        semaphore.signal();
        }
task.resume()
        semaphore.wait(timeout: .distantFuture);
        return fullEvent;
    }
    func createGroup(group:Group)->Group{
        //send event to server
        //get event back from server
        let semaphore = DispatchSemaphore(value: 0);
        var fullGroup = Group();
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointProfile
        url=url+createGroup;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "input="+self.groupToJson(group: group)
        print(postString);
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
           let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
            fullGroup = self.groupFromJson(json: responseString!);
            
            print("responseString = \(responseString)")
        semaphore.signal();
        }
        task.resume()
        semaphore.wait(timeout: .distantFuture);
        return fullGroup;
    }
    //edits
    func editProfile(profile:Profile)->Profile{
        let semaphore = DispatchSemaphore(value: 0);
        var id = profile.id;
        //get profile with id
        var fullProfile = Profile();
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointProfile
        url=url+editProfile;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "input="+self.profileToJson(profile: profile)
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
           let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
            fullProfile = self.profileFromJson(json: responseString!);
            
            print("responseString = \(responseString)")
            semaphore.signal();
        }
        task.resume()
        semaphore.wait(timeout: .distantFuture);
        return fullProfile;
    }
    func editEvent(event:Event)->Event{
        //send event to server
        //get event back from server
        let semaphore = DispatchSemaphore(value: 0);
        var fullEvent = Event();
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointProfile
        url=url+editEvent;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "input="+self.eventToJson(event: event)
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
           let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
            fullEvent = self.eventFromJson(json: responseString!);
            
            print("responseString = \(responseString)")
            semaphore.signal();
        }
        task.resume()
         semaphore.wait(timeout: .distantFuture);
        return fullEvent;
    }
    func editGroup(group:Group)->Group{
        //send event to server
        //get event back from server
        let semaphore = DispatchSemaphore(value: 0);
        var fullGroup = Group();
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointProfile
        url=url+editGroup;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "input="+self.groupToJson(group: group)
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
           let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
            fullGroup = self.groupFromJson(json: responseString!);
            
            print("responseString = \(responseString)")
            semaphore.signal();
        }
        task.resume()
         semaphore.wait(timeout: .distantFuture);
        return fullGroup;
    }
    
    //get notifications 
    func getNotifications()->[Notification]{
        let semaphore = DispatchSemaphore(value: 0);
        var notify = [Notification]();
        //get a list of the notificaitons for the profile of the user. 
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointProfile
        url=url+createGroup;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "input="+self.myProfile.id
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
           let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
            notify = self.notificationArrayFromString(string: responseString!);
            
            print("responseString = \(responseString)")
            semaphore.signal();
        }
        task.resume()
        semaphore.wait(timeout: .distantFuture);
        return notify;
    }
    //adding and removing event's from your list
    func joinGroup(group:Group){
        let semaphore = DispatchSemaphore(value: 0);
        var groupId = group.id;
        var profileId = myProfile.id;
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointProfile
        url=url+joinGroup;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "profile="+profileId+"&group="+groupId
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
           let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
            
            
            print("responseString = \(responseString)")
            semaphore.signal();
        }
        //add the connection to the joining table 
        task.resume()
        semaphore.wait(timeout: .distantFuture);
    }
    func joinEvent(event:Event){
        let semaphore = DispatchSemaphore(value: 0);
        var eventId = event.id;
        var profileId = myProfile.id;
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointProfile
        url=url+self.joinEvent;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "profile="+profileId+"&event="+eventId
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
           let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
            
            
            print("responseString = \(responseString)")
            semaphore.signal();
        }
        task.resume()
        semaphore.wait(timeout: .distantFuture);
        //add the connection to the joining table
        
    }
    // not yet implemented
    func leaveGroup(group:Group){
        var groupId = group.id;
        var profileId = myProfile.id;
        //add the connection to the joining table
        
    }
    // not yet implemented
    func leaveEvent(event:Event){
        var eventId = event.id;
        var profileId = myProfile.id;
        //add the connection to the joining table
        
    }
    //add and remove friends have a pending row in this table gets set when created and removed when confirmed
    func addFriend(profile:Profile){
        let semaphore = DispatchSemaphore(value: 0);
        var friendId = profile.id;
        var profileId = myProfile.id;
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointProfile
        url=url+self.addFriend;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "profile1="+profileId+"&profile2="+friendId
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
           let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
            
            
            print("responseString = \(responseString)")
            semaphore.signal();
        }
        task.resume()
        semaphore.wait(timeout: .distantFuture);
        //remove the connection to the joining table
        
    }
    // not yet implemented
    func removeFriend(profile:Profile){
        var friendId = profile.id;
        var profileId = myProfile.id;
        //remove the connection to the joining table
        
    }
    
    //get random profile not friends with 
    func getRandomProfile()->Profile{
        let semaphore = DispatchSemaphore(value: 0);
        var profile = Profile();
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointProfile
        url=url+self.getRandomProfileURL;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        //let postString = "profile1="+profileId+"&profile2="+friendId
        //print(postString);
        //request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
           let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
            profile = self.profileFromJson(json: responseString!);
            
            print("responseString = \(responseString)")
            semaphore.signal();
        }
        task.resume()
        semaphore.wait(timeout: .distantFuture);
        
        
        return profile;
        
    }
    //get lists for user 
    
    //get friends list for profile
    func getFriends(profileI:Profile)->[Profile]{
       // get list of freinds but only id image and names
        let semaphore = DispatchSemaphore(value: 0);
        var profile = [Profile]();
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointProfile
        url=url+self.getFriends;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "input="+profileI.id
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
           let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            profile = self.profileArrayFromString(string: responseString!)
            
            
            print("responseString = \(responseString)")
            semaphore.signal();
        }
        task.resume()
        semaphore.wait(timeout: .distantFuture);
        return profile;
    }
    
    //get events list for profile
    func getEvents(profile:Profile)->[Event]{
        // get list of events but only id image and names
        let semaphore = DispatchSemaphore(value: 0);
        var event = [Event]();
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointProfile
        url=url+self.getEvents;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "input="+profile.id
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
           let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
            event = self.eventsArrayFromString(string: responseString!)
            
            print("responseString = \(responseString)")
            semaphore.signal();
        }
        task.resume()
        semaphore.wait(timeout: .distantFuture);
        return event;
    }
    //get groups list for profile
    func getGroups(profile:Profile)->[Group]{
        // get list of groups but only id image and names
        let semaphore = DispatchSemaphore(value: 0);
        var group = [Group]();
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointProfile
        url=url+self.getGroups;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "input="+profile.id
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
           let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
            group = self.groupArrayFromString(string: responseString!)
            
            print("responseString = \(responseString)")
        semaphore.signal();
        }
        task.resume()
         semaphore.wait(timeout: .distantFuture);
        return group;
    }
    
    //get lists for group 
    
    //get members list for group
    func getMembers(group:Group)->[Profile]{
        let semaphore = DispatchSemaphore(value: 0);
        // get list of members but only id image and names
        var profile = [Profile]();
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointProfile
        url=url+self.getMembers;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "input="+group.id
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
           let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
            profile = self.profileArrayFromString(string: responseString!)
            
            print("responseString = \(responseString)")
            semaphore.signal();
        }
        task.resume()
         semaphore.wait(timeout: .distantFuture);
        return profile;
    }
    
    //get events list for profile
    func getEventsForGroup(group:Group)->[Event]{
        // get list of events but only id image and names
        let semaphore = DispatchSemaphore(value: 0);
        var event = [Event]();
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointProfile
        url=url+self.getEventsForGroup;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "input="+group.id
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
           let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
            event = self.eventsArrayFromString(string: responseString!)
            
            print("responseString = \(responseString)")
        semaphore.signal();
        }
        task.resume()
        semaphore.wait(timeout: .distantFuture);
        return event;
    }
    
    //list for events 
    //get going list for group
    func getGoing(event:Event)->[Profile]{
        // get list of people going but only id image and names
        let semaphore = DispatchSemaphore(value: 0);
        var profile = [Profile]();
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointProfile
        url=url+self.getGoing;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "input="+event.id
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
           let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
            profile = self.profileArrayFromString(string: responseString!)
            
            print("responseString = \(responseString)")
        semaphore.signal();
        }
        task.resume()
        semaphore.wait(timeout: .distantFuture);
        return profile;
    }
    
    //get friends in common and groups in common for random profile
    func getFriendsInCommon(profileI:Profile)->[Profile]{
        let semaphore = DispatchSemaphore(value: 0);
        var profile = [Profile]();
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointProfile
        url=url+self.getFriendsInCommon;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "profile1="+myProfile.id+"&profile2="+profileI.id
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                
            }
            
           let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
            profile = self.profileArrayFromString(string: responseString!)
            
            print("responseString = \(responseString)")
             semaphore.signal();
        }
        task.resume()
         semaphore.wait(timeout: .distantFuture);
        return profile;
    }
    func getGroupsInCommon(profileI:Profile)->[Group]{
        let semaphore = DispatchSemaphore(value: 0);
        var group = [Group]();
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointProfile
        url=url+self.getGroupsInCommon;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "profile1="+myProfile.id+"&profile2="+profileI.id
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
           let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
            group = self.groupArrayFromString(string: responseString!)
            
            print("responseString = \(responseString)")
            semaphore.signal();
        }
task.resume()
         semaphore.wait(timeout: .distantFuture);
        return group;
    }
    //search results 
    
    //search profile
    func findProfile(nameOne:String,name2:String)->[Profile]{
        //search database for account & profile  with those names return matching or nothing
        let semaphore = DispatchSemaphore(value: 0);
        var profile = [Profile]();
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointProfile
        url=url+self.findProfiles;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "name1="+nameOne+"&name2="+name2
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
           let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
            profile = self.profileArrayFromString(string: responseString!)
            
            print("responseString = \(responseString)")
            semaphore.signal();
        }
        task.resume()
        semaphore.wait(timeout: .distantFuture);
        return profile;
    }
    //search group
    func findGroup(name:String)->[Group]{
        //search database for group  with that names return matching or nothing
        let semaphore = DispatchSemaphore(value: 0);
        var group = [Group]();
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointProfile
        url=url+self.findGroups;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "name="+name
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
           let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
            group = self.groupArrayFromString(string: responseString!)
            
            print("responseString = \(responseString)")
            semaphore.signal();
        }
        task.resume()
        semaphore.wait(timeout: .distantFuture);
        return group;
    }
    //search event
    func findEvent(name:String, location:String)->[Event]{
        //search database for event  with that names and location return matching or nothing
        let semaphore = DispatchSemaphore(value: 0);
        var event = [Event]();
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointProfile
        url=url+self.getGoing;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "name="+name+"&location="+location
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
           let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
            event = self.eventsArrayFromString(string: responseString!)
            
            print("responseString = \(responseString)")
            semaphore.signal();
        }
        task.resume()
        semaphore.wait(timeout: .distantFuture);
        return event;
    }
    
    
    
    //make an account (and profile)
    
    func createAccount(account:Account) -> String {
        let semaphore = DispatchSemaphore(value: 0);
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointAccount
        url=url+signup;
        print(accountToJson(account: account))
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "input="+accountToJson(account: account)
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        var responseS = "true"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
           let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            print("responseString = \(responseString)")
            if(responseString == "false"){
                responseS="false"
            }
            var profile = self.profileFromJson(json: responseString!);
            self.myProfile=profile;
            semaphore.signal();
            
        }
        
        task.resume()
        //fakeProfile();
        semaphore.wait(timeout: .distantFuture);
        return responseS;
    }
    
    //conversation methods
    func getConversation(userTwoId:String) -> [Message]{
        let semaphore = DispatchSemaphore(value: 0);
        var mm = [Message]();
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointProfile
        url=url+self.getConversation;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "profile1="+myProfile.id+"&profile2="+userTwoId
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
           let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
            mm = self.messageArrayFromString(string: responseString!)
            
            print("responseString = \(responseString)")
            semaphore.signal();
        }
        task.resume()
        semaphore.wait(timeout: .distantFuture);
        return mm;
    }
    
    
    
    
    func sendMessage(message:Message){
        //send message to server as Json
        let semaphore = DispatchSemaphore(value: 0);
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointProfile
        url=url+self.sendMessage;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "input="+messageToJson(message: message)
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
           let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
            
            
            print("responseString = \(responseString)")
            semaphore.signal();
        }
        task.resume()
        semaphore.wait(timeout: .distantFuture);
    }
    
    func getConversationMembers()->[Profile]{
        let semaphore = DispatchSemaphore(value: 0);
        var list =  [Profile]();
        //get all profiles who have conversations with this member, name, image, id
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointProfile
        url=url+self.getConversationsForProfile;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "input="+myProfile.id
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
           let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
            list = self.profileArrayFromString(string: responseString!)
            
            print("responseString = \(responseString)")
        
        semaphore.signal();
        }
        task.resume()
        semaphore.wait(timeout: .distantFuture);
        return list;
    }
    
    //fake data
    
    func fakeProfile(){
        var f1 = Profile(friend: [],event: [],group: [],notification: []);
        f1.names = "Joe and Lisa";
        f1.relationship = "dating";
        f1.location = "Ottawa";
        f1.friends.append(myProfile);
        
        
        var f2 = Profile(friend: [],event: [],group: [],notification: []);
        f2.names = "Tom and Jerry";
        f2.relationship = "friends";
        f2.location = "Ottawa";
        f2.friends.append(myProfile);
        
        
        var e1 = Event();
        e1.date = "may 4 2016";
        e1.time = "4pm";
        e1.location = "the mall";
        e1.name = "Shopping";
        e1.peopleGoing?.append(f1);
        
        var e2 = Event();
        e2.date = "may 14 2016";
        e2.time = "4:20pm";
        e2.location = "work";
        e2.name = "meeting";
        e2.peopleGoing?.append(f1);
        e2.peopleGoing?.append(f2);
        
        var g1 = Group();
        g1.name="walking";
        g1.summary="a group for walking people";
        g1.events?.append(e1);
        g1.members?.append(f1);
        
        myProfile.names="Kelly and Alex";
        myProfile.location="Ottawa";
        myProfile.relationship="dating";
        myProfile.friends.append(f1);
        myProfile.friends.append(f2);
        myProfile.events.append(e1);
        myProfile.events.append(e2);
        myProfile.groups.append(g1);
        myProfile.profileImage="1"
        f1.profileImage="2"
        f2.profileImage="3"
        e1.image="4"
        e2.image="3"
        
        f1.groups.append(g1);
        f2.events.append(e2);
        f1.events.append(e1);
        f1.events.append(e2);
        
        
        myProfile.summary = "hello this is a sample profile for people to wwite a description in.";
        f1.summary = "hello this is another sample profile for people to wwite a description in.";
        f2.summary = "hello this is a poor sample profile for people to wwite a description in.";
        
    }
    func httpGet(_ request: URLRequest!, callback: @escaping (String, String?) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            if error != nil {
                callback("", error!.localizedDescription)
            } else {
                let result = NSString(data: data!, encoding:
                    String.Encoding.ascii.rawValue)!
                callback(result as String, nil)
            }
        })
        task.resume()
    }
    
    
    //for http post with json figure it out!
    func sendPost(){
        let json = [ "title":"ABC" , "dict": "thing"]
        do {
            
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            
            // create post request
            let url = NSURL(string: "https://...appspot.com/_ah/api/activityendpoint/v1/activity")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            
            // insert json data to the request
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            //print(postString);
        request.httpBody = jsonData
            
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
                if error != nil{
                    print("Error -> \(error)")
                    return
                }
                
                do {
                    let result = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]
                    
                    print("Result -> \(result)")
                    
                } catch {
                    print("Error -> \(error)")
                }
            }
            
            task.resume()
            
            
            
            
        } catch {
            print(error)
        }
    }
    
    //convert objects to Json
    func profileToJson(profile: Profile)->String{
        return Serialize.toJSON(obj: profile);
    }
    func eventToJson(event: Event)->String{
        return Serialize.toJSON(obj: event);
    }
    func groupToJson(group: Group)->String{
        return Serialize.toJSON(obj: group);
    }
    func accountToJson(account: Account)->String{
        return Serialize.toJSON(obj: account);
    }
    func notificationToJson(notification: Notification)->String{
        return Serialize.toJSON(obj: notification);
    }
    func messageToJson(message: Message)->String{
        return Serialize.toJSON(obj: message);
    }
    
    //convert objects from Json
    func profileFromJson(json: String)->Profile{
        return Profile(JSONString: json)
    }
    func eventFromJson(json: String)->Event{
        return Event.init(JSONString: json)
    }
    func groupFromJson(json: String)->Group{
        return Group(JSONString: json)
    }
    func accountFromJson(json: String)->Account{
        return Account(JSONString: json)
    }
    func notificationFromJson(json: String)->Notification{
        return Notification(JSONString: json)
    }
    func messageFromJson(json: String)->Message{
        return Message(JSONString: json)
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
    
    func groupArrayFromString(string:String)->[Group]{
        if(string == "[]"){
            return [];
        }
        if(string == ""){
            return [];
        }
        let fullArr : [String] = string.components(separatedBy: "{")
        var list = [Group]();
        
        for two in (1..<fullArr.count){
            var one = fullArr[two]
            one.remove(at: one.index(before: one.endIndex ))
            one.remove(at: one.index(before: one.endIndex ))
            one="{"+one+"}"
            list.append(Group(JSONString: one))
            
            
        }
        return list;
    }
    func profileArrayFromString(string:String)->[Profile]{
        if(string == "[]"){
            return [];
        }
        if(string == ""){
            return [];
        }
        let fullArr : [String] = string.components(separatedBy: "{")
        var list = [Profile]();
        
        for two in (1..<fullArr.count){
            var one = fullArr[two]
            one.remove(at: one.index(before: one.endIndex ))
            one.remove(at: one.index(before: one.endIndex ))
            one="{"+one+"}"
            list.append(Profile(JSONString: one))
            
            
        }
        return list;
    }
    func eventsArrayFromString(string:String)->[Event]{
        if(string == "[]"){
            return [];
        }
        if(string == ""){
            return [];
        }
        let fullArr : [String] = string.components(separatedBy: "{")
        var list = [Event]();
        
        for two in (1..<fullArr.count){
            var one = fullArr[two]
            one.remove(at: one.index(before: one.endIndex ))
            one.remove(at: one.index(before: one.endIndex ))
            one="{"+one+"}"
            list.append(Event(JSONString: one))
            
            
        }
        return list;
    }
    func notificationArrayFromString(string:String)->[Notification]{
        if(string == "[]"){
            return [];
        }
        if(string == ""){
            return [];
        }
        let fullArr : [String] = string.components(separatedBy: "{")
        var list = [Notification]();
        
        for two in (1..<fullArr.count){
            var one = fullArr[two]
            one.remove(at: one.index(before: one.endIndex ))
            one.remove(at: one.index(before: one.endIndex ))
            one="{"+one+"}"
            list.append(Notification(JSONString: one))
            
            
        }
        return list;
    }
    func messageArrayFromString(string:String)->[Message]{
        if(string == "[]"){
            return [];
        }
        if(string == ""){
            return [];
        }
        let fullArr : [String] = string.components(separatedBy: "{")
        var list = [Message]();
        
        for two in (1..<fullArr.count){
            var one = fullArr[two]
            one.remove(at: one.index(before: one.endIndex ))
            one.remove(at: one.index(before: one.endIndex ))
            one="{"+one+"}"
            list.append(Message(JSONString: one))
            
            
        }
        return list;
    }
    
    
}
