//
//  NotificationViewController.swift
//  AHS
//
//  Created by Jason Zhao on 2/17/18.
//  Copyright © 2018 Jason Zhao. All rights reserved.
//

import UIKit

struct NotificationPost : Decodable {
    let id : String
    let time : String
    let category : String
    let title : String
    let message : String
    
}

var cancelDownloadNotification = false
var didReturnFromPopOver = false

var PassedSummary : String = ""
var PassedFull : String = ""


class NotificationViewController: UIViewController {
    
    
    var pos : CGFloat = 0.0
    @IBOutlet var ScrollView: UIScrollView!
    var topCover = UIImageView()
    
    @IBOutlet var NotificationLabel: UILabel!
    @IBOutlet var CategoryLabel: UILabel!
    @IBOutlet var MessageLabel: UILabel!
    @IBOutlet var LongGreyLine: UIImageView!
    
    var refresh = UIRefreshControl()
    
    override func viewDidAppear(_ animated: Bool) {
            self.JSONToTextRefresh(urlstring: "http://ahsmobile.ausd.net:8080/AHS-Mobile/notification-json.jsp", descriptionString: "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTop()
        self.setupStatusBar()
        self.setupRefresh()
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        CategoryLabel.removeFromSuperview()
        MessageLabel.removeFromSuperview()
        
        //self.ScrollView.backgroundColor = UIColor.gray
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTop(){
        NotificationLabel.frame.origin.y = UIApplication.shared.statusBarFrame.size.height
        print("Notification")
        print(NotificationLabel.frame.origin.y)
        
        pos = LongGreyLine.frame.origin.y + 5.0
    }
    
    func setupRefresh(){
        _ = NSLocalizedString("Pull To Refresh", comment: "Pull to refresh")
        refresh.attributedTitle = NSAttributedString(string: "")
        refresh.addTarget(self, action: #selector(refreshAction(sender:)),for: .valueChanged)
        ScrollView.addSubview(refresh)
    }
    
    @objc func refreshAction(sender: AnyObject!){
        
        self.JSONToTextRefresh(urlstring: "http://ahsmobile.ausd.net:8080/AHS-Mobile/notification-json.jsp", descriptionString: "http://arcadiaprojectapp.xyz/version%201%20php/News%20Page/FullArticle.php")
        self.ScrollView.contentSize.height = self.pos
        refresh.endRefreshing()
    }
    
    func setupStatusBar(){
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor.white
        statusBarView.backgroundColor = statusBarColor
        topCover.backgroundColor = statusBarColor
        
        //check for iphone x
        if(!(UIScreen.main.nativeBounds.height == 2436)){
           view.addSubview(statusBarView)
        }
    }
    
    func setupDefault(array: [String]){
        UserDef.set(array, forKey: "NotificationOpened")
    }
    
    func makeBlock(tapIndex: String, title: String, fullMessage: String, date: String, opened: Bool, ID: String){
        
        let block = UIView()
        block.frame.size.width = self.view.frame.size.width + 2.0
        block.frame.size.height = self.view.frame.size.height * 0.135
        block.center.x = self.view.center.x
        block.frame.origin.y = pos
        block.backgroundColor = UIColor.clear
        self.ScrollView.addSubview(block)
        
        let line = UIImageView()
        line.image = UIImage(named: "LongGreyLine")
        line.contentMode = UIView.ContentMode.scaleAspectFit
        line.frame.size.width = block.frame.size.width
        line.frame.size.height = 13.0
        line.center.x = self.view.center.x
        line.frame.origin.y = block.frame.size.height - 6.5
        block.addSubview(line)
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "")
        imageView.frame.size.width = self.view.frame.size.width * 0.05
        imageView.frame.size.height = block.frame.size.height - 1.0
        imageView.frame.origin.x = 0.0
        imageView.center.y = block.frame.size.height / 2
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.clear
        block.addSubview(imageView)
        
        let categoryLabel = UILabel()
        categoryLabel.frame.size.width = self.view.frame.size.width * 0.30
        categoryLabel.frame.size.height = block.frame.size.height
        categoryLabel.frame.origin.x = imageView.frame.size.width + imageView.frame.origin.x + 20.0
        categoryLabel.center.y = imageView.center.y
        categoryLabel.backgroundColor = UIColor.clear
        //block.addSubview(categoryLabel)
        
        let textView = UITextView()
        textView.frame.size.width = self.view.frame.size.width * 0.9
        textView.frame.size.height = block.frame.size.height * 0.80
        textView.frame.origin.x = imageView.frame.origin.x + imageView.frame.size.width + 5.0
        textView.center.y = block.frame.size.height / 2
        //textView.attributedText = self.makeAttributedStringSmall(title: title, message: "")
        textView.backgroundColor = UIColor.clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = true
        textView.isSelectable = false
        block.addSubview(textView)
        
        let dateLabel = UILabel()
        let convertedTime : NSAttributedString = minutesToTime(minutes: date)
        dateLabel.frame.size.width = self.view.frame.size.width * 0.50
        dateLabel.frame.size.height = block.frame.size.height * 0.20
        dateLabel.attributedText = convertedTime
        dateLabel.sizeToFit()
        dateLabel.frame.origin.x = self.view.frame.size.width - dateLabel.frame.size.width - 13.9
        dateLabel.frame.origin.y = block.frame.size.height - dateLabel.frame.size.height - 5.0
        dateLabel.backgroundColor = UIColor.clear
        block.addSubview(dateLabel)
        
        if(opened){
            let sideBar = UIColor(red: 246.0 / 255.0, green: 236.0 / 255.0, blue: 238.0 / 255.0, alpha: 1.0)
            imageView.backgroundColor = sideBar
            textView.attributedText = self.makeAttributedStringSmall(title: title, message: "")
            textView.textContainer.maximumNumberOfLines = 3
            textView.sizeToFit()
            textView.textContainer.lineBreakMode = .byTruncatingTail
            textView.center.y = block.frame.size.height / 2
        }else{
            let sideBar = UIColor(red: 210.0 / 255.0, green: 77.0 / 255.0, blue: 87.0 / 255.0, alpha: 1.0)
            let greyBackground = UIColor(red: 246.0 / 255.0, green: 236.0 / 255.0, blue: 238.0 / 255.0, alpha: 1.0)
            imageView.backgroundColor = sideBar
            textView.attributedText = self.makeAttributedStringBold(title: title, message: "")
            textView.textContainer.maximumNumberOfLines = 3
            textView.sizeToFit()
            textView.textContainer.lineBreakMode = .byTruncatingTail
            textView.center.y = block.frame.size.height / 2
            block.backgroundColor = greyBackground
        }
        
        var tap = MyTapGesture()
        
        if(tapIndex == "1"){
            tap = MyTapGesture(target: self, action: #selector(self.goToHome(_:)))
            tap.id = ID
            categoryLabel.attributedText = self.makeAttributedStringSmall(title: "Bulletin Page", message: "")
        }else if(tapIndex == "2"){
            tap = MyTapGesture(target: self, action: #selector(self.goToBulletin(_:)))
            tap.id = ID
            categoryLabel.attributedText = self.makeAttributedStringSmall(title: "Home Page", message: "")
        }else if(fullMessage == "no message"){
            tap = MyTapGesture(target: self, action: #selector(self.goToNothing(_:)))
            tap.id = ID
            categoryLabel.attributedText = self.makeAttributedStringSmall(title: "Other", message: "")
        }else{
            tap = MyTapGesture(target: self, action: #selector(self.goToSomething(_:)))
            tap.id = ID
            
            categoryLabel.attributedText = self.makeAttributedStringSmall(title: "Other", message: "")
            tap.title = title
            tap.message = fullMessage
        }
        
        block.addGestureRecognizer(tap)
        
    }
    
    func JSONToText(urlstring: String, descriptionString : String) {
        let testURLString = urlstring
        let testURl = URL(string: testURLString)
        _ = URLSession.shared.dataTask(with: testURl!){
            (data, response, err) in
            let data = data
            
            do{
                let articleArray = try JSONDecoder().decode([NotificationPost].self, from: data!)
                var counter = 0
                DispatchQueue.main.async {
                    self.setupTop()
                    
                    for _ in articleArray{
                        
                        var isOpened = false
                        for ID in UserDef.array(forKey: "NotificationOpened") as! [String]!{
                            if articleArray[counter].id == ID{
                                isOpened = true
                            }
                            //print(isOpened)
                        }
                        
                        self.makeBlock(tapIndex: articleArray[counter].category, title: articleArray[counter].title, fullMessage: articleArray[counter].message, date: articleArray[counter].time, opened: isOpened, ID: articleArray[counter].id)
                        self.pos += self.view.frame.size.height * 0.135 + (CGFloat(counter) * 20.0)
                        print("Value")
                        print((CGFloat(counter) * 20.0))
                        counter += 1
                    }
                    if(self.pos <= self.view.frame.size.height){
                        self.ScrollView.contentSize.height = self.view.frame.size.height + 20.0
                    }
                    else{
                        self.ScrollView.contentSize.height = self.pos + 80.0
                    }
                }
            } catch let _ {
                print("Error decoding JSON")
            }
            }.resume()
    }
    
    func JSONToTextRefresh(urlstring: String, descriptionString : String) {
        let testURLString = urlstring
        let testURl = URL(string: testURLString)
        _ = URLSession.shared.dataTask(with: testURl!){
            (data, response, err) in
            let data = data
            
            do{
                let articleArray = try JSONDecoder().decode([NotificationPost].self, from: data!)
                var counter = 0
                DispatchQueue.main.async {
                    
                    for view in self.ScrollView.subviews{
                        if(view != self.NotificationLabel && view != self.LongGreyLine && view != self.refresh){
                            view.removeFromSuperview()
                        }
                    }
                    
                    self.setupTop()
                    
                    for _ in articleArray{
                        
                        var isOpened = false
                        print(UserDef.array(forKey: "NotificationOpened"))
                        for ID in UserDef.array(forKey: "NotificationOpened") as! [String]!{
                            if articleArray[counter].id == ID{
                                isOpened = true
                            }
                        }
                        self.makeBlock(tapIndex: articleArray[counter].category, title: articleArray[counter].title, fullMessage: articleArray[counter].message, date: articleArray[counter].time, opened: isOpened, ID: articleArray[counter].id)
                        self.pos += self.view.frame.size.height * 0.135 + 0.75
                        counter += 1
                    }
                    if(self.pos <= self.view.frame.size.height){
                        self.ScrollView.contentSize.height = self.view.frame.size.height + 20.0
                    }
                    else{
                        self.ScrollView.contentSize.height = self.pos + 80.0
                    }
                }
            } catch let _ {
                print("Error decoding JSON")
            }
            }.resume()
    }
    
    func makeAttributedStringSmall(title: String, message: String) -> NSMutableAttributedString{
        
        let greyColor = UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        let paragraphLineSpacing = NSMutableParagraphStyle()
        paragraphLineSpacing.lineSpacing = -2
        
        
        let titleAttributes = [ NSAttributedString.Key.foregroundColor : greyColor,NSAttributedString.Key.paragraphStyle: paragraphLineSpacing, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 15.0)!] as [NSAttributedString.Key : Any]
        
        let attributedTitle = NSAttributedString(string: self.convertSpecialCharacters(string: title), attributes: titleAttributes)
        
        _ = NSAttributedString(string: "\n")
        let fullMessage = NSMutableAttributedString(string: "")
        fullMessage.append(attributedTitle)
        return fullMessage
    }
    
    func makeAttributedStringBold(title: String, message: String) -> NSMutableAttributedString{
        
        let greyColor = UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        let paragraphLineSpacing = NSMutableParagraphStyle()
        paragraphLineSpacing.lineSpacing = -2
        
        
        let titleAttributes = [ NSAttributedString.Key.foregroundColor : greyColor,NSAttributedString.Key.paragraphStyle: paragraphLineSpacing, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 15.0)!] as [NSAttributedString.Key : Any]
        
        let attributedTitle = NSAttributedString(string: self.convertSpecialCharacters(string: title), attributes: titleAttributes)
        
        _ = NSAttributedString(string: "\n")
        let fullMessage = NSMutableAttributedString(string: "")
        fullMessage.append(attributedTitle)
        return fullMessage
    }
    
    func makeAttributedStringDate(title: String, message: String) -> NSMutableAttributedString{
        
        let greyColor = UIColor(red: 132.0/255.0, green: 138.0/255.0, blue: 146.0/255.0, alpha: 1.0)
        let paragraphLineSpacing = NSMutableParagraphStyle()
        paragraphLineSpacing.lineSpacing = 2
        
        
        let titleAttributes = [ NSAttributedString.Key.foregroundColor : greyColor, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 14.0)!] as [NSAttributedString.Key : Any]
        let messageAttributes = [ NSAttributedString.Key.foregroundColor : greyColor, NSAttributedString.Key.paragraphStyle: paragraphLineSpacing, NSAttributedString.Key.font: UIFont(name: "MyriadPro-Regular", size: 14.0)!] as [NSAttributedString.Key : Any]
        
        let attributedTitle = NSAttributedString(string: self.convertSpecialCharacters(string: title), attributes: titleAttributes)
        _ = NSAttributedString(string: message, attributes: messageAttributes)
        
        let fullMessage = NSMutableAttributedString(string: "")
        
        fullMessage.append(attributedTitle)
        //fullMessage.append(attributedMessage)
        
        return fullMessage
    }
    
    func minutesToTime(minutes: String) -> NSMutableAttributedString{
        var convertedText : String = ""
        let minutesInt : Int = Int(minutes)!
        var hoursInt : Int = 0
        var daysInt : Int = 0
        var weeksInt : Int = 0
        print(minutesInt)

        if(minutesInt == 0){
            convertedText = "Just a few moments ago"
            return self.makeAttributedStringDate(title: convertedText, message: "")
        }
        
        if(minutesInt >= 60){
            hoursInt = minutesInt / 60
        }else{
            convertedText = "\(minutesInt) minute(s) ago"
            return self.makeAttributedStringDate(title: convertedText, message: "")
        }
        
        if(hoursInt >= 24){
            daysInt = hoursInt / 24
        }else{
            convertedText = "\(hoursInt) hour(s) ago"
            return self.makeAttributedStringDate(title: convertedText, message: "")
        }
        
        
        if(daysInt >= 30){
            convertedText = "Over a month ago"
            return self.makeAttributedStringDate(title: convertedText, message: "")
        }
        
        if(daysInt >= 7){
            weeksInt = daysInt / 7
            convertedText = "\(weeksInt) week(s) ago"
            return self.makeAttributedStringDate(title: convertedText, message: "")
        }else{
            convertedText = "\(daysInt) day(s) ago"
            return self.makeAttributedStringDate(title: convertedText, message: "")
        }
        return NSMutableAttributedString()
        
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
    
    @objc func goToBulletin(_ sender : MyTapGesture){
        let temp : [String] = UserDef.array(forKey: "NotificationOpened") as! [String]
        var newArray : [String] = UserDef.array(forKey: "NotificationOpened") as! [String]
        var matched = false
        for string in temp{
            if(string == sender.id){
                matched = true
            }
        }
        
        if(matched == false){
            newArray.append(sender.id)
            UserDef.set(newArray, forKey: "NotificationOpened")
        }
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        _ = storyBoard.instantiateViewController(withIdentifier: "TabViewController") as! TabViewController
        //self.present(tab, animated:true, completion:nil)
        self.tabBarController?.selectedIndex = 1
        
    }
    
    @objc func goToHome(_ sender : MyTapGesture){
        let temp : [String] = UserDef.array(forKey: "NotificationOpened") as! [String]
        var newArray : [String] = UserDef.array(forKey: "NotificationOpened") as! [String]
        var matched = false
        for string in temp{
            if(string == sender.id){
                matched = true
            }
        }
        
        if(matched == false){
            newArray.append(sender.id)
            UserDef.set(newArray, forKey: "NotificationOpened")
        }
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        _ = storyBoard.instantiateViewController(withIdentifier: "MainPageViewController") as! MainPageViewController
        //self.present(tab, animated:true, completion:nil)
        self.tabBarController?.selectedIndex = 0
    }
    
    @objc func goToSomething(_ sender: MyTapGesture){
        let temp : [String] = UserDef.array(forKey: "NotificationOpened") as! [String]
        var newArray : [String] = UserDef.array(forKey: "NotificationOpened") as! [String]
        var matched = false
        for string in temp{
            if(string == sender.id){
                matched = true
            }
        }
        
        if(matched == false){
            newArray.append(sender.id)
            UserDef.set(newArray, forKey: "NotificationOpened")
        }
        
        print("new array:")
        print(UserDef.array(forKey: "NotificationOpened"))
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "NotificationPopOverViewController") as! NotificationPopOverViewController
        PassedSummary = sender.title
        PassedFull = sender.message
        self.present(tab, animated:true, completion:nil)
        
    }
    
    @objc func goToNothing(_ sender : MyTapGesture){
        let temp : [String] = UserDef.array(forKey: "NotificationOpened") as! [String]
        var newArray : [String] = UserDef.array(forKey: "NotificationOpened") as! [String]
        var matched = false
        for string in temp{
            if(string == sender.id){
                matched = true
            }
        }
        
        if(matched == false){
            newArray.append(sender.id)
            UserDef.set(newArray, forKey: "NotificationOpened")
        }
    }
}
