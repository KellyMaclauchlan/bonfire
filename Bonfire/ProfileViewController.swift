//
//  profileViewController.swift
//  Bonfire
//
//  Created by Kelly Maclauchlan on 2016-10-26.
//  Copyright © 2016 Kelly Maclauchlan. All rights reserved.
//

import Foundation
import UIKit
class ProfileViewController: UIViewController {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var summary: UILabel!
    
    
    @IBOutlet weak var chat: UIButton!
    @IBOutlet weak var edit: UIButton!
    @IBOutlet weak var friend: UIButton!
    @IBOutlet weak var group: UIButton!
    @IBOutlet weak var event: UIButton!
    
    @IBOutlet weak var table: UITableView!
    var tablecontroller: ProfileTableViewController!
    
    @IBOutlet weak var createButton: UIButton!
    var connect:ServerConnection!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tablecontroller = ProfileTableViewController();
        tablecontroller.type=1;
        table.dataSource = tablecontroller;
        table.delegate = tablecontroller;
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
        tablecontroller.type=1;
    }
    @IBAction func butonClickedGroups(sender: AnyObject) {
        tablecontroller.type=3;
    }
    @IBAction func butonClickedEvents(sender: AnyObject) {
        tablecontroller.type=2;
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "profileOutFromTable") {
            var svc = segue.destination as! FirstViewController;
            svc.profile=connect.myProfile;
            svc.connect = connect;
            
        }
        
        
    }
    
    
    
}
