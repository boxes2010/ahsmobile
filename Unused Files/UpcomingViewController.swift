//
//  UpcomingViewController.swift
//  AHS
//
//  Created by Jason Zhao on 10/21/17.
//  Copyright © 2017 Jason Zhao. All rights reserved.
//

import UIKit

class UpcomingViewController: UIViewController{

    @IBOutlet var BottomLongLine: UIImageView!
    @IBOutlet var LongGreyLine: UIImageView!
    @IBOutlet var HamburgerButton: UIButton!
    @IBOutlet var MonthLabel: UILabel!
    @IBOutlet var MainView: UIView!
    @IBOutlet var ViewHeight: NSLayoutConstraint!
    
    var separationConstant : CGFloat = -15.0
    var position : CGFloat = 150.0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeTopLine()
        HamburgerButton.frame.origin.x = self.view.frame.size.width - 60.0
        JSONToTextView(urlstring: "https://arcadiaprojectapp.000webhostapp.com/version%201%20php/Upcoming/1117.php")
        returning = true
        HamburgerButton.frame.origin.x = self.view.frame.size.width - 60.0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeTopLine(){
        let newLine = UIImageView()
        newLine.image = UIImage(named: "LongGreyLine")
        newLine.contentMode = .scaleAspectFit
        newLine.frame.size.height = 10
        newLine.frame.size.width = self.view.frame.size.width
        newLine.center.x = self.view.center.x
        newLine.frame.origin.y = 130
        self.MainView.addSubview(newLine)
        
        LongGreyLine.center.x = self.view.center.x
        BottomLongLine.center.x = self.view.center.x
    }
    
    func makeSet(textString: String, labelString: String, counter: CGFloat){
        
            let newTextView = UITextView(frame: CGRect(x: 0, y: 0, width: 240, height: 160))
            newTextView.backgroundColor = UIColor.clear
            newTextView.isScrollEnabled = false
            newTextView.frame.origin.y = position + separationConstant
        let textViewText = self.makeAttributedMessage(message: textString)
            newTextView.attributedText = textViewText
            newTextView.sizeToFit()
            newTextView.frame.size.width = 240.0
            newTextView.frame.origin.x = self.view.frame.size.width - newTextView.frame.size.width
            self.MainView.addSubview(newTextView)
            
            let newLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 120, height: 160 ))
            newLabel.backgroundColor = UIColor.clear
            newLabel.frame.size.width = self.view.frame.size.width - newTextView.frame.size.width
            newLabel.frame.origin.x = 0.0
            newLabel.frame.origin.y = newTextView.frame.origin.y
            newLabel.frame.size.height = newTextView.frame.size.height
        let labelText = self.makeAttributedTitle(title: labelString)
            newLabel.attributedText = labelText
            newLabel.textAlignment = .center
            self.MainView.addSubview(newLabel)
        
            let newLine = UIImageView()
            newLine.backgroundColor = UIColor.clear
            newLine.image = UIImage(named: "LongGreyLine")
            newLine.contentMode = .scaleAspectFit
            newLine.frame.size.height = 10
            newLine.frame.size.width = self.view.frame.size.width
            newLine.center.x = self.view.center.x
            newLine.frame.origin.y = newLabel.frame.origin.y + newLabel.frame.size.height + (separationConstant)
            newLine.layer.zPosition = 2
            self.MainView.addSubview(newLine)
        
            position = newLine.frame.origin.y + newLine.frame.size.height - separationConstant
    }
    
    func JSONToTextView(urlstring: String) {
        let testURLString = urlstring
        let testURl = URL(string: testURLString)
        _ = [Post]()
        
        URLSession.shared.dataTask(with: testURl!){
            (data, response, err) in
            let data = data
            do{
                let post = try JSONDecoder().decode([Post].self, from: data!)
                var counter = 1.0
                //starting the counter at 1 accounts for the top bar
                
                DispatchQueue.main.async {
                    for Post in post{
                        
                        self.makeSet(textString: Post.message, labelString: Post.title, counter: CGFloat(counter))
                        counter = counter + 1.0
                        
                    }
                    
                    self.ViewHeight.constant = CGFloat(self.position)
                    self.setupMonthLabel(label: self.MonthLabel, text: post[0].topic)
                }
                
            } catch _ {
                
            }
            
            }.resume()
    }
    func makeAttributedTopLabel(title: String) -> NSMutableAttributedString{
        
        _ = UIColor(red: 210.0/255.0, green: 77.0/255.0, blue: 87.0/255.0, alpha: 1.0)
        let paragraphLineSpacing = NSMutableParagraphStyle()
        paragraphLineSpacing.lineSpacing = 4
        let titleAttributes = [ NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font: UIFont(name: "MyriadPro-Bold", size: 30.0)!] as [NSAttributedString.Key : Any]
        let attributedTitle = NSAttributedString(string: title, attributes: titleAttributes)
        let fullMessage = NSMutableAttributedString(string: "")
        fullMessage.append(attributedTitle)
        
        return fullMessage
    }
    
    func makeAttributedTitle(title: String) -> NSMutableAttributedString{
        
        let orangeColor = UIColor(red: 210.0/255.0, green: 77.0/255.0, blue: 87.0/255.0, alpha: 1.0)
        let paragraphLineSpacing = NSMutableParagraphStyle()
        paragraphLineSpacing.lineSpacing = 4
        let titleAttributes = [ NSAttributedString.Key.foregroundColor : orangeColor, NSAttributedString.Key.font: UIFont(name: "MyriadPro-Bold", size: 40.0)!] as [NSAttributedString.Key : Any]
        let attributedTitle = NSAttributedString(string: title, attributes: titleAttributes)
        let fullMessage = NSMutableAttributedString(string: "")
        fullMessage.append(attributedTitle)
        
        return fullMessage
    }
    
    func makeAttributedMessage(message: String) -> NSMutableAttributedString{
        
        let paragraphLineSpacing = NSMutableParagraphStyle()
        paragraphLineSpacing.lineSpacing = 10

        let messageAttributes = [ NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.paragraphStyle: paragraphLineSpacing, NSAttributedString.Key.font: UIFont(name: "MyriadPro-Regular", size: 18.0)!] as [NSAttributedString.Key : Any]
        let attributedMessage = NSAttributedString(string: message, attributes: messageAttributes)
        
        let fullMessage = NSMutableAttributedString(string: "")
        fullMessage.append(attributedMessage)
        
        return fullMessage
    }
    
    //to be calledin makeJSON()
    func setupMonthLabel(label: UILabel, text: String){
        let labelMessage = makeAttributedTopLabel(title: text)
        label.attributedText = labelMessage
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
        self.present(tab, animated:true, completion:nil)
        
    }
    
}
