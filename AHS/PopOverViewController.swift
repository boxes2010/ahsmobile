//
//  PopOverViewController.swift
//  AHS
//
//  Created by Jason Zhao on 10/26/17.
//  Copyright © 2017 Jason Zhao. All rights reserved.
//

import UIKit

struct NewsArticle : Decodable{
    
    let Title : String
    let Name : String
    let Date : String
    let Caption : String
    let Message : String
    let Link : String
}

class PopOverViewController: UIViewController, UIScrollViewDelegate
    {
    
    @IBOutlet var MainView: UIView!
    @IBOutlet var ScrollView: UIScrollView!
    @IBOutlet var TopBarLAbel: UILabel!
    @IBOutlet var TitleLabel: UILabel!
    @IBOutlet var NameAndDateLabel: UILabel!
    @IBOutlet var CaptionLabel: UILabel!
    @IBOutlet var MainTextView: UITextView!
    @IBOutlet var MainImageView: UIImageView!
    @IBOutlet var BackButton: UIButton!
    @IBOutlet var FontButton: UIButton!
    
    @IBOutlet var FontView: UIView!
    @IBOutlet var IncreaseFont: UIButton!
    @IBOutlet var DecreaseFont: UIButton!
    
    var marginConstant : CGFloat = 0.0
    var separationConstant : CGFloat = 10.0
    var pos : CGFloat = 0.0
    
    override func viewDidAppear(_ animated: Bool) {
        JSONToTextView(urlstring: PassedURL)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.calcMarginConstant()
        self.setupWidths()
        self.setupStatusBar()
        self.setupScrollView()
        self.setupFontView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupScrollView(){
        ScrollView.delegate = self
        ScrollView.minimumZoomScale = 1.0
        ScrollView.maximumZoomScale = 6.0
        //ScrollView.contentSize.height = ViewHeight.constant
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return MainView
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        self.ScrollView.contentSize.height = self.MainView.frame.origin.y + self.MainView.frame.size.height + self.separationConstant
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if(velocity.y>0) {
            UIView.animate(withDuration: 2.5, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.TopBarLAbel.isHidden = true
                self.BackButton.isHidden = true
                self.FontButton.isHidden = true
                self.FontView.isHidden = true
            }, completion: nil)
            
        } else {
            UIView.animate(withDuration: 2.5, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.TopBarLAbel.isHidden = false
                self.BackButton.isHidden = false
                self.FontButton.isHidden = false
            }, completion: nil)
        }
    }
    
    func setupStatusBar(){
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
        
    }
    
    func calcMarginConstant(){
        marginConstant = self.view.frame.size.width * 0.05
    }
    
    
    func setupWidths(){
        
        TopBarLAbel.frame.size.width = self.view.frame.size.width
        TitleLabel.frame.size.width = self.view.frame.size.width - (marginConstant * 2)
        NameAndDateLabel.frame.size.width = self.view.frame.size.width - (marginConstant * 2)
        CaptionLabel.frame.size.width = self.view.frame.size.width - (marginConstant * 2)
        MainImageView.frame.size.width = self.view.frame.size.width
        MainTextView.frame.size.width = self.view.frame.size.width - (marginConstant * 2)
        
        TopBarLAbel.center.x = self.view.center.x
        TitleLabel.center.x = self.view.center.x
        NameAndDateLabel.center.x = self.view.center.x
        CaptionLabel.center.x = self.view.center.x
        MainImageView.center.x = self.view.center.x
        MainTextView.center.x = self.view.center.x
        
        //MainImageView.removeFromSuperview()
        
        MainImageView.layer.cornerRadius = 0.0
        MainImageView.layer.masksToBounds = true
        
        
    }
    
    func setupFontView(){
        FontView.isHidden = true
        FontView.frame.size.width = self.view.frame.size.width * 0.40
        FontView.frame.size.height = TopBarLAbel.frame.size.height
        FontView.frame.origin.x = self.view.frame.size.width - FontView.frame.size.width - 20.0
        
        
        FontView.layer.cornerRadius = 6
        FontView.layer.masksToBounds = true
        
        DecreaseFont.frame.origin.x = 20.0
        IncreaseFont.frame.origin.x = FontView.frame.size.width - IncreaseFont.frame.size.width - 20.0
    }
    
    func JSONToTextView(urlstring: String) {
        let testURLString = urlstring
        let testURl = URL(string: testURLString)
        _ = [Post]()
        
        URLSession.shared.dataTask(with: testURl!){
            (data, response, err) in
            let data = data
            do{
                let article = try JSONDecoder().decode([NewsArticle].self, from: data!)
                DispatchQueue.main.async {
                    
                    //self.TopBarLAbel.attributedText = self.makeAttributedName(titles: article[PassedIndex].Name
                    self.TopBarLAbel.frame.origin.y = UIApplication.shared.statusBarFrame.height
                    self.BackButton.center.y = self.TopBarLAbel.center.y
                    self.BackButton.isHidden = false
                    
                    self.FontButton.frame.origin.x = self.view.frame.size.width - self.FontButton.frame.size.width - 20.0
                    self.FontButton.center.y = self.BackButton.center.y
                    self.FontButton.isHidden = false
                    
                    self.MainImageView.downloadedFrom(link: article[PassedIndex].Link, contentMode: .scaleAspectFill)
                    self.MainImageView.frame.origin.y = self.TopBarLAbel.frame.size.height + self.TopBarLAbel.frame.origin.y
                    
                    self.TitleLabel.attributedText = self.makeAttributedTitle(titles: article[PassedIndex].Title)
                    self.TitleLabel.sizeToFit()
                    self.TitleLabel.frame.origin.y = self.MainImageView.frame.origin.y + self.MainImageView.frame.size.height + self.separationConstant
                    
                    self.NameAndDateLabel.attributedText = self.makeAttributedNameDate(Date: article[PassedIndex].Date, Name: article[PassedIndex].Name)
                    self.NameAndDateLabel.frame.origin.y = self.TitleLabel.frame.origin.y + self.TitleLabel.frame.size.height + self.separationConstant
                    
                     self.CaptionLabel.attributedText = self.makeAttributedCaption(caption: article[PassedIndex].Caption)
                    self.CaptionLabel.sizeToFit()
                    self.CaptionLabel.frame.origin.y = self.NameAndDateLabel.frame.origin.y + self.NameAndDateLabel.frame.size.height + self.separationConstant
                    
                    self.MainTextView.attributedText = self.makeAttributedMessage(message: article[PassedIndex].Message)
                    self.MainTextView.sizeToFit()
                    self.MainTextView.frame.origin.y = self.CaptionLabel.frame.origin.y + self.CaptionLabel.frame.size.height + self.separationConstant
                    
                    self.MainView.frame.size.height = self.MainTextView.frame.size.height + self.MainTextView.frame.origin.y
                    
                    //self.ViewHeight.constant = self.MainTextView.frame.origin.y + self.MainTextView.frame.size.height + self.separationConstant
                    self.FontView.frame.origin.y = self.MainImageView.frame.origin.y + 5.0

                    self.ScrollView.contentSize.height = self.MainView.frame.origin.y + self.MainView.frame.size.height + self.separationConstant
                }
                //self.ScrollView.contentSize.height = self.ViewHeight.constant
            } catch _ { print("error") }
        }.resume()
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
    
    func makeAttributedTitle(titles: String) -> NSMutableAttributedString{
        let messageAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 30.0)!] as [NSAttributedString.Key : Any]
        
        let attributedMessage = NSAttributedString(string: self.convertSpecialCharacters(string: titles), attributes: messageAttributes)
        
        let fullMessage = NSMutableAttributedString(string: "")
        fullMessage.append(attributedMessage)
        
        return fullMessage
    }
    
    func makeAttributedName(titles: String) -> NSMutableAttributedString{
        let messageAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 20.0)!] as [NSAttributedString.Key : Any]
        
        let attributedMessage = NSAttributedString(string: self.convertSpecialCharacters(string: titles), attributes: messageAttributes)
        
        let fullMessage = NSMutableAttributedString(string: "")
        fullMessage.append(attributedMessage)
        
        return fullMessage
    }
    
    func makeAttributedNameDate(Date: String, Name: String) -> NSMutableAttributedString{
        
        let greyColor = UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0)

        let paragraphLineSpacing = NSMutableParagraphStyle()
        paragraphLineSpacing.lineSpacing = 4
        
        let messageAttributes = [ NSAttributedString.Key.foregroundColor : greyColor, NSAttributedString.Key.paragraphStyle: paragraphLineSpacing, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 14.0)!] as [NSAttributedString.Key : Any]
        
        let attributedMessage = NSAttributedString(string: Date + "\n" + Name, attributes: messageAttributes)
        
        let fullMessage = NSMutableAttributedString(string: "")
        fullMessage.append(attributedMessage)
        
        return fullMessage
    }
    
    func makeAttributedCaption(caption: String) -> NSMutableAttributedString{
        let titleAttributes = [ NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 13.0)!] as [NSAttributedString.Key : Any]

        let attributedTitle = NSAttributedString(string: self.convertSpecialCharacters(string: caption), attributes: titleAttributes)
        
        let fullMessage = NSMutableAttributedString(string: "")
        fullMessage.append(attributedTitle)
        
        return fullMessage
    }
    
    func makeAttributedMessage(message: String) -> NSMutableAttributedString{
        
        let greyColor = UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        
        let paragraphLineSpacing = NSMutableParagraphStyle()
        paragraphLineSpacing.lineSpacing = 4
        
        let messageAttributes = [ NSAttributedString.Key.foregroundColor : greyColor, NSAttributedString.Key.paragraphStyle: paragraphLineSpacing, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: CGFloat(UserDef.float(forKey: "FontSize")))!] as [NSAttributedString.Key : Any]
        
        let attributedMessage = NSAttributedString(string:  self.convertSpecialCharacters(string: message), attributes: messageAttributes)
        
        let fullMessage = NSMutableAttributedString(string: "")
        fullMessage.append(attributedMessage)
        
        return fullMessage
    }
    
    @IBAction func increaseFont(_ sender: UIButton) {
        MainTextView.font = UIFont(name: (MainTextView.font?.fontName)!, size: (MainTextView.font?.pointSize)! + 1)
        MainTextView.sizeToFit()
        ScrollView.contentSize.height = MainTextView.frame.size.height + MainTextView.frame.origin.y
    }
    
    @IBAction func decreaseFont(_ sender: UIButton) {
        MainTextView.font = UIFont(name: (MainTextView.font?.fontName)!, size: (MainTextView.font?.pointSize)! - 1)
        MainTextView.sizeToFit()
        ScrollView.contentSize.height = MainTextView.frame.size.height + MainTextView.frame.origin.y
    }
    
    @IBAction func imagePressed(_ sender: UITapGestureRecognizer) {
        print("Hi")
    }
    
    @IBAction func fontButtonPressed(_ sender: UIButton) {
        if(FontView.isHidden){
            FontView.isHidden = false
        }else{
            FontView.isHidden = true
        }
    }
    
    @IBAction func returnButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
