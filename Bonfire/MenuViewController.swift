//
//  MenuViewController.swift
//  Bonfire
//
//  Created by Kelly Maclauchlan on 2016-11-25.
//  Copyright © 2016 Kelly Maclauchlan. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    var connect:ServerConnection!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "menuToProfile") {
            
            var svc = segue.destination as! FirstViewController;
            
            svc.connect = connect;
            
            svc.profile=connect.myProfile;
            
        }
        if (segue.identifier == "menuToChat") {
            
            var svc = segue.destination as! ChatViewController;
            
            svc.connect = connect;
            
            svc.connections=connect.getConversationMembers();
            
        }
        if (segue.identifier == "menuToNotification") {
            
            var svc = segue.destination as! NotificationViewController;
            
            svc.connect = connect;
            
            svc.notifications=connect.getNotifications();
            
        }
        if (segue.identifier == "menuToSearch") {
            
            var svc = segue.destination as! SearchViewController;
            
            svc.connect = connect;

            
        }
        if (segue.identifier == "menuToFindFreinds") {
            
            var svc = segue.destination as! ExploreViewController;
            svc.connect = connect;
            svc.connect = connect;
            
        }
        if (segue.identifier == "menuToCreateEvent") {
            //need to create
            
                
                var svc = segue.destination as! EditEventViewController;
                
                svc.connect = connect;
                svc.event.creatorId=connect.myProfile.id;
            
            
        }
        if (segue.identifier == "menuToMakeGroup") {
            //need to create
            var svc = segue.destination as! EditGroupViewController;
            
            svc.connect = connect;
            svc.group.creatorId=connect.myProfile.id;
            
            
        }
        if (segue.identifier == "menuToLogout") {
            
            var svc = segue.destination as! LoginViewController;
            
            svc.connect = connect;
            svc.connect.myProfile=Profile();  
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
