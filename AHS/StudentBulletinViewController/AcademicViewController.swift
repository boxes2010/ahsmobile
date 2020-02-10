//
//  AcademicViewController.swift
//  AHS
//
//  Created by Jason Zhao on 10/13/17.
//  Copyright © 2017 Jason Zhao. All rights reserved.
//

import UIKit

class AcademicViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var TitleLabel: UILabel!
    @IBOutlet var ScrollView: UIScrollView!
    @IBOutlet var BackButton: UIButton!
    
    @IBOutlet var MainTextView: UITextView!
    
    var refresh = UIRefreshControl()
    
    var academicsPHPURL = "http://ahsmobile.ausd.net:8080/AHS-Mobile/bulletin-json-v2.jsp?category=1"
    
    override func viewDidAppear(_ animated: Bool) {
        JSONToTextView(urlstring: academicsPHPURL)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didReturnFromBulletin = true
        TitleLabel.center.x = self.view.frame.size.width / 2
        self.setupScrollView()
        self.setupStatusBar()
        self.setupRefresh()
        BackButton.imageView?.contentMode = .scaleAspectFit
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupRefresh(){
        let title = NSLocalizedString("Pull To Refresh", comment: "Pull to refresh")
        refresh.attributedTitle = NSAttributedString(string: title)
        refresh.addTarget(self, action: #selector(refreshAction(sender:)),for: .valueChanged)
        ScrollView.addSubview(refresh)
    }
    
    @objc func refreshAction(sender: AnyObject!){
        
        self.JSONToTextView(urlstring: academicsPHPURL)
        print("refreshed")
        refresh.endRefreshing()
        print("refreshed")
    }
    
    func setupScrollView(){
        ScrollView.delegate = self
        ScrollView.minimumZoomScale = 1.0
        ScrollView.maximumZoomScale = 6.0
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return MainTextView
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        self.ScrollView.contentSize.height = self.MainTextView.frame.size.height + self.MainTextView.frame.origin.y
    }
    
    func setupTextView()
    {
        MainTextView.frame.size.width = self.view.frame.size.width * 0.90
        MainTextView.center.x = self.view.center.x
        MainTextView.sizeToFit()
        MainTextView.frame.origin.y = 87.0
        
    }
    
    func setupStatusBar(){
    let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
    let statusBarColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    statusBarView.backgroundColor = statusBarColor
        
        //check for iphone x
        if(!(UIScreen.main.nativeBounds.height == 2436)){
            view.addSubview(statusBarView)
        }
    }
    
    func JSONToTextView(urlstring: String) {
        let testURLString = urlstring
        let testURl = URL(string: testURLString)

        
        URLSession.shared.dataTask(with: testURl!){
            (data, response, err) in
            let data = data
            do{
                let post = try JSONDecoder().decode([PostBulletin].self, from: data!)
                DispatchQueue.main.async {
                    
                    let fullMessage = NSMutableAttributedString(string: "")
                    
                    for index in post {
                        print(index.title)
                        print(index.message)
                        let newLine = NSAttributedString(string: "\n")
                        
                        fullMessage.append(self.makeAttributedString(title: index.title, message: index.message))
                        fullMessage.append(newLine)
                        fullMessage.append(newLine)
                        self.MainTextView.attributedText = fullMessage
                        self.setupTextView()
                        self.ScrollView.contentSize.height = self.MainTextView.frame.size.height + self.MainTextView.frame.origin.y
                        
                    }
                    
                }
            } catch let _ {
                
                print("error")
                
            }
            
            }.resume()
    }
    
    func JSONToTextViewRefresh(urlstring: String) {
        let testURLString = urlstring
        let testURl = URL(string: testURLString)
        
        
        URLSession.shared.dataTask(with: testURl!){
            (data, response, err) in
            let data = data
            do{
                let post = try JSONDecoder().decode([PostBulletin].self, from: data!)
                DispatchQueue.main.async {
                    
                    let fullMessage = NSMutableAttributedString(string: "")
                    
                    for index in post {
                        print(index.title)
                        print(index.message)
                        let newLine = NSAttributedString(string: "\n")
                        
                        fullMessage.append(self.makeAttributedString(title: index.title, message: index.message))
                        fullMessage.append(newLine)
                        fullMessage.append(newLine)
                        self.MainTextView.attributedText = fullMessage
                        self.setupTextView()
                        self.ScrollView.contentSize.height = self.MainTextView.frame.size.height + self.MainTextView.frame.origin.y
                        
                    }
                    
                }
            } catch let _ {
                
                print("error")
                
            }
            
            }.resume()
    }
    
    func makeAttributedString(title: String, message: String) -> NSMutableAttributedString{
        
        let greyColor = UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        let blueColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 153.0/255.0, alpha: 1.0)
        let paragraphLineSpacing = NSMutableParagraphStyle()
        paragraphLineSpacing.lineSpacing = 4
        
        
        let titleAttributes = [ NSAttributedString.Key.foregroundColor : blueColor, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: CGFloat(UserDef.float(forKey: "FontSize")) + 2.0)!] as [NSAttributedString.Key : Any]
        let messageAttributes = [ NSAttributedString.Key.foregroundColor : greyColor, NSAttributedString.Key.paragraphStyle: paragraphLineSpacing, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: CGFloat(UserDef.float(forKey: "FontSize")))!] as [NSAttributedString.Key : Any]
        
        let attributedTitle = NSAttributedString(string: self.convertSpecialCharacters(string: title), attributes: titleAttributes)
        let attributedMessage = NSAttributedString(string: self.convertSpecialCharacters(string: message), attributes: messageAttributes)
        
        let newLine = NSAttributedString(string: "\n")
        let fullMessage = NSMutableAttributedString(string: "")
        fullMessage.append(attributedTitle)
        fullMessage.append(newLine)
        fullMessage.append(newLine)
        fullMessage.append(attributedMessage)
        
        return fullMessage
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
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

}
