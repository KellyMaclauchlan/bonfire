//
//  ConversationViewController.swift
//  Bonfire
//
//  Created by Kelly Maclauchlan on 2016-11-24.
//  Copyright © 2016 Kelly Maclauchlan. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController {
    var connect:ServerConnection!
    var otherUser:Profile!
    var text:String!
    var conversation = [Message]();
    
    @IBOutlet weak var textFeild: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        updateconversationText()
        dismissKeyboard()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func updateconversationText(){
        conversation = connect.getConversation(userTwoId: otherUser.id);
        for message in conversation {
            text = text+message.toString()+"\n";
        }
        textView.text=text;
        textView.isEditable=false;
        
        //put text in text view
    }
    


    @IBAction func sendMessage(_ sender: Any) {
        var newMessage = Message(from: connect.myProfile, to: otherUser);
        newMessage.text=textFeild.text!;
        connect.sendMessage(message: newMessage);
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "conversationToChat") {
            
            var svc = segue.destination as! ChatViewController;
            
            svc.connect = connect;
           
            
        }else  if (segue.identifier == "conversationToMenu") {
            
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
        self.textFeild.inputAccessoryView = keyboardToolbar
        
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
        
    }


}
