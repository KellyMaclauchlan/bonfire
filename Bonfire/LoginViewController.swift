//
//  LoginViewController.swift
//  Bonfire
//
//  Created by Kelly Maclauchlan on 2016-10-26.
//  Copyright © 2016 Kelly Maclauchlan. All rights reserved.
//

import UIKit
class LoginViewController: UIViewController {

  
    @IBOutlet weak var passwordView: UITextField!
    @IBOutlet weak var emailView: UITextField!
    
    @IBOutlet var view1: UIView!
    
    var connect:ServerConnection!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        connect=ServerConnection();
        setDoneOnKeyboard();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "loginToProfile") {
            var svc = segue.destination as! FirstViewController;
            
            svc.connect = connect;
            svc.profile=connect.myProfile;
            
            
        }else if (segue.identifier == "SegueTest3") {
            var svc = segue.destination as! SignUpViewController;
            
            svc.connect = connect;
            
            //segue.perform();
        }
    }
    
    
    @IBAction func butonClickedLogin(sender: AnyObject) {
        //redirect to chat screen if user is that that person
        
        connect.login(email: emailView.text!, password: passwordView.text!);
        var segue = UIStoryboardSegue(identifier: "segueTest", source: self, destination: FirstViewController());
        self.prepare(for: segue, sender: self);
        
    }
    @IBAction func butonClickedSignup(sender: AnyObject) {
        //redirect to chat screen if user is that that person
       // connect.login(email: emailView.text!, password: passwordView.text!);
       /* var segue = UIStoryboardSegue(identifier: "segueTest3", source: self, destination: SignUpViewController());
        self.prepare(for: segue, sender: self);*/
        
    }
    func setDoneOnKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        self.passwordView.inputAccessoryView = keyboardToolbar
        self.emailView.inputAccessoryView = keyboardToolbar
        self.emailView.inputAccessoryView?.isHidden=false;
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
        self.emailView.resignFirstResponder();
        self.passwordView.resignFirstResponder();
    }
    
}
