//
//  EditProfileViewController.swift
//  Bonfire
//
//  Created by Kelly Maclauchlan on 2016-11-26.
//  Copyright © 2016 Kelly Maclauchlan. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var relationship: UITextField!
    @IBOutlet weak var summary: UITextView!
    @IBOutlet weak var image: UITextField!
    
    @IBOutlet weak var location: UITextField!
    var profile=Profile();
    var connect:ServerConnection!
    override func viewDidLoad() {
        super.viewDidLoad()
        relationship.text=profile.relationship;
        summary.text=profile.summary;
        image.text=profile.profileImage
        location.text=profile.location
        setDoneOnKeyboard()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editToProfile") {
            
            var svc = segue.destination as! FirstViewController;
            
            svc.connect = connect;
            profile.relationship=relationship.text!;
            profile.summary=summary.text;
            profile.profileImage=image.text!;
            profile.location=location.text!
            profile = connect.editProfile(profile: profile);
            
            svc.profile=profile;
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
        self.relationship.inputAccessoryView = keyboardToolbar
        self.summary.inputAccessoryView = keyboardToolbar
        self.image.inputAccessoryView = keyboardToolbar
        self.location.inputAccessoryView = keyboardToolbar
        
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
        
    }

}
