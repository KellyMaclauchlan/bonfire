//
//  SearchViewController.swift
//  Bonfire
//
//  Created by Kelly Maclauchlan on 2016-11-25.
//  Copyright © 2016 Kelly Maclauchlan. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    
    @IBOutlet weak var pairButton: UIButton!
    
    @IBOutlet weak var groupButton: UIButton!
    @IBOutlet weak var eventButton: UIButton!
    
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var textFeild1: UITextField!
    @IBOutlet weak var textFeild2: UITextField!
    
    @IBOutlet weak var searchProfile: UIButton!
    @IBOutlet weak var searchGroup: UIButton!
    @IBOutlet weak var searchEvent: UIButton!
    
    var resultsEvent = [Event]();
    var resultsGroup = [Group]();
    var resultsProfile = [Profile]();
    
    var connect:ServerConnection!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFeild1.isHidden=true;
        textFeild2.isHidden=true;
        label1.isHidden=true;
        label2.isHidden=true;
        searchProfile.isHidden=true;
        searchGroup.isHidden=true;
        searchEvent.isHidden=true;
        setDoneOnKeyboard()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pairClicked(_ sender: Any) {
        label1.text="Name One:";
        label2.text="Name Two:";
        textFeild1.isHidden=false;
        textFeild2.isHidden=false;
        label1.isHidden=false;
        label2.isHidden=false;
        searchProfile.isHidden=false;
        searchGroup.isHidden=true;
        searchEvent.isHidden=true;
        
        
    }
    
    @IBAction func groupClicked(_ sender: Any) {
        label1.text="Name:";
        textFeild1.isHidden=false;
        textFeild2.isHidden=true;
        label1.isHidden=false;
        label2.isHidden=true;
        searchProfile.isHidden=true;
        searchGroup.isHidden=false;
        searchEvent.isHidden=true;
    }
    @IBAction func eventClicked(_ sender: Any) {
        label1.text="Name:";
        label2.text="Location:";
        textFeild1.isHidden=false;
        textFeild2.isHidden=false;
        label1.isHidden=false;
        label2.isHidden=false;
        searchProfile.isHidden=true;
        searchGroup.isHidden=true;
        searchEvent.isHidden=false;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "searchToProfiles") {
            
            var svc = segue.destination as! ProfileResutsViewController;
            
            svc.connect = connect;
           
            
            svc.results=connect.findProfile(nameOne: textFeild1.text!, name2: textFeild2.text!);
            var j=9;
        }
        if (segue.identifier == "searchToGroups") {
            
            var svc = segue.destination as! GroupResultsViewController;
            
            svc.connect = connect;
            
            
            svc.results=connect.findGroup(name: textFeild1.text!);
            var j=9;
        }
        if (segue.identifier == "searchToEvents") {
            
            var svc = segue.destination as! EventResultsViewController;
            
            svc.connect = connect;
            
            
            svc.results=connect.findEvent(name: textFeild1.text!, location: textFeild2.text!);
            var j=9;
        }else  if (segue.identifier == "searchToMenu") {
            
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
    func setDoneOnKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        self.textFeild1.inputAccessoryView = keyboardToolbar
        self.textFeild2.inputAccessoryView = keyboardToolbar
        
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
        
    }
}
