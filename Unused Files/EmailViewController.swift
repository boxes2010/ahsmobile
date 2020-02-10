//
//  EmailViewController.swift
//  AHS
//
//  Created by Jason Zhao on 11/9/17.
//  Copyright © 2017 Jason Zhao. All rights reserved.
//

import UIKit
import MessageUI
class EmailViewController: UIViewController, MFMailComposeViewControllerDelegate, UITextViewDelegate, UITextFieldDelegate, UIScrollViewDelegate {
    
    @IBOutlet var HamburgerButton: UIButton!
    @IBOutlet var RequestLabel: UILabel!
    @IBOutlet var PriorLabel: UILabel!
    @IBOutlet var NameOrganization: UITextField!
    @IBOutlet var TypeTextField: UITextField!
    @IBOutlet var ThirdTextField: UITextField!
    @IBOutlet var DateTime: UIDatePicker!
    @IBOutlet var MessageView: UITextView!
    @IBOutlet var ScrollView: UIScrollView!
    @IBOutlet var PersonalEmailLAbel: UILabel!
    @IBOutlet var DateTimeLabel: UILabel!
    @IBOutlet var SubmitButton: UIButton!
    @IBOutlet var NameOrganizationLabel: UILabel!
    
    var dateFormatter = DateFormatter()
    var timeFormatter = DateFormatter()
    var name : String = ""
    var message : String = ""
    
    var marginConstant : CGFloat = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NameOrganization.returnKeyType = UIReturnKeyType.done
        MessageView.returnKeyType = UIReturnKeyType.done
        TypeTextField.returnKeyType = UIReturnKeyType.done
        ThirdTextField.returnKeyType = UIReturnKeyType.done
        NameOrganization.delegate = self
        MessageView.delegate = self
        TypeTextField.delegate = self
        ThirdTextField.delegate = self
        ScrollView.delegate = self

        self.makeMarginConstant()
        self.setWidthAndProperties()
        self.setupTextField()
        returning = true
        HamburgerButton.frame.origin.x = self.view.frame.size.width - 60.0
        ScrollView.contentSize.height = SubmitButton.frame.origin.y + SubmitButton.frame.size.height + 160.0
        // Do any additional setup after loading the view.
    }
    func makeMarginConstant(){
        self.marginConstant = self.view.frame.size.width * 0.04
    }
    
    func setupTextField(){
        NameOrganization.placeholder = "Individual Name and ID"
        TypeTextField.placeholder = "Relevant Topic (ie. Performing Arts)"
        ThirdTextField.placeholder = "Organization Name"
        MessageView.isScrollEnabled = false
    }
    
    func setWidthAndProperties(){
        
        TypeTextField.frame.size.width = self.view.frame.size.width - (2 * marginConstant)
        ThirdTextField.frame.size.width = self.view.frame.size.width - (2 * marginConstant)
        NameOrganization.frame.size.width = self.view.frame.size.width - (2 * marginConstant)
        MessageView.frame.size.width = self.view.frame.size.width - (2 * marginConstant)
        PriorLabel.frame.size.width = self.view.frame.size.width - (2 * marginConstant)
        
        RequestLabel.center.x = self.view.center.x
        PriorLabel.center.x = self.view.center.x
        NameOrganization.center.x = self.view.center.x
        TypeTextField.center.x = self.view.center.x
        ThirdTextField.center.x = self.view.center.x
        PersonalEmailLAbel.center.x = self.view.center.x
        DateTimeLabel.frame.origin.x = marginConstant
        MessageView.center.x = self.view.center.x
        SubmitButton.center.x = self.view.center.x
        
        MessageView.layer.borderWidth = 1.0
        MessageView.layer.cornerRadius = 4.0
        SubmitButton.layer.cornerRadius = 4.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n"){
            textView.resignFirstResponder()
        }
        return true
    }
    
    func setupMailView() -> MFMailComposeViewController {
        var mailController = MFMailComposeViewController()
        mailController.mailComposeDelegate = self
        mailController.setSubject("")
        mailController.setToRecipients(["hsappdev@students.ausd.net"])
        mailController.setMessageBody("", isHTML: false)
        
        return mailController
    }
    
    func cannotSendMail(){
        var alert = UIAlertController(title: "Error Sending Email", message: "Email cannot be sent from this device", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(dismiss)
        self.present(alert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        var mail = setupMailView()
        
        dateFormatter.dateFormat = " MM-dd-YYYY"
        timeFormatter.dateFormat = " HH:mm "
        name = NameOrganization.text!
        message = "Name / Organization: " + name + "\n Date to Send: " + dateFormatter.string(from: DateTime.date) + "\n Time to Send: " + timeFormatter.string(from: DateTime.date) + "\n Message: " + MessageView.text
        mail.setSubject(name)
        mail.setMessageBody(message, isHTML: false)
        
        if MFMailComposeViewController.canSendMail() {
            self.present(mail, animated: true, completion: nil)
        } else {
            self.cannotSendMail()
        }
    }
    
    @IBAction func buttonPressed(_ sender: UITapGestureRecognizer) {
        
        var mail = setupMailView()
        
        dateFormatter.dateFormat = " MM-dd-YYYY"
        timeFormatter.dateFormat = " HH:mm "
        name = NameOrganization.text!
        message = "Name / Organization: " + name + "\n Date to Send: " + dateFormatter.string(from: DateTime.date) + "\n Time to Send: " + timeFormatter.string(from: DateTime.date) + "\n Message: " + MessageView.text
        mail.setSubject(name)
        mail.setMessageBody(message, isHTML: false)
        
        if MFMailComposeViewController.canSendMail() {
            self.present(mail, animated: true, completion: nil)
        } else {
            self.cannotSendMail()
        }
        
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "NavViewController") as! NavViewController
        self.present(tab, animated:true, completion:nil)
    }
    
}
