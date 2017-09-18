//
//  GroupsViewController.swift
//  Bonfire
//
//  Created by Kelly Maclauchlan on 2016-10-26.
//  Copyright © 2016 Kelly Maclauchlan. All rights reserved.
//

import Foundation
import UIKit
class GroupViewController: UIViewController {
    
    
    @IBOutlet weak var names: UILabel!
    
    @IBOutlet weak var summary: UILabel!
    
    var tablecontroller: GroupTableViewController!
    var tablecontroller2: GroupTableViewController!
     @IBOutlet weak var edit: UIButton!
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var eventTable: UITableView!
    
    var connect:ServerConnection!
    var group:Group!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tablecontroller = GroupTableViewController();
        tablecontroller2 = GroupTableViewController();
        
        table.dataSource = tablecontroller;
        table.delegate = tablecontroller;
        
        eventTable.dataSource = tablecontroller2;
        eventTable.delegate = tablecontroller2;
        if(group.summary == ""){
            group=connect.getFullGroup(group: group)
        }
        managePage();
        
        
    }
   
    func managePage(){
        group.members = connect.getMembers(group: group)
        group.events = connect.getEventsForGroup(group: group)
        summary.text = group.summary;
        names.text = group.name;
        tablecontroller.members = group.members!;
        tablecontroller2.events = group.events!;
        tablecontroller.type=1;
        tablecontroller2.type=2;
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
   
    @IBAction func joinClicked(_ sender: Any) {
        group.join(person: connect.myProfile);
        connect.joinGroup(group: group)
        //update connect to update database
    }
    
    @IBAction func membersCLicked(_ sender: Any) {
        table.isHidden=false;
        eventTable.isHidden=true;
        table.reloadData();
    }
    @IBAction func eventsClicked(_ sender: Any) {
        table.isHidden=true;
        eventTable.isHidden=false;
        eventTable.reloadData();
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "groupToProfile") {
            
            var svc = segue.destination as! FirstViewController;
            
            svc.connect = connect;
            
            svc.profile=self.group.members?[(table.indexPathForSelectedRow?.row)!];
            var j=9;
        }else if (segue.identifier == "groupToEvent") {
            
            var svc = segue.destination as! EventViewController;
            
            svc.connect = connect;
            
            svc.event=self.group.events?[(eventTable.indexPathForSelectedRow?.row)!];
        }else if (segue.identifier == "groupToEdit") {
            
            var svc = segue.destination as! EditGroupViewController;
            
            svc.connect = connect;
            
            svc.group=group;
        }else  if (segue.identifier == "groupToMenu") {
            
            var svc = segue.destination as! MenuViewController;
            
            svc.connect = connect;
            
        }
        
    }
    
    
}
