//
//  NewsViewController.swift
//  AHS
//
//  Created by Jason Zhao on 11/12/17.
//  Copyright © 2017 Jason Zhao. All rights reserved.
//

import UIKit


class NewsViewController: UIViewController {

    @IBOutlet var ScrollView: UIScrollView!
    @IBOutlet var HamburgerButton: UIButton!
    @IBOutlet var LongGreyLine: UIImageView!
    
    var articleCount = 0
    var articlePositionCounter = 1
    var position : CGFloat = 0.0
    
    var marginConstant : CGFloat = 0.0
    var separationConstant : CGFloat = 3.0
    var separationConstant2 : CGFloat = 10.0
    
    var article1Pos : CGFloat = 0.0
    var article2Pos : CGFloat = 0.0
    
    var captionPosition : CGFloat = 0.0
    
    var CurrentImage = UIImage()
    
    var fullScreenView = UIView()
    var animatedLoadingImage = UIImageView()
    
    override func viewWillAppear(_ animated: Bool) {
        self.makeMarginConstant()
        self.makeToastYum()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        position = LongGreyLine.frame.origin.y + separationConstant + 5.0
        JSONToTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/News%20Page/FrontPage.php")
        returning = true
        HamburgerButton.frame.origin.x = self.view.frame.size.width - 60.0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeToastYum(){
        
        fullScreenView.backgroundColor = UIColor.white
        fullScreenView.frame = self.view.frame
        
        animatedLoadingImage.contentMode = .scaleAspectFit
        animatedLoadingImage.frame = self.view.frame
        let imgListArray :NSMutableArray = []
        for countValue in 1...10
        {
            
            let strImageName : String = "fade\(countValue).png"
            let image  = UIImage(named:strImageName)
            imgListArray.add(image)
        }
        
        self.animatedLoadingImage.animationImages = imgListArray as! [UIImage]
        self.animatedLoadingImage.animationDuration = 1.0
        self.animatedLoadingImage.startAnimating()
        
        self.fullScreenView.addSubview(animatedLoadingImage)
        self.view.addSubview(fullScreenView)
        
    }
    
    func ripToast(){
        UIView.animate(withDuration: 3.0, animations:{
            
            self.fullScreenView.alpha = 0.0
            
        }, completion: nil)
        
        fullScreenView.removeFromSuperview()
        animatedLoadingImage.removeFromSuperview()
        
    }
    
    func makeMarginConstant(){
        self.marginConstant = self.view.frame.size.width * 0.04
    }
    
    @objc func handleTap(_ sender: MyTapGesture){
        print("Hi")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "PopOverViewController") as! PopOverViewController
        PassedIndex = sender.index
        PassedImage = sender.image
        PassedURL = "http://arcadiaprojectapp.xyz/version%201%20php/News%20Page/FullArticle.php"
        self.present(tab, animated:true, completion:nil)
    }
    
    func setupImage(picture: UIImageView, urlString:URL){
        
        let data = try? Data(contentsOf: urlString)
        
        if let cachedImage = cache[urlString.absoluteString]{
            picture.image = cachedImage
            print("1231231241")
            picture.layer.cornerRadius = 4
            picture.layer.masksToBounds = true
        } else {
            
            if data != nil{
                picture.layer.cornerRadius = 4
                picture.layer.masksToBounds = true
                picture.image = UIImage(data: data!)
                cache[urlString.absoluteString] = UIImage(data: data!)
                print("asdas")
            }
        }
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
                _ = 1.0
                //starting the counter at 1 accounts for the top bar
                
                DispatchQueue.main.async {
                    for _ in post {
                        self.ScrollView.addSubview(self.makeImageView(link: post[self.articleCount].topic))
                        self.ScrollView.addSubview(self.makeCaption(cap: post[self.articleCount].message))
                        self.ScrollView.addSubview(self.makeLabel(message: post[self.articleCount].title))
                        self.articleCount += 1
                        if(self.articlePositionCounter == 6){
                            self.articlePositionCounter = 1
                        }else{
                            self.articlePositionCounter += 1
                            }
                        }
                        self.ScrollView.contentSize = CGSize(width: 0.0, height: self.position + self.separationConstant + self.LongGreyLine.frame.origin.y)
                        self.ripToast()
                    }
            } catch let _ {
            }
        }.resume()
    }
    
    func makeImageView(link: String) -> UIImageView {
        let newImageView = UIImageView()
        newImageView.isUserInteractionEnabled = true
        setupImage(picture: newImageView, urlString: URL(string: link)!)
        if(articlePositionCounter == 6 || articlePositionCounter == 5 || articlePositionCounter == 4){
            newImageView.frame.size.width = (self.view.frame.size.width) / 2.5
            newImageView.frame.size.height = 154.0
            newImageView.frame.origin.x = self.view.frame.size.width - newImageView.frame.size.width
            newImageView.frame.origin.y = position
            position = newImageView.frame.size.height + newImageView.frame.origin.y + separationConstant
            newImageView.layer.cornerRadius = 1
            let tap = MyTapGesture(target: self, action: #selector(self.handleTap(_:)))
            tap.numberOfTouchesRequired = 1
            tap.numberOfTapsRequired = 1
            tap.index = articleCount
            tap.image = newImageView.image!
            newImageView.addGestureRecognizer(tap)
            
        }else if(articlePositionCounter == 3){
            newImageView.frame.size.width =  self.view.frame.size.width / 2 - (2 * separationConstant2)
            newImageView.frame.size.height = 124.0
            newImageView.frame.origin.x = self.view.frame.size.width - marginConstant - newImageView.frame.size.width
            newImageView.frame.origin.y = position
            position = newImageView.frame.origin.y + newImageView.frame.size.height + separationConstant
            let tap = MyTapGesture(target: self, action: #selector(self.handleTap(_:)))
            tap.numberOfTouchesRequired = 1
            tap.numberOfTapsRequired = 1
            tap.index = articleCount
            tap.image = newImageView.image!
            newImageView.addGestureRecognizer(tap)
        }else if(articlePositionCounter == 2){
            newImageView.frame.size.width =  self.view.frame.size.width / 2 - (2 * separationConstant2)
            newImageView.frame.size.height = 124.0
            newImageView.frame.origin.x = marginConstant
            newImageView.frame.origin.y = position
            let tap = MyTapGesture(target: self, action: #selector(self.handleTap(_:)))
            tap.numberOfTouchesRequired = 1
            tap.numberOfTapsRequired = 1
            tap.index = articleCount
            tap.image = newImageView.image!
            newImageView.addGestureRecognizer(tap)
        }else{
            newImageView.frame.size.width = self.view.frame.size.width - (2 * marginConstant)
            newImageView.frame.size.height = 203.0
            newImageView.frame.origin.x = marginConstant
            newImageView.frame.origin.y = position
            position = newImageView.frame.origin.y + newImageView.frame.size.height + separationConstant
            let tap = MyTapGesture(target: self, action: #selector(self.handleTap(_:)))
            tap.numberOfTouchesRequired = 1
            tap.numberOfTapsRequired = 1
            tap.index = articleCount
            tap.image = newImageView.image!
            newImageView.addGestureRecognizer(tap)
        }
        CurrentImage = newImageView.image!
        return newImageView
    }
    
    func makeCaption(cap: String) -> UILabel {
        let newCaption = UILabel()
        
        if(articlePositionCounter == 6 || articlePositionCounter == 5 || articlePositionCounter == 4){
            newCaption.frame.size.width = 0.0
            newCaption.frame.size.height = 0.0
            return newCaption
        }else if(articlePositionCounter == 3){
            newCaption.frame.size.width = self.view.frame.size.width / 2.0 - (2 * separationConstant2)
            newCaption.frame.size.height = 21.0
            newCaption.frame.origin.x = self.view.frame.size.width - newCaption.frame.size.width - 10.0
            newCaption.frame.origin.y = position + separationConstant
            position = newCaption.frame.origin.y + newCaption.frame.size.height + separationConstant
        }else if(articlePositionCounter == 2){
            newCaption.frame.size.width = self.view.frame.size.width / 2.0  - 20.0
            newCaption.frame.size.height = 21.0
            newCaption.frame.origin.x = marginConstant
            newCaption.frame.origin.y = position + separationConstant2 + 124.0
        }else{
            newCaption.frame.size.width = self.view.frame.size.width - (2 * marginConstant)
            newCaption.frame.size.height = 21.0
            newCaption.frame.origin.x = marginConstant
            newCaption.frame.origin.y = position + separationConstant
            position = newCaption.frame.origin.y + newCaption.frame.size.height + separationConstant
        }
        self.makeAttributedStringCaption(caption: cap, lab: newCaption)
        captionPosition = newCaption.frame.origin.y + newCaption.frame.size.height + separationConstant
        return newCaption
    }
    
    func makeLabel(message: String) -> UILabel {
        let newLabel = UILabel()
        newLabel.isUserInteractionEnabled = true
        if(articlePositionCounter == 6 || articlePositionCounter == 5 || articlePositionCounter == 4){
            newLabel.numberOfLines = 0
            newLabel.attributedText = makeAttributedStringSmall(title: message, message: "")
            newLabel.sizeToFit()
            newLabel.frame.size.width = self.view.frame.size.width * (1.5/2.5)
            newLabel.frame.size.height = 154.0
            newLabel.frame.origin.x = 0.0
            newLabel.frame.origin.y = position - 193.0
            
            let tempCenter = newLabel.center.x
            newLabel.frame.size.width = self.view.frame.size.width * (2.0 / 3.0) - (2 * separationConstant2)
            newLabel.center.x = tempCenter
            let tap = MyTapGesture(target: self, action: #selector(self.handleTap(_:)))
            tap.numberOfTouchesRequired = 1
            tap.numberOfTapsRequired = 1
            tap.index = articleCount
            tap.image = CurrentImage
            newLabel.addGestureRecognizer(tap)
        }else if(articlePositionCounter == 3){
            newLabel.numberOfLines = 0
            newLabel.frame.size.width = self.view.frame.size.width / 2 - (2 * separationConstant2)
            newLabel.attributedText = makeAttributedStringSmall(title: message, message: "")
            newLabel.sizeToFit()
            
            newLabel.frame.origin.x = self.view.frame.size.width / 2 + separationConstant
            newLabel.frame.origin.y = position
            article2Pos = newLabel.frame.origin.y + newLabel.frame.size.height + separationConstant
            let tap = MyTapGesture(target: self, action: #selector(self.handleTap(_:)))
            tap.numberOfTouchesRequired = 1
            tap.numberOfTapsRequired = 1
            tap.index = articleCount
            tap.image = CurrentImage
            newLabel.addGestureRecognizer(tap)
        }else if(articlePositionCounter == 2){
            newLabel.numberOfLines = 0
            newLabel.frame.size.width = self.view.frame.size.width / 2 - (2 * separationConstant2)
            newLabel.attributedText = makeAttributedStringSmall(title: message, message: "")
            newLabel.sizeToFit()
            newLabel.frame.origin.x = marginConstant
            newLabel.frame.origin.y = captionPosition
            article1Pos = newLabel.frame.origin.y + newLabel.frame.size.height + separationConstant
            let tap = MyTapGesture(target: self, action: #selector(self.handleTap(_:)))
            tap.numberOfTouchesRequired = 1
            tap.numberOfTapsRequired = 1
            tap.index = articleCount
            tap.image = CurrentImage
            newLabel.addGestureRecognizer(tap)
        }else{
            newLabel.numberOfLines = 0
            newLabel.frame.size.width = self.view.frame.size.width - (2 * separationConstant)
            newLabel.attributedText = makeAttributedStringBig(title: message, message: "")
            newLabel.sizeToFit()
            newLabel.frame.origin.x = marginConstant
            newLabel.frame.origin.y = position
            position = newLabel.frame.origin.y + newLabel.frame.size.height + separationConstant
            let tap = MyTapGesture(target: self, action: #selector(self.handleTap(_:)))
            tap.numberOfTouchesRequired = 1
            tap.numberOfTapsRequired = 1
            tap.index = articleCount
            tap.image = CurrentImage
            newLabel.addGestureRecognizer(tap)
        }
        if(article2Pos != 0.0){
            if(article1Pos > article2Pos){
                position = article1Pos
                article1Pos = 0.0
                article2Pos = 0.0
            }else {
                position = article2Pos
                article1Pos = 0.0
                article2Pos = 0.0
            }
            
        }
        
        return newLabel
    }
    
    func makeAttributedStringSmall(title: String, message: String) -> NSMutableAttributedString{
        
        let greyColor = UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        let paragraphLineSpacing = NSMutableParagraphStyle()
        paragraphLineSpacing.lineSpacing = 2
        
        
        let titleAttributes = [ NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font: UIFont(name: "MyriadPro-Bold", size: 20.0)!]
        let messageAttributes = [ NSAttributedString.Key.foregroundColor : greyColor, NSAttributedString.Key.paragraphStyle: paragraphLineSpacing, NSAttributedString.Key.font: UIFont(name: "MyriadPro-Regular", size: 14.0)!] as [NSAttributedString.Key : Any]
        
        let attributedTitle = NSAttributedString(string: title, attributes: titleAttributes)
        _ = NSAttributedString(string: message, attributes: messageAttributes)
        
        let fullMessage = NSMutableAttributedString(string: "")
        
        fullMessage.append(attributedTitle)
        //fullMessage.append(attributedMessage)
        
        return fullMessage
    }
    
    func makeAttributedStringBig(title: String, message: String) -> NSMutableAttributedString{
        
        let greyColor = UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        let paragraphLineSpacing = NSMutableParagraphStyle()
        paragraphLineSpacing.lineSpacing = -5
        
        
        let titleAttributes = [ NSAttributedString.Key.foregroundColor : UIColor.black,NSAttributedString.Key.paragraphStyle: paragraphLineSpacing, NSAttributedString.Key.font: UIFont(name: "MyriadPro-Bold", size: 28.0)!] as [NSAttributedString.Key : Any]
        let messageAttributes = [ NSAttributedString.Key.foregroundColor : greyColor, NSAttributedString.Key.paragraphStyle: paragraphLineSpacing, NSAttributedString.Key.font: UIFont(name: "MyriadPro-Regular", size: 14.0)!] as [NSAttributedString.Key : Any]
        
        let attributedTitle = NSAttributedString(string: title, attributes: titleAttributes)
        _ = NSAttributedString(string: message, attributes: messageAttributes)
        
        _ = NSAttributedString(string: "\n")
        let fullMessage = NSMutableAttributedString(string: "")
        fullMessage.append(attributedTitle)
        return fullMessage
    }
    
    func makeAttributedStringCaption(caption: String, lab: UILabel) {
        
        let greyColor = UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        let messageAttributes = [ NSAttributedString.Key.foregroundColor : greyColor, NSAttributedString.Key.font: UIFont(name: "MyriadPro-Regular", size: 14.0)!] as [NSAttributedString.Key : Any]
        
        let attributedMessage = NSAttributedString(string: caption, attributes: messageAttributes)
        let fullMessage = NSMutableAttributedString(string: "")
        fullMessage.append(attributedMessage)
        lab.attributedText = fullMessage
        
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "NavViewController") as! NavViewController
        self.present(tab, animated:true, completion:nil)
    }
    
    
}
