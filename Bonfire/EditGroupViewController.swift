//
//  EditGroupViewController.swift
//  Bonfire
//
//  Created by Kelly Maclauchlan on 2016-11-26.
//  Copyright © 2016 Kelly Maclauchlan. All rights reserved.
//

import UIKit

class EditGroupViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var summary: UITextView!
    var group=Group()
     var connect:ServerConnection!
    override func viewDidLoad() {
        super.viewDidLoad()
        summary.text=group.summary;
        name.text=group.name;
        setDoneOnKeyboard()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editToGroup") {
            
            var svc = segue.destination as! GroupViewController;
            group.name=name.text!;
            group.summary=summary.text;
            svc.connect = connect;
            if(group.id==""){
                group=connect.createGroup(group: group);
            }else{
                connect.editGroup(group: group);
            }
            svc.group=group;
            
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
        
        self.summary.inputAccessoryView = keyboardToolbar
        
        self.name.inputAccessoryView=keyboardToolbar
        
        
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
        
    }
}
