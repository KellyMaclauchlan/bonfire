//
//  FirstViewController.swift
//  Bonfire
//
//  Created by Kelly Maclauchlan on 2016-09-30.
//  Copyright © 2016 Kelly Maclauchlan. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    
    
    @IBOutlet weak var names: UILabel!
    @IBOutlet weak var relationship: UILabel!
    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var edit: UIButton!
    @IBOutlet weak var summary: UITextView!
    var tablecontroller: ProfileTableViewController!
    var tablecontroller2: ProfileTableViewController!
    var tablecontroller3: ProfileTableViewController!
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var eventTable: UITableView!
    @IBOutlet weak var groupTable: UITableView!
    
    
    
    var connect:ServerConnection!
    var profile:Profile!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tablecontroller = ProfileTableViewController();
        tablecontroller2 = ProfileTableViewController();
        tablecontroller3 = ProfileTableViewController();
        
        table.dataSource = tablecontroller;
        table.delegate = tablecontroller;
        
        eventTable.dataSource = tablecontroller2;
        eventTable.delegate = tablecontroller2;
        
        groupTable.dataSource = tablecontroller3;
        groupTable.delegate = tablecontroller3;
        
        
        managePage();
        
        
    }
    func managePage(){
        profile.groups = connect.getGroups(profile: profile)
        profile.events = connect.getEvents(profile: profile)
        profile.friends = connect.getFriends(profileI: profile)
        summary.text = profile.summary;
        names.text = profile.names;
        relationship.text = profile.relationship;
        location.text=profile.location;
        imageV.image=UIImage(named: profile.profileImage)
        tablecontroller3.groups = profile.groups;
        tablecontroller.friends = profile.friends;
        tablecontroller2.events = profile.events;
        tablecontroller.type=1;
        tablecontroller2.type=2;
        tablecontroller3.type=3;
        tablecontroller.connect=connect;
        tablecontroller2.connect=connect;
        tablecontroller3.connect=connect;
        table.reloadData();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func butonClickedEdit(sender: AnyObject) {
        if(edit.imageView?.image?.isEqual(#imageLiteral(resourceName: "glyphicons-31-pencil")))!{
            //edit
        }else{
            //flag
        }
    }
    @IBAction func butonClickedChat(sender: AnyObject) {
        
    }
    @IBAction func butonClickedFriends(sender: AnyObject) {
        //tablecontroller.type=1;
        eventTable.isHidden=true;
        table.isHidden=false;
        groupTable.isHidden=true;
        table.reloadData();
    }
    @IBAction func butonClickedGroups(sender: AnyObject) {
        eventTable.isHidden=true;
        table.isHidden=true;
        groupTable.isHidden=false;
        groupTable.reloadData();
    }
    @IBAction func butonClickedEvents(sender: AnyObject) {
        eventTable.isHidden=false;
        table.isHidden=true;
        groupTable.isHidden=true;
        eventTable.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "profileOutFromTable") {
            
            var svc = segue.destination as! FirstViewController;
            
            svc.connect = connect;
            
            svc.profile=self.profile.friends[(table.indexPathForSelectedRow?.row)!];
            var j=9;
        }else if (segue.identifier == "eventOutFromTable") {
            
            var svc = segue.destination as! EventViewController;
            
            svc.connect = connect;
            
            svc.event=self.profile.events[(eventTable.indexPathForSelectedRow?.row)!];
        }else if (segue.identifier == "groupOutFromTable") {
            
            var svc = segue.destination as! GroupViewController;
            
            svc.connect = connect;
            
            svc.group=self.profile.groups[(groupTable.indexPathForSelectedRow?.row)!];
        }else  if (segue.identifier == "profileToEdit") {
            
            var svc = segue.destination as! EditProfileViewController;
            
            svc.connect = connect;
            
            svc.profile=profile;
           
        }else  if (segue.identifier == "profileToChat") {
            
            var svc = segue.destination as! ChatViewController;
            
            svc.connect = connect;
            
            
            
        }else  if (segue.identifier == "profileToMenu") {
            
            var svc = segue.destination as! MenuViewController;
            
            svc.connect = connect;
            
        }

    }



}

