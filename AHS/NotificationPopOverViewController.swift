//
//  NotificationPopOverViewController.swift
//  AHS
//
//  Created by Jason Zhao on 3/10/18.
//  Copyright © 2018 Jason Zhao. All rights reserved.
//

import UIKit

class NotificationPopOverViewController: UIViewController {
    

    @IBOutlet var TitleLine: UIImageView!
    @IBOutlet var MessageLIne: UIImageView!
    @IBOutlet var TitleLabel: UILabel!
    @IBOutlet var MessageLabel: UILabel!
    @IBOutlet var TitleText: UITextView!
    @IBOutlet var Message: UITextView!
    @IBOutlet var ScrollView: UIScrollView!
    @IBOutlet var NotificationLabel: UILabel!
    @IBOutlet var BackButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTop()
        setupStatusBar()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupStatusBar(){
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        statusBarView.layer.zPosition = -1
        //check for iphone x
        if(!(UIScreen.main.nativeBounds.height == 2436)){
           statusBarView.backgroundColor = statusBarColor
        }else{
            statusBarView.backgroundColor = NotificationLabel.backgroundColor
        }
        view.addSubview(statusBarView)
    }
    
    func setupTop(){
        
        
        NotificationLabel.center.x = self.view.center.x
        NotificationLabel.textColor = UIColor.white
        
        TitleLabel.frame.origin.x = self.view.frame.size.width * 0.02
        TitleLabel.frame.origin.y = NotificationLabel.frame.size.height + NotificationLabel.frame.origin.y + 10.0
        TitleLabel.textColor = UIColor.darkGray
        
        TitleLine.frame.size.width = self.view.frame.size.width
        TitleLine.frame.origin.y = TitleLabel.frame.origin.y + TitleLabel.frame.size.height
        TitleLine.center.x = self.view.center.x
        
        TitleText.frame.size.width = self.view.frame.size.width * 0.98
        TitleText.attributedText = self.makeAttributedBulletinMessage(title: PassedSummary, message: "")
        TitleText.sizeToFit()
        TitleText.backgroundColor = UIColor.clear
        TitleText.frame.origin.x = self.view.frame.size.width * 0.02
        TitleText.frame.origin.y = TitleLine.frame.size.height + TitleLine.frame.origin.y
        
        MessageLabel.frame.origin.x = self.view.frame.size.width * 0.02
        MessageLabel.frame.origin.y = TitleText.frame.size.height + TitleText.frame.origin.y + 20.0
        MessageLabel.textColor = UIColor.darkGray
        
        MessageLIne.frame.size.width = self.view.frame.size.width
        MessageLIne.frame.origin.y = MessageLabel.frame.origin.y + MessageLabel.frame.size.height
        MessageLIne.center.x = self.view.center.x
        
        Message.frame.size.width = self.view.frame.size.width * 0.98
        Message.attributedText = self.makeAttributedBulletinMessage(title: PassedFull, message: "")
        Message.sizeToFit() 
        Message.backgroundColor = UIColor.clear
        Message.frame.origin.x = self.view.frame.size.width * 0.02
        Message.frame.origin.y = MessageLabel.frame.size.height + MessageLabel.frame.origin.y
        
        ScrollView.contentSize.height = Message.frame.origin.y + Message.frame.size.height
    }
    
    func convertSpecialCharacters(string: String) -> String {
        var newString = string
        let char_dictionary = [
            "&amp;amp;" : "&",
            "&amp;#039;" : "'",
            "&amp;#034;" : "\""
            
        ];
        for (escaped_char, unescaped_char) in char_dictionary {
            newString = newString.replacingOccurrences(of: escaped_char, with: unescaped_char, options: NSString.CompareOptions.literal, range: nil)
        }
        
        return newString
    }
    
    func makeAttributedStringTitle(title: String, message: String) -> NSMutableAttributedString{
        
        _ = UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        let paragraphLineSpacing = NSMutableParagraphStyle()
        paragraphLineSpacing.lineSpacing = -2
        
        
        let titleAttributes = [ NSAttributedString.Key.foregroundColor : UIColor.black,NSAttributedString.Key.paragraphStyle: paragraphLineSpacing, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 22.0)!] as [NSAttributedString.Key : Any]
        
        let attributedTitle = NSAttributedString(string: self.convertSpecialCharacters(string: title), attributes: titleAttributes)
        
        _ = NSAttributedString(string: "\n")
        let fullMessage = NSMutableAttributedString(string: "")
        fullMessage.append(attributedTitle)
        return fullMessage
    }
    
    func makeAttributedBulletinMessage(title: String, message: String) -> NSMutableAttributedString{
        
        _ = UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        let paragraphLineSpacing = NSMutableParagraphStyle()
        paragraphLineSpacing.lineSpacing = -2
        
        
        let titleAttributes = [ NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.paragraphStyle: paragraphLineSpacing, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 18.0)!] as [NSAttributedString.Key : Any]
        
        let attributedTitle = NSAttributedString(string: self.convertSpecialCharacters(string: title), attributes: titleAttributes)
        
        _ = NSAttributedString(string: "\n")
        let fullMessage = NSMutableAttributedString(string: "")
        fullMessage.append(attributedTitle)
        return fullMessage
    }
    @IBAction func backButtonPressed(_ sender: UIButton) {
        didReturnFromPopOver = true
        self.dismiss(animated: true, completion: nil)
    }
    
}
