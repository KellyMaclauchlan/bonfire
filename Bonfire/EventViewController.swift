//
//  EventViewController.swift
//  Bonfire
//
//  Created by Kelly Maclauchlan on 2016-11-01.
//  Copyright © 2016 Kelly Maclauchlan. All rights reserved.
//

import Foundation
import UIKit
class EventViewController: UIViewController {
    
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var edit: UIButton!
    
    @IBOutlet weak var summary: UITextView!
    
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var table: UITableView!
    
    var tablecontroller: EventTableViewController!
    var connect:ServerConnection!
    var event:Event!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tablecontroller = EventTableViewController();
        
        
        table.dataSource = tablecontroller;
        table.delegate = tablecontroller;
        
        managePage();
        
        
        
    }
    
    func managePage(){
        event.peopleGoing=connect.getGoing(event: event)
        summary.text = event.summary;
        tablecontroller.members = event.peopleGoing!;
        date.text=event.date;
        time.text=event.time;
        location.text=event.location;        
        name.text=event.name
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
    
    
   
    
    @IBAction func attendClicked(_ sender: Any) {
        connect.joinEvent(event:event);
    }
    
    @IBAction func inviteClick(_ sender: Any) {
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "eventToProfile") {
            
            var svc = segue.destination as! FirstViewController;
            
            svc.connect = connect;
            
            svc.profile=self.event.peopleGoing?[(table.indexPathForSelectedRow?.row)!];
            
        }
        if (segue.identifier == "eventToEdit") {
            
            var svc = segue.destination as! EditEventViewController;
            
            svc.connect = connect;
            
            svc.event=event;
            
        }else  if (segue.identifier == "eventToMenu") {
            
            var svc = segue.destination as! MenuViewController;
            
            svc.connect = connect;
            
        }

    }
    
    
}
