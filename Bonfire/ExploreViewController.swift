//
//  ExploreViewController.swift
//  Bonfire
//
//  Created by Kelly Maclauchlan on 2016-11-25.
//  Copyright © 2016 Kelly Maclauchlan. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {
    //need to add table and second table like in groups screen
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var relation: UILabel!
    @IBOutlet weak var summary: UITextView!
    @IBOutlet weak var names: UILabel!
    
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var table2: UITableView!
    
    var friends = [Profile]();
    var groups = [Group]();
    var tablecontroller: ExploreTableViewController!
    var tablecontroller2: ExploreTableViewController!
    var exploring = [Profile]();
    var index = 0;
    var currentProfile:Profile?;
     var connect:ServerConnection!
    override func viewDidLoad() {
        super.viewDidLoad()
        tablecontroller = ExploreTableViewController();
        
        tablecontroller.friends = friends;
        tablecontroller.type=1;
        table.dataSource = tablecontroller;
        table.delegate = tablecontroller;
        table.reloadData()
        
        tablecontroller2 = ExploreTableViewController();
        tablecontroller2.type=2;
        tablecontroller2.groups = groups;
        table2.dataSource = tablecontroller2;
        table2.delegate = tablecontroller2;
        table2.isHidden=true;
        var profile=connect.getRandomProfile();
        exploring.append(profile)
        //exploring.append(connect.getRandomProfile());
        
        currentProfile=exploring[index]
    
        loadProfile()
    
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loadProfile(){
        
        //friends = connect.getFriendsInCommon(profileI: currentProfile!);
       // groups = connect.getGroupsInCommon(profileI: currentProfile!);
        tablecontroller2.groups=groups;
        table2.reloadData();
        tablecontroller.friends=friends;
        table.reloadData();
        summary.text = "Summary"+(currentProfile?.summary)!;
        names.text=currentProfile?.names;
        relation.text=currentProfile?.relationship;
        
    }
    
    @IBAction func backOnce(_ sender: Any) {
        if(index != 0){
            index = index-1;
            currentProfile=exploring[index]
        }
        loadProfile()
        
    }
    @IBAction func forwardOnce(_ sender: Any) {
        if(index < exploring.count - 1){
            index = index+1;
            currentProfile=exploring[index]
        }else{
            index=index+1;
            exploring.append( connect.getRandomProfile());
            currentProfile=exploring[index]
        }
        loadProfile()
    }
    @IBAction func addFriend(_ sender: Any) {
        connect.addFriend(profile: currentProfile!)
    }
    @IBAction func friendsInCommon(_ sender: Any) {
        //show that table and list of what's there
        table2.isHidden=true;
        table.isHidden=false;
        table.reloadData();
    }
    @IBAction func groupsInCommon(_ sender: Any) {
        //show that table and list of what's there
        table.isHidden=true;
        table2.isHidden=false;
        table2.reloadData();
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "exploreToMenu") {
            
            var svc = segue.destination as! MenuViewController;
            
            svc.connect = connect;
            
        }else  if (segue.identifier == "exploreToMenu") {
            
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
