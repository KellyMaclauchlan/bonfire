//
//  ChatViewController.swift
//  Bonfire
//
//  Created by Kelly Maclauchlan on 2016-11-24.
//  Copyright © 2016 Kelly Maclauchlan. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    var tablecontroller: ChatTableViewController!
    var connect:ServerConnection!
    var connections:[Profile]!
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        connections=connect.getConversationMembers();
        table.dataSource = tablecontroller;
        table.delegate = tablecontroller;
        table.reloadData();
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "chatToConverstion") {
            
            var svc = segue.destination as! ConversationViewController;
            
            svc.connect = connect;
            
            svc.otherUser=self.connections?[(table.indexPathForSelectedRow?.row)!];
            
        }else  if (segue.identifier == "chatToMenu") {
            
            var svc = segue.destination as! MenuViewController;
            
            svc.connect = connect;
            
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
