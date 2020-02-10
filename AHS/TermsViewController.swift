//
//  TermsViewController.swift
//  ArcadiaHighSchoolApp
//
//  Created by Jason Zhao on 9/25/17.
//  Copyright © 2017 Jason Zhao. All rights reserved.
//

import UIKit

class TermsViewController: UIViewController {
    
    let UserDef = UserDefaults.standard
    
    @IBOutlet var TopBar: UIImageView!
    @IBOutlet var AgreeButton: UIButton!
    @IBOutlet var DisagreeButton: UIButton!
    @IBOutlet var MainTextView: UITextView!
    @IBOutlet var TitleLabel: UILabel!
    var marginConstant : CGFloat = 20.0
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDef.set(false, forKey: "DidAgree")
        self.setupButton()
        self.setupTextView()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTextView(){
        TitleLabel.frame.origin.y = TopBar.frame.origin.y + TopBar.frame.size.height + 20.0
        TitleLabel.text = "Terms and Agreements"
        TitleLabel.numberOfLines = 2
        TitleLabel.sizeToFit()
        TitleLabel.frame.size.width = self.view.frame.size.width - 20.0
        TitleLabel.center.x = self.view.center.x
        MainTextView.frame.size.width = self.view.frame.size.width
        MainTextView.frame.size.height = TitleLabel.frame.size.height + TitleLabel.frame.origin.y - AgreeButton.frame.origin.y + 10.0
        MainTextView.frame.origin.y = TitleLabel.frame.origin.y + TitleLabel.frame.size.height
    }
    
    func setupButton(){
        AgreeButton.frame.origin.x = marginConstant
        DisagreeButton.frame.origin.x = self.view.frame.size.width - DisagreeButton.frame.size.width - marginConstant
        AgreeButton.frame.origin.y = self.view.frame.size.height - AgreeButton.frame.size.height - 10.0
        DisagreeButton.frame.origin.y = self.view.frame.size.height - AgreeButton.frame.size.height - 10.0
        AgreeButton.frame.origin.y = self.view.frame.size.height - AgreeButton.frame.size.height - 10.0
        DisagreeButton.center.y = AgreeButton.center.y
    }
    
    @IBAction func disagreePressed(_ sender: UIButton) {
        
    }
    
    @IBAction func agreePressed(_ sender: UIButton) {
        let agreeAlert = UIAlertController(title: "Terms and Agreements", message: "You have agreed to our Terms and Agreements", preferredStyle: .alert)
        
        agreeAlert.addAction(UIAlertAction(title: "Yes, I Agree", style:.default, handler: confirmed))
        agreeAlert.addAction(UIAlertAction(title: "Cancel", style:.cancel, handler: nil))
        self.present(agreeAlert, animated: true, completion: nil)
        let array : [String] = [" "," "]
        UserDef.set(array, forKey: "NotificationOpened")
    }
    
    func confirmed(action: UIAlertAction){
        UserDef.set(true, forKey: "DidAgree")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "TabViewController") as! UITabBarController
        self.present(tab, animated:true, completion:nil)
    }
}
