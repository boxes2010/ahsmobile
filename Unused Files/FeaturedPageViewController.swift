//
//  FeaturedPageViewController.swift
//  
//
//  Created by Jason Zhao on 8/29/17.
//  Copyright © 2017 Jason Zhao. All rights reserved.
//

import UIKit


var PassedTitle = NSMutableAttributedString()
var PassedImage = UIImage()
var PassedIndex = 0
var PassedURL = ""

var didReturnFromBulletin = false
var returning = false
var cache = [String:UIImage]()

class FeaturedPageViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var Image1: UIImageView!
    @IBOutlet var Image2: UIImageView!
    @IBOutlet var Image3: UIImageView!
    @IBOutlet var Image4: UIImageView!
    @IBOutlet var Image5: UIImageView!
    @IBOutlet var Image6: UIImageView!
    
    @IBOutlet var Label6: UILabel!
    @IBOutlet var Label5: UILabel!
    @IBOutlet var Label4: UILabel!
    @IBOutlet var Label3: UILabel!
    @IBOutlet var Label2: UILabel!
    @IBOutlet var Label1: UILabel!
    
    @IBOutlet var AcademicView: UITextView!
    @IBOutlet var CollegeView: UITextView!
    @IBOutlet var PerformingView: UITextView!
    @IBOutlet var VolunteeringView: UITextView!
    @IBOutlet var ASBView: UITextView!
    @IBOutlet var SportsView: UITextView!
    
    
    @IBOutlet var AcademicLabel: UILabel!
    @IBOutlet var CollegeLabel: UILabel!
    @IBOutlet var PerformingLabel: UILabel!
    @IBOutlet var VolunteeringLabel: UILabel!
    @IBOutlet var ASBLabel: UILabel!
    @IBOutlet var SportsLabel: UILabel!
    
    @IBOutlet var AcademicImage: UIImageView!
    @IBOutlet var CollegeImage: UIImageView!
    @IBOutlet var PerformingImage: UIImageView!
    @IBOutlet var VolunteeringImage: UIImageView!
    @IBOutlet var ASBImage: UIImageView!
    @IBOutlet var SportImage: UIImageView!
    
    
    @IBOutlet var Image1Label: UILabel!
    @IBOutlet var Image2Label: UILabel!
    @IBOutlet var Image3Label: UILabel!
    @IBOutlet var Image4Label: UILabel!
    @IBOutlet var Image5Label: UILabel!
    @IBOutlet var Image6Label: UILabel!
    
    @IBOutlet var StudentBulletinImage: UIImageView!
    @IBOutlet var CampusLabel: UILabel!
    @IBOutlet var DistrictLabel: UILabel!
    @IBOutlet var AnnouncementsLabel: UILabel!
    
    @IBOutlet var LongLine: UIImageView!
    
    @IBOutlet var ContainerView: UIView!
    @IBOutlet var ScrollView: UIScrollView!
    @IBOutlet var ViewHeight: NSLayoutConstraint!
    
    var ScreenImage = UIImageView()
    
    var fullScreenView = UIView()
    var cancelLoadingButton = UIButton()
    var animatedLoadingImage = UIImageView()
    let urlSess = URLSession()
    
    var gradientLayer1 = CAGradientLayer()
    var gradientLayer2 = CAGradientLayer()
    var gradientLayer3 = CAGradientLayer()
    
    var marginConstant:CGFloat = 0.0
    var separationConstant:CGFloat = 10.0
    
    @IBOutlet var HamburgerButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        if(didReturnFromBulletin){
            self.tabBarController?.selectedIndex = 1    
            didReturnFromBulletin = false
        }
        self.makeToastYum()
        
        if(returning){
            self.tabBarController?.tabBar.isHidden = false
        }else{
            returning = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        JSONToTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Home%20Page/frontpage.php")
        self.setupPosition()
        self.setupStatusBar()
        self.ScrollView.canCancelContentTouches = true
        //self.makeToast()
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
        
        cancelLoadingButton.frame.size.width = 50
        cancelLoadingButton.frame.size.height = 30
        cancelLoadingButton.frame.origin.x = self.view.frame.size.width - cancelLoadingButton.frame.size.width - 20.0
        cancelLoadingButton.frame.origin.y = 20.0
        cancelLoadingButton.setTitle("Cancel Loading", for: .normal)
        cancelLoadingButton.setTitleColor(UIColor.blue, for: .normal)
        cancelLoadingButton.addTarget(self, action: #selector(self.cancelCalled), for: .touchUpInside)
        //self.fullScreenView.addSubview(cancelLoadingButton)
        self.fullScreenView.addSubview(animatedLoadingImage)
        self.view.addSubview(fullScreenView)
        
    }
    
    @objc func cancelCalled(sender: UIButton){
       
    }
    
    func ripToast(){
        UIView.animate(withDuration: 3.0, animations:{
            
            self.fullScreenView.alpha = 0.0
            
        }, completion: nil)
        
        fullScreenView.removeFromSuperview()
        //cancelLoadingButton.removeFromSuperview()
        animatedLoadingImage.removeFromSuperview()
        
        
    }
    
    func setupStatusBar(){
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
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
    
    func setupPosition(){
        
        AcademicView.textContainer.maximumNumberOfLines = 3
        AcademicView.textContainer.lineBreakMode = NSLineBreakMode.byTruncatingTail
        CollegeView.textContainer.maximumNumberOfLines = 3
        CollegeView.textContainer.lineBreakMode = NSLineBreakMode.byTruncatingTail
        PerformingView.textContainer.maximumNumberOfLines = 3
        PerformingView.textContainer.lineBreakMode = NSLineBreakMode.byTruncatingTail
        VolunteeringView.textContainer.maximumNumberOfLines = 3
        VolunteeringView.textContainer.lineBreakMode = NSLineBreakMode.byTruncatingTail
        ASBView.textContainer.maximumNumberOfLines = 3
        ASBView.textContainer.lineBreakMode = NSLineBreakMode.byTruncatingTail
        SportsView.textContainer.maximumNumberOfLines = 3
        SportsView.textContainer.lineBreakMode = NSLineBreakMode.byTruncatingTail
        
        ScrollView.center = self.view.center
        LongLine.center.x = self.view.center.x
        marginConstant = self.view.frame.width * 0.04
        CampusLabel.frame.origin.x = marginConstant
        DistrictLabel.frame.origin.x = marginConstant
        AnnouncementsLabel.frame.origin.x = marginConstant
        
        Image1.frame.size.width = self.view.frame.width - 2 * marginConstant
        Image4.frame.size.width = self.view.frame.width - 2 * marginConstant
        Label1.frame.size.width = self.view.frame.width - 2 * marginConstant
        Label4.frame.size.width = self.view.frame.width - 2 * marginConstant
        
        Image2.frame.size.width = self.view.frame.width / 2 - 1.5 * marginConstant
        Image3.frame.size.width = self.view.frame.width / 2 - 1.5 * marginConstant
        Image5.frame.size.width = self.view.frame.width / 2 - 1.5 * marginConstant
        Image6.frame.size.width = self.view.frame.width / 2 - 1.5 * marginConstant
        
        Image1.frame.origin.x = marginConstant
        Image2.frame.origin.x = marginConstant
        Image3.frame.origin.x = self.view.frame.size.width - marginConstant - Image3.frame.size.width
        Image4.frame.origin.x = marginConstant
        Image5.frame.origin.x = marginConstant
        Image6.frame.origin.x = self.view.frame.size.width - marginConstant - Image6.frame.size.width
        
        Label1.frame.origin.x = marginConstant
        Label2.frame.origin.x = Image2.frame.origin.x
        Label3.frame.origin.x = Image3.frame.origin.x
        Label4.frame.origin.x = marginConstant
        Label5.frame.origin.x = Image5.frame.origin.x
        Label6.frame.origin.x = Image6.frame.origin.x
        
        Image1Label.frame.origin.x = Image1.frame.origin.x
        Image2Label.frame.origin.x = Image2.frame.origin.x
        Image3Label.frame.origin.x = Image3.frame.origin.x
        Image4Label.frame.origin.x = Image4.frame.origin.x
        Image5Label.frame.origin.x = Image5.frame.origin.x
        Image6Label.frame.origin.x = Image6.frame.origin.x
        
        AcademicView.frame.size.width = self.view.frame.size.width - 7 * marginConstant
        CollegeView.frame.size.width = self.view.frame.size.width - 7 * marginConstant
        VolunteeringView.frame.size.width = self.view.frame.size.width - 7 * marginConstant
        SportsView.frame.size.width = self.view.frame.size.width - 7 * marginConstant
        ASBView.frame.size.width = self.view.frame.size.width - 7 * marginConstant
        PerformingView.frame.size.width = self.view.frame.size.width - 7 * marginConstant
        
        
    }
    
    func setupGradient(gradientLayer : CAGradientLayer, height: CGFloat, pos: CGFloat){
        let greyColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        gradientLayer.colors = [UIColor.white.cgColor, greyColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame.size.width = self.view.frame.size.width
        gradientLayer.frame.size.height = height
        gradientLayer.frame.origin.x = 0.0
        gradientLayer.frame.origin.y = pos
        ContainerView.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    func startAnimatingLoadingImage(LoadingImage: UIImageView){
        
        let imageArray: NSMutableArray = []
        for count in 1...10{
            let img = UIImage(named: "toastGif\(count).png")
            imageArray.add(img)
        }
        LoadingImage.animationDuration = 1.0
        LoadingImage.animationImages = imageArray as! [UIImage]
        LoadingImage.startAnimating()
        
    }
    
//    func scrollToTop(){
//        self.ScrollView.isScrollEnabled = false
//        print("asdsasa")
//        
//    }
    
    func makeHTMLStringParametered(URl : String) -> String{
        let WebUrl = URl
        guard let myURL = URL(string: WebUrl) else {
            return "Error: \(WebUrl) doesn't seem to be a valid URL"
        }
        
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
            return myHTMLString
        } catch let error {
            print("Error: \(error)")
        }
        return "Error"
    }
        
    func htmlToStringParametered(HTML_String_Method : String) -> String{
        var EncodedString = HTML_String_Method
        let data = EncodedString.data(using: String.Encoding.utf8, allowLossyConversion: true)
        var attrStr = try! NSAttributedString(
            data: data!,
            options: [ NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.rtf],
            documentAttributes: nil)
        return attrStr.string
        //print(attrStr.string)
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
                DispatchQueue.main.async {
                    self.Label1.attributedText = self.makeAttributedStringBig(title: post[0].title, message: post[0].message)
                    self.Label1.sizeToFit()
                    self.Image1Label.frame.origin.y = self.Image1.frame.origin.y + self.Image1.frame.size.height + self.separationConstant
                    self.Label1.frame.origin.y = self.Image1Label.frame.origin.y + self.Image1Label.frame.size.height + self.separationConstant
                    self.Image2.frame.origin.y = self.Label1.frame.origin.y + self.Label1.frame.size.height + self.separationConstant
                    self.Image3.frame.origin.y = self.Label1.frame.origin.y + self.Label1.frame.size.height + self.separationConstant
                    
                    self.Label2.attributedText = self.makeAttributedStringSmall(title: post[1].title, message: post[1].message)
                    self.Label2.sizeToFit()
                    self.Image2Label.frame.origin.y = self.Image3.frame.origin.y + self.Image3.frame.size.height + self.separationConstant + 5.0
                    self.Label2.frame.origin.y = self.Image2Label.frame.origin.y + self.Image2Label.frame.size.height + self.separationConstant
                    
                    self.Label3.attributedText = self.makeAttributedStringSmall(title: post[2].title, message: post[2].message)
                    self.Label3.sizeToFit()
                    self.Image3Label.frame.origin.y = self.Image2.frame.origin.y + self.Image2.frame.size.height + self.separationConstant + 5.0
                    self.Label3.frame.origin.y = self.Image2Label.frame.origin.y + self.Image2Label.frame.size.height + self.separationConstant
                    
                    if(self.Label2.frame.size.height > self.Label3.frame.size.height || self.Label2.frame.size.height == self.Label3.frame.size.height){
                        self.StudentBulletinImage.frame.origin.y = self.Label2.frame.origin.y + self.Label2.frame.size.height + (self.separationConstant * 3)
                        self.setupGradient(gradientLayer: self.gradientLayer1, height: self.Label2.frame.origin.y + self.Label2.frame.size.height + self.separationConstant * 2, pos: 0.0)
                    } else { self.StudentBulletinImage.frame.origin.y = self.Label3.frame.origin.y + self.Label3.frame.size.height + (self.separationConstant * 3)
                        self.setupGradient(gradientLayer: self.gradientLayer1, height: self.Label3.frame.origin.y + self.Label3.frame.size.height + self.separationConstant * 2, pos: 0.0)
                    }
                    
                    self.AcademicLabel.frame.origin.y = self.StudentBulletinImage.frame.origin.y + self.StudentBulletinImage.frame.size.height + self.separationConstant
                    self.AcademicImage.frame.origin.y = self.StudentBulletinImage.frame.origin.y + self.StudentBulletinImage.frame.size.height + self.separationConstant
                    self.AcademicView.frame.origin.y = self.AcademicLabel.frame.origin.y + self.AcademicLabel.frame.size.height
                 
                    self.CollegeLabel.frame.origin.y = self.AcademicView.frame.origin.y + self.AcademicView.frame.size.height + self.separationConstant
                    self.CollegeImage.frame.origin.y = self.AcademicView.frame.origin.y + self.AcademicView.frame.size.height + self.separationConstant
                    self.CollegeView.frame.origin.y = self.CollegeLabel.frame.origin.y + self.CollegeLabel.frame.size.height
                    
                    self.PerformingLabel.frame.origin.y = self.CollegeView.frame.origin.y + self.CollegeView.frame.size.height + self.separationConstant
                    self.PerformingImage.frame.origin.y = self.CollegeView.frame.origin.y + self.CollegeView.frame.size.height + self.separationConstant
                    self.PerformingView.frame.origin.y = self.PerformingLabel.frame.origin.y + self.PerformingLabel.frame.size.height
                    
                    self.VolunteeringLabel.frame.origin.y = self.PerformingView.frame.origin.y + self.PerformingView.frame.size.height + self.separationConstant
                    self.VolunteeringImage.frame.origin.y = self.PerformingView.frame.origin.y + self.PerformingView.frame.size.height + self.separationConstant
                    self.VolunteeringView.frame.origin.y = self.VolunteeringLabel.frame.origin.y + self.VolunteeringLabel.frame.size.height
                    
                    self.ASBLabel.frame.origin.y = self.VolunteeringView.frame.origin.y + self.VolunteeringView.frame.size.height + self.separationConstant
                    self.ASBImage.frame.origin.y = self.VolunteeringView.frame.origin.y + self.VolunteeringView.frame.size.height + self.separationConstant
                    self.ASBView.frame.origin.y = self.ASBLabel.frame.origin.y + self.ASBLabel.frame.size.height
                    
                    self.SportsLabel.frame.origin.y = self.ASBView.frame.origin.y + self.ASBView.frame.size.height + self.separationConstant
                    self.SportImage.frame.origin.y = self.ASBView.frame.origin.y + self.ASBView.frame.size.height + self.separationConstant
                    self.SportsView.frame.origin.y = self.SportsLabel.frame.origin.y + self.SportsLabel.frame.size.height
                    
                    self.setupGradient(gradientLayer: self.gradientLayer2, height: self.SportsView.frame.origin.y - self.StudentBulletinImage.frame.origin.y + self.SportsView.frame.size.height, pos: self.StudentBulletinImage.frame.origin.y )
                    
                    self.CampusLabel.frame.origin.y = self.SportsView.frame.origin.y + self.SportsView.frame.size.height + (self.separationConstant * 3)
                    self.Image4.frame.origin.y = self.CampusLabel.frame.origin.y + self.CampusLabel.frame.size.height + (self.separationConstant * 3)
                    
                    self.Label4.attributedText = self.makeAttributedStringBig(title: post[3].title, message: post[3].message)
                    self.Label4.sizeToFit()
                    self.Image4Label.frame.origin.y = self.Image4.frame.origin.y + self.Image4.frame.size.height + self.separationConstant
                    self.Label4.frame.origin.y = self.Image4Label.frame.origin.y + self.Image4Label.frame.size.height + self.separationConstant
                    self.Image5.frame.origin.y = self.Label4.frame.origin.y + self.Label4.frame.size.height + self.separationConstant
                    self.Image6.frame.origin.y = self.Label4.frame.origin.y + self.Label4.frame.size.height + self.separationConstant
                    
                    print("label")
                    self.Label5.attributedText = self.makeAttributedStringSmall(title: post[4].title, message: post[4].message)
                    self.Label5.sizeToFit()
                    self.Image5Label.frame.origin.y = self.Image5.frame.origin.y + self.Image5.frame.size.height + self.separationConstant
                    self.Label5.frame.origin.y = self.Image5Label.frame.origin.y + self.Image5Label.frame.size.height + self.separationConstant
                    self.Label6.attributedText = self.makeAttributedStringSmall(title: post[5].title, message: post[5].message)
                    self.Label6.sizeToFit()
                    self.Image6Label.frame.origin.y = self.Image5.frame.origin.y + self.Image5.frame.size.height + self.separationConstant
                    self.Label6.frame.origin.y = self.Image6Label.frame.origin.y + self.Image6Label.frame.size.height + self.separationConstant
                    
                    if(self.Label5.frame.size.height > self.Label6.frame.size.height || self.Label5.frame.size.height == self.Label6.frame.size.height){
                        self.ViewHeight.constant = self.Label5.frame.origin.y + self.Label5.frame.size.height + (self.separationConstant * 3)
                        
                    } else { self.ViewHeight.constant = self.Label6.frame.origin.y + self.Label6.frame.size.height + (self.separationConstant * 3)}
                    
                    self.makeAttributedStringCaption(caption: post[0].message, lab: self.Image1Label)
                    self.makeAttributedStringCaption(caption: post[1].message, lab: self.Image2Label)
                    self.makeAttributedStringCaption(caption: post[2].message, lab: self.Image3Label)
                    self.makeAttributedStringCaption(caption: post[3].message, lab: self.Image4Label)
                    self.makeAttributedStringCaption(caption: post[4].message, lab: self.Image5Label)
                    self.makeAttributedStringCaption(caption: post[5].message, lab: self.Image6Label)
                    
                    self.setupGradient(gradientLayer: self.gradientLayer3, height: self.Label5.frame.origin.y - self.CampusLabel.frame.origin.y + self.Label5.frame.size.height + (3 * self.separationConstant), pos: self.CampusLabel.frame.origin.y)
                    self.AcademicView.attributedText = self.makeAttributedStringSmall(title: post[6].message, message: ""   )
                    self.CollegeView.attributedText = self.makeAttributedStringSmall(title: post[7].message, message: "")
                    self.PerformingView.attributedText = self.makeAttributedStringSmall(title: post[8].message, message: "")
                    self.VolunteeringView.attributedText = self.makeAttributedStringSmall(title: post[9].message, message: "")
                    self.ASBView.attributedText = self.makeAttributedStringSmall(title: post[10].message, message: "")
                    self.SportsView.attributedText = self.makeAttributedStringSmall(title: post[11].message, message: "")
                    
                    
                    self.Image1.downloadedFrom(link: post[0].topic, contentMode: UIView.ContentMode.scaleAspectFill)
                    self.Image1.layer.cornerRadius = 4
                    self.Image1.layer.masksToBounds = true
                    
                    self.Image2.downloadedFrom(link: post[1].topic, contentMode: UIView.ContentMode.scaleAspectFill)
                    self.Image2.layer.cornerRadius = 4
                    self.Image2.layer.masksToBounds = true
                    
                    self.Image3.downloadedFrom(link: post[2].topic, contentMode: UIView.ContentMode.scaleAspectFill)
                    self.Image3.layer.cornerRadius = 4
                    self.Image3.layer.masksToBounds = true
                    
                    self.Image4.downloadedFrom(link: post[3].topic, contentMode: UIView.ContentMode.scaleAspectFill)
                    self.Image4.layer.cornerRadius = 4
                    self.Image4.layer.masksToBounds = true
                    
                    self.Image5.downloadedFrom(link: post[4].topic, contentMode: UIView.ContentMode.scaleAspectFill)
                    self.Image5.layer.cornerRadius = 4
                    self.Image5.layer.masksToBounds = true
                    
                    self.Image6.downloadedFrom(link: post[5].topic, contentMode: UIView.ContentMode.scaleAspectFill)
                    self.Image6.layer.cornerRadius = 4
                    self.Image6.layer.masksToBounds = true

                    
                    
                    self.ripToast()
                }
                
            } catch _ {
               print("JSON Error")
            }
            
            }.resume()
    }
    
    func makeAttributedStringSmall(title: String, message: String) -> NSMutableAttributedString{
        
        let greyColor = UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        let paragraphLineSpacing = NSMutableParagraphStyle()
        paragraphLineSpacing.lineSpacing = 2
        
        
        let titleAttributes = [ NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font: UIFont(name: "MyriadPro-Bold", size: 16.0)!]
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
    
    
    
    @IBAction func image1Pressed(_ sender: UITapGestureRecognizer) {
        print("asdas")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "PopOverViewController") as! PopOverViewController
        PassedTitle.append(Label1.attributedText!)
        PassedURL = "http://arcadiaprojectapp.xyz/version%201%20php/Home%20Page/fullarticles.php"
        PassedImage = Image1.image!
        PassedIndex = 0
        self.present(tab, animated:true, completion:nil)
    }
    
    @IBAction func image2Pressed(_ sender: UITapGestureRecognizer) {
        print("asduasdoi")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "PopOverViewController") as! PopOverViewController
        PassedTitle.append(Label2.attributedText!)
        PassedURL = "http://arcadiaprojectapp.xyz/version%201%20php/Home%20Page/fullarticles.php"
        PassedImage = Image2.image!
        PassedIndex = 1
        self.present(tab, animated:true, completion:nil)
    }
    
    @IBAction func image3Pressed(_ sender: UITapGestureRecognizer) {
        print("asodaiosd")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "PopOverViewController") as! PopOverViewController
        PassedTitle.append(Label3.attributedText!)
        PassedURL = "http://arcadiaprojectapp.xyz/version%201%20php/Home%20Page/fullarticles.php"
        PassedImage = Image3.image!
        PassedIndex = 2
        self.present(tab, animated:true, completion:nil)
    }
    
    @IBAction func image4Pressed(_ sender: UITapGestureRecognizer) {
        print("asdasd")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "PopOverViewController") as! PopOverViewController
        PassedTitle.append(Label4.attributedText!)
        PassedURL = "http://arcadiaprojectapp.xyz/version%201%20php/Home%20Page/fullarticles.php"
        PassedImage = Image4.image!
        PassedIndex = 3
        self.present(tab, animated:true, completion:nil)
    }
    
    @IBAction func image5Pressed(_ sender: UITapGestureRecognizer) {
        print("asdasd")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "PopOverViewController") as! PopOverViewController
        PassedTitle.append(Label5.attributedText!)
        PassedURL = "http://arcadiaprojectapp.xyz/version%201%20php/Home%20Page/fullarticles.php"
        PassedImage = Image5.image!
        PassedIndex = 4
        self.present(tab, animated:true, completion:nil)
        
    }
    @IBAction func image6Pressed(_ sender: UITapGestureRecognizer) {
        print("asdasd")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "PopOverViewController") as! PopOverViewController
        PassedTitle.append(Label6.attributedText!)
        PassedURL = "http://arcadiaprojectapp.xyz/version%201%20php/Home%20Page/fullarticles.php"
        PassedImage = Image6.image!
        PassedIndex = 5
        self.present(tab, animated:true, completion:nil)
    }
    
    @IBAction func Label1Pressed(_ sender: UITapGestureRecognizer) {
        print("asdasd")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "PopOverViewController") as! PopOverViewController
        PassedTitle.append(Label1.attributedText!)
        PassedURL = "http://arcadiaprojectapp.xyz/version%201%20php/Home%20Page/fullarticles.php"
        PassedImage = Image1.image!
        PassedIndex = 0
        self.present(tab, animated:true, completion:nil)
    }
    
    @IBAction func Label2Pressed(_ sender: UITapGestureRecognizer) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "PopOverViewController") as! PopOverViewController
        PassedTitle.append(Label2.attributedText!)
        PassedURL = "http://arcadiaprojectapp.xyz/version%201%20php/Home%20Page/fullarticles.php"
        PassedImage = Image2.image!
        PassedIndex = 1
        self.present(tab, animated:true, completion:nil)
    }
    
    @IBAction func Label3Pressed(_ sender: UITapGestureRecognizer) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "PopOverViewController") as! PopOverViewController
        PassedTitle.append(Label3.attributedText!)
        PassedURL = "http://arcadiaprojectapp.xyz/version%201%20php/Home%20Page/fullarticles.php"
        PassedImage = Image3.image!
        PassedIndex = 2
        self.present(tab, animated:true, completion:nil)
    }
    
    @IBAction func Label4Pressed(_ sender: UITapGestureRecognizer) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "PopOverViewController") as! PopOverViewController
        PassedTitle.append(Label4.attributedText!)
        PassedURL = "http://arcadiaprojectapp.xyz/version%201%20php/Home%20Page/fullarticles.php"
        PassedImage = Image4.image!
        PassedIndex = 3
        self.present(tab, animated:true, completion:nil)
    }
    
    @IBAction func Label5Pressed(_ sender: UITapGestureRecognizer) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "PopOverViewController") as! PopOverViewController
        PassedTitle.append(Label5.attributedText!)
        PassedURL = "http://arcadiaprojectapp.xyz/version%201%20php/Home%20Page/fullarticles.php"
        PassedImage = Image5.image!
        PassedIndex = 4
        self.present(tab, animated:true, completion:nil)
    }
    
    @IBAction func Label6Pressed(_ sender: UITapGestureRecognizer) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "PopOverViewController") as! PopOverViewController
        PassedTitle.append(Label6.attributedText!)
        PassedURL = "http://arcadiaprojectapp.xyz/version%201%20php/Home%20Page/fullarticles.php"
        PassedImage = Image6.image!
        PassedIndex = 5
        self.present(tab, animated:true, completion:nil)
    }
    
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "NavViewController") as! NavViewController
        self.present(tab, animated:true, completion:nil)
    }
    
    func goToAcademics(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "AcademicViewController") as! AcademicViewController
        self.present(tab, animated:true, completion:nil)
    }
    
    func goToCollege(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "CollegeViewController") as! CollegeViewController
        self.present(tab, animated:true, completion:nil)
    }
    
    func goToPerforming(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "PerformingViewController") as! PerformingViewController
        self.present(tab, animated:true, completion:nil)
    }
    
    func goToVolunteering(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "VolunteeringViewController") as! VolunteeringViewController
        self.present(tab, animated:true, completion:nil)
    }
    
    func goToASB(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "MoreViewController") as! MoreViewController
        self.present(tab, animated:true, completion:nil)
    }
    
    func goToSports(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "SportViewController") as! SportViewController
        self.present(tab, animated:true, completion:nil)
    }
    
    @IBAction func AcademicLabelPressed(_ sender: UITapGestureRecognizer) {
        self.goToAcademics()
    }
    
    @IBAction func CollegeLabelPressed(_ sender: UITapGestureRecognizer) {
        self.goToCollege()
    }
    
    @IBAction func PerformingLabelPressed(_ sender: UITapGestureRecognizer) {
        self.goToPerforming()
    }
    
    @IBAction func VolunteeringLabelPressed(_ sender: UITapGestureRecognizer) {
        self.goToVolunteering()
    }
    
    @IBAction func ASBLabelPressed(_ sender: UITapGestureRecognizer) {
        self.goToASB()
    }
    
    @IBAction func SportLabelPressed(_ sender: UITapGestureRecognizer) {
        self.goToSports()
    }
    
    @IBAction func AcademicImagePressed(_ sender: UITapGestureRecognizer) {
        self.goToAcademics()
    }
    
    @IBAction func CollegeImagePressed(_ sender: UITapGestureRecognizer) {
        self.goToCollege()
    }
    
    @IBAction func PerformingImagePressed(_ sender: UITapGestureRecognizer) {
        self.goToPerforming()
    }
    
    @IBAction func VolunteeringImagePressed(_ sender: UITapGestureRecognizer) {
        self.goToVolunteering()
    }
    
    @IBAction func ASBImagePressed(_ sender: UITapGestureRecognizer) {
        self.goToASB()
    }
    
    @IBAction func SportsImagePressed(_ sender: UITapGestureRecognizer) {
        self.goToSports()
    }
    
    @IBAction func AcademicsViewPressed(_ sender: UITapGestureRecognizer) {
        self.goToAcademics()
    }
    
    @IBAction func CollegViewPresed(_ sender: UITapGestureRecognizer) {
        self.goToCollege()
    }
    
    @IBAction func PerformingViewPressed(_ sender: UITapGestureRecognizer) {
        self.goToPerforming()
    }
    
    @IBAction func VolunteeringViewPressed(_ sender: UITapGestureRecognizer) {
        self.goToVolunteering()
    }
    
    @IBAction func ASBViewPressed(_ sender: UITapGestureRecognizer) {
        self.goToASB()
    }
    
    @IBAction func SportsViewPressed(_ sender: UITapGestureRecognizer) {
        self.goToSports()
    }
    
    
}
