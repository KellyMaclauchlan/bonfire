//
//  ProfileResutsViewController.swift
//  Bonfire
//
//  Created by Kelly Maclauchlan on 2016-11-25.
//  Copyright © 2016 Kelly Maclauchlan. All rights reserved.
//

import UIKit

class ProfileResutsViewController: UIViewController {
    
    
    @IBOutlet weak var table: UITableView!
    
    var tablecontroller: ResultProfileTableViewController!
    var connect:ServerConnection!
    var results = [Profile]();
    override func viewDidLoad() {
        super.viewDidLoad()
        tablecontroller = ResultProfileTableViewController();
        
        tablecontroller.results = results;
        table.dataSource = tablecontroller;
        table.delegate = tablecontroller;
        table.reloadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "profileSearchToProfile") {
            
            var svc = segue.destination as! FirstViewController;
            
            svc.connect = connect;
            
            svc.profile=results[(table.indexPathForSelectedRow?.row)!];
            var j=9;
        }else  if (segue.identifier == "profileSearchToMenu") {
            
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
