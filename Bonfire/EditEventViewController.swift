//
//  EditEventViewController.swift
//  Bonfire
//
//  Created by Kelly Maclauchlan on 2016-11-26.
//  Copyright © 2016 Kelly Maclauchlan. All rights reserved.
//

import UIKit

class EditEventViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var dateAndTime: UITextField!
    
    @IBOutlet weak var image: UITextField!
    @IBOutlet weak var summary: UITextView!
    
    @IBOutlet weak var groupName: UITextField!
    @IBOutlet weak var time: UITextField!
    @IBOutlet weak var location: UITextField!
    
    var connect:ServerConnection!
    var event = Event();
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text=event.name
        dateAndTime.text=event.date
        time.text=event.time;
        image.text=event.image
        location.text=event.location
        groupName.text=event.groupName
        setDoneOnKeyboard()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editToEvent") {
            
            var svc = segue.destination as! EventViewController;
            
            svc.connect = connect;
            event.name=name.text!;
            event.date=dateAndTime.text!
            event.time=time.text!
            event.image=image.text!
            event.location=location.text!;
            event.groupName=groupName.text!;
            if(event.id==""){
                event=connect.createEvent(event: event);
            }
            else{
               event = connect.editEvent(event: event);
            }
            
            svc.event=event;
            
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
        self.name.inputAccessoryView = keyboardToolbar
        self.summary.inputAccessoryView = keyboardToolbar
        self.image.inputAccessoryView = keyboardToolbar
        self.location.inputAccessoryView = keyboardToolbar
        self.dateAndTime.inputAccessoryView=keyboardToolbar
        self.time.inputAccessoryView=keyboardToolbar
        self.groupName.inputAccessoryView=keyboardToolbar
        
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
        
    }

}
