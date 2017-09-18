//
//  SignUpViewController.swift
//  Bonfire
//
//  Created by Kelly Maclauchlan on 2016-10-26.
//  Copyright © 2016 Kelly Maclauchlan. All rights reserved.
//

import UIKit
class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var emailView: UITextField!
    
    @IBOutlet weak var nameView: UITextField!
    
    @IBOutlet weak var email2View: UITextField!
    
    @IBOutlet weak var name2VIew: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    @IBOutlet weak var signup: UIButton!
    
    var connect:ServerConnection!
    override func viewDidLoad() {
        super.viewDidLoad()
        setDoneOnKeyboard()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "signupToEditProfile") {
            var email = emailView.text;
            var email2 = email2View.text;
            var name = nameView.text;
            var name2 = name2VIew.text;
            var password = self.password.text;
            
             var account = Account();
            account.emailOne = email!;
            account.emailTwo = email2!;
            account.nameOne = name!;
            account.nameTwo = name2!;
            account.password = password!;
            var response = connect.createAccount(account: account)
            if(response=="true"){
                
            
            var svc = segue.destination as! EditProfileViewController;
            svc.profile=connect.myProfile;
            svc.connect = connect;
            }
            
        }
 
        
    }
    func setDoneOnKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        keyboardToolbar.items = [flexBarButton, doneBarButton]

        self.emailView.inputAccessoryView = keyboardToolbar
        self.password.inputAccessoryView = keyboardToolbar
        self.email2View.inputAccessoryView = keyboardToolbar
        self.nameView.inputAccessoryView = keyboardToolbar
        self.name2VIew.inputAccessoryView = keyboardToolbar

       
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
        
    }

   
        
        
    
 
    
}
