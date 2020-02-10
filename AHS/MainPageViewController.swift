//
//  MainPageViewController.swift
//  AHS
//
//  Created by Jason Zhao on 2/7/18.
//  Copyright © 2018 Jason Zhao. All rights reserved.
//

import UIKit

struct PostBulletin : Decodable{
    let id: String
    let title : String
    let message : String
    
}

struct Post : Decodable{
    
    let topic : String
    let title : String
    let message : String
    
}

struct Article : Decodable{
    let link : String
    let title : String
}

class MyTapGesture: UITapGestureRecognizer {
    var index : Int = 0
    var id = String()
    var image = UIImage()
    var title = String()
    var message = String()
}


extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}

var cancelDownload : Bool  = false

class MainPageViewController: UIViewController {
    
    //let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    //let tab = storyBoard.instantiateViewController(withIdentifier: "PopOverViewController") as! PopOverViewController

    var largeArticleWidth : CGFloat = 0.0
    var largeArticleHeight : CGFloat = 0.0
    
    var largeImageWidth  : CGFloat = 0.0
    var largeImageHeight  : CGFloat = 0.0
    
    var captionWidth  : CGFloat = 0.0
    var captionHeight  : CGFloat = 0.0
    
    var smallArticleWidth : CGFloat  = 0.0
    var smallArticleHeight  : CGFloat = 0.0
    
    var smallImageWidth : CGFloat = 0.0
    var smallImageHeight : CGFloat = 0.0
    
    var largeBlockWidth  : CGFloat = 0.0
    var largeBlockHeight  : CGFloat = 0.0
    
    var smallBlockWidth : CGFloat  = 0.0
    var smallBlockHeight : CGFloat  = 0.0
    
    
    var pos : CGFloat = 0.0
    
    @IBOutlet var ScrollView: UIScrollView!
    @IBOutlet var GreyLine: UIImageView!
    @IBOutlet var Topicon: UIImageView!
    
    var dayLabel = UILabel()
    var dateLabel = UILabel()
    
    var studentBulletinLabel = UILabel()
    var recentLabel = UILabel()
    
    var AcademicsImage = UIImageView()
    var AcademicsLabel = UILabel()
    var AcademicsView = UITextView()
    
    var CollegeImage = UIImageView()
    var CollegeLabel = UILabel()
    var CollegeView = UITextView()
    
    var PerformingImage = UIImageView()
    var PerformingLabel = UILabel()
    var PerforrmingView = UITextView()
    
    var VolunteeringImage = UIImageView()
    var VolunteeringLabel = UILabel()
    var VolunteeringView = UITextView()
    
    var ASBImage = UIImageView()
    var ASBLabel = UILabel()
    var ASBView = UITextView()
    
    var SportImage = UIImageView()
    var SportLabel = UILabel()
    var SportView = UITextView()
    
    var firstLabel = UILabel()
    var secondLabel = UILabel()
    
    var gradientLayer1 = CAGradientLayer()
    var gradientLayer2 = CAGradientLayer()
    var gradientLayer3 = CAGradientLayer()
    
    var refresh = UIRefreshControl()
    let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
    
    override func viewDidAppear(_ animated: Bool) {
        if(!cancelDownload){
            self.JSONToTextView(urlstring: "http://ahsmobile.ausd.net:8080/AHS-Mobile/home-front-json.jsp", descriptionString: "http://arcadiaprojectapp.xyz/version%201%20php/News%20Page/FullArticle.php")
            
        }
        self.ScrollView.contentSize.height = self.pos
        cancelDownload = true

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeightsAndWidths()
        setupTop()
        setupStatusBar()
        setupRefresh()
        checkUserDef()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupStatusBar(){
        //let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
    }
    
    func checkUserDef(){
        if(UserDef.array(forKey: "NotificationOpened") == nil){
            let array = [" "," "]
            UserDef.set(array, forKey: "NotificationOpened")
        }
    }
    
    func setupRefresh(){
        _ = NSLocalizedString("Pull To Refresh", comment: "Pull to refresh")
        refresh.attributedTitle = NSAttributedString(string: "")
        refresh.addTarget(self, action: #selector(refreshAction(sender:)),for: .valueChanged)
        
        ScrollView.addSubview(refresh)
    }
    
    @objc func refreshAction(sender: AnyObject!){
        
        self.JSONToTextViewRefresh(urlstring: "http://ahsmobile.ausd.net:8080/AHS-Mobile/home-front-json.jsp", descriptionString: "http://arcadiaprojectapp.xyz/version%201%20php/News%20Page/FullArticle.php")
        self.ScrollView.contentSize.height = self.pos
        refresh.endRefreshing()
    }

    func setupHeightsAndWidths(){
        
        largeBlockWidth = self.view.frame.size.width
        largeBlockHeight = self.view.frame.size.height * 0.5
        
        smallBlockWidth = (largeBlockWidth * 0.93) / 2 // largeimagewidth halfed
        smallBlockHeight = self.view.frame.size.height * 0.35
        
        largeArticleWidth = 0.0
        largeArticleHeight = 0.0
        
        largeImageWidth = largeBlockWidth * 0.93
        largeImageHeight = largeBlockHeight * 0.63
        
        captionWidth = 0.0
        captionHeight = 0.0
        
        smallArticleWidth = 0.0
        smallArticleHeight = 0.0
        
        smallImageWidth = smallBlockWidth * 0.96
        smallImageHeight = smallBlockHeight * 0.55
    }
    
    func setupTop(){
        
        
        dayLabel.frame.size.width = self.view.frame.size.width
        dayLabel.frame.size.height = self.view.frame.size.height * 0.06
        dayLabel.frame.origin.x = 15.0
        dayLabel.frame.origin.y = UIApplication.shared.statusBarFrame.height + 10.0
        dayLabel.attributedText = self.makeAttributedDate(title: "Friday")
        dayLabel.backgroundColor = UIColor.clear
        ScrollView.addSubview(dayLabel)

        dateLabel.frame.size.width = self.view.frame.size.width
        dateLabel.frame.size.height = self.view.frame.size.height * 0.06
        dateLabel.frame.origin.x = 15.0
        dateLabel.frame.origin.y = dayLabel.frame.origin.y + dayLabel.frame.size.height
        dateLabel.attributedText = self.makeAttributedDate(title: "Feb 9")
        dateLabel.backgroundColor = UIColor.clear
        ScrollView.addSubview(dateLabel)

        pos = dateLabel.frame.origin.y + dateLabel.frame.size.height
        
        GreyLine.frame.origin.y = dateLabel.frame.origin.y + dateLabel.frame.size.height
        GreyLine.frame.size.width = self.view.frame.size.width * 0.915
        GreyLine.center.x = self.view.center.x
        pos = GreyLine.frame.size.height + GreyLine.frame.origin.y
        
        Topicon.frame.size.width = self.view.frame.size.width * 0.18
        Topicon.frame.size.height = Topicon.frame.size.width
        Topicon.center.y = dayLabel.frame.origin.y + dayLabel.frame.size.height
        Topicon.frame.origin.x = self.view.frame.size.width - Topicon.frame.size.width - 25.0
        Topicon.layer.cornerRadius = 4
        Topicon.layer.masksToBounds = true
        
        let imgListArray :NSMutableArray = []
        for countValue in 1...10
        {
            
            let strImageName : String = "toastGif\(countValue).png"
            let image  = UIImage(named:strImageName)
            imgListArray.add(image)
        }
        
        let easterEggTap = UITapGestureRecognizer(target: self, action: #selector(self.easterEgg(_:)))
        Topicon.addGestureRecognizer(easterEggTap)
        Topicon.animationImages = imgListArray as! [UIImage]
        Topicon.animationDuration = 1.0
        Topicon.isUserInteractionEnabled = true
        
        let date = Date()
        let calendar = Calendar.current
        
        _ = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let dayOfWeek = Date().dayNumberOfWeek()
        
        if(dayOfWeek == 1){
            dayLabel.attributedText = self.makeAttributedDate(title: "Sunday")
        }else if(dayOfWeek == 2){
            dayLabel.attributedText = self.makeAttributedDate(title: "Monday")
        }else if(dayOfWeek == 3){
            dayLabel.attributedText = self.makeAttributedDate(title: "Tuesday")
        }else if(dayOfWeek == 4){
            dayLabel.attributedText = self.makeAttributedDate(title: "Wednesday")
        }else if(dayOfWeek == 5){
            dayLabel.attributedText = self.makeAttributedDate(title: "Thursday")
        }else if(dayOfWeek == 6){
            dayLabel.attributedText = self.makeAttributedDate(title: "Friday")
        }else{
            dayLabel.attributedText = self.makeAttributedDate(title: "Saturday")
        }
        
        if(month == 1){
            dateLabel.attributedText = self.makeAttributedDate(title: "Jan " + String(day))
        }else if(month == 2){
            dateLabel.attributedText = self.makeAttributedDate(title: "Feb " + String(day))
        }else if(month == 3){
            dateLabel.attributedText = self.makeAttributedDate(title: "March " + String(day))
        }else if(month == 4){
            dateLabel.attributedText = self.makeAttributedDate(title: "April " + String(day))
        }else if(month == 5){
            dateLabel.attributedText = self.makeAttributedDate(title: "May " + String(day))
        }else if(month == 6){
            dateLabel.attributedText = self.makeAttributedDate(title: "June " + String(day))
        }else if(month == 7){
            dateLabel.attributedText = self.makeAttributedDate(title: "July " + String(day))
        }else if(month == 8){
            dateLabel.attributedText = self.makeAttributedDate(title: "Aug " + String(day))
        }else if(month == 9){
            dateLabel.attributedText = self.makeAttributedDate(title: "Sept " + String(day))
        }else if(month == 10){
            dateLabel.attributedText = self.makeAttributedDate(title: "Oct " + String(day))
        }else if(month == 11){
            dateLabel.attributedText = self.makeAttributedDate(title: "Nov " + String(day))
        }else{
            dateLabel.attributedText = self.makeAttributedDate(title: "Dec " + String(day))
        }
    }
    
    @objc func easterEgg(_ sender: UITapGestureRecognizer){
        if(Topicon.isAnimating){
            Topicon.stopAnimating()
        }else{
            Topicon.startAnimating()
        }
    }

    
    func setupStudentBulletin(acaString: String, CollegeString: String, VolString: String, clubsString: String, SportString: String, ASBString: String){
        //setup Images
        
        studentBulletinLabel.attributedText = self.makeAttributedStringBulletin(title: "STUDENT BULLETIN", message: "")
        studentBulletinLabel.frame.size.width = self.view.frame.size.width
        studentBulletinLabel.frame.size.height = self.view.frame.size.height * 0.07
        studentBulletinLabel.frame.origin.x = self.view.frame.size.width * 0.03
        studentBulletinLabel.frame.origin.y = pos + 10.0
        studentBulletinLabel.backgroundColor = UIColor.clear
        pos = studentBulletinLabel.frame.size.height + studentBulletinLabel.frame.origin.y
        self.ScrollView.addSubview(studentBulletinLabel)
        
        recentLabel.attributedText = self.makeAttributedStringSmall(title: "RECENT", message: "")
        recentLabel.frame.size.width = self.view.frame.size.width
        recentLabel.frame.size.height = self.view.frame.size.height * 0.026
        recentLabel.frame.origin.x = studentBulletinLabel.frame.origin.x
        recentLabel.frame.origin.y = pos + 10.0
        recentLabel.backgroundColor = UIColor.clear
        pos = recentLabel.frame.size.height + recentLabel.frame.origin.y
        self.ScrollView.addSubview(recentLabel)
        
        self.makeBulletinBlock(image: UIImage(named: "AcademicsIcon")!, title: "Academics", description: acaString)
        print(AcademicsView.attributedText.string)
        self.makeBulletinBlock(image: UIImage(named: "CounselingIcon")!, title: "College Opportunity", description: CollegeString)
        print(CollegeView.attributedText.string)
        self.makeBulletinBlock(image: UIImage(named: "VolunteerIcon")!, title: "Volunteering", description: VolString)
        self.makeBulletinBlock(image: UIImage(named: "ASBIcon")!, title: "Clubs", description: clubsString)
        self.makeBulletinBlock(image: UIImage(named: "SportsIcon")!, title: "Athletics", description: SportString)
        self.makeBulletinBlock(image: UIImage(named: "OthersIcon")!, title: "Other", description: ASBString)
        
        
    }
    
    func setupFirstLabel(){
        firstLabel.attributedText = self.makeAttributedStringBulletin(title: "DISTRICT NEWS", message: "")
        firstLabel.frame.size.width = self.view.frame.size.width
        firstLabel.frame.size.height = self.view.frame.size.height * 0.05
        firstLabel.frame.origin.x = self.view.frame.size.width * 0.03
        firstLabel.backgroundColor = UIColor.clear
        firstLabel.frame.origin.y = pos
        pos = firstLabel.frame.size.height + firstLabel.frame.origin.y
        self.ScrollView.addSubview(firstLabel)
    }
    
    func setupSecondLabel(){
        secondLabel.attributedText = self.makeAttributedStringBulletin(title: "MORE NEWS", message: "")
        secondLabel.frame.size.width = self.view.frame.size.width
        secondLabel.frame.size.height = self.view.frame.size.height * 0.05
        secondLabel.frame.origin.x = self.view.frame.size.width * 0.03
        secondLabel.frame.origin.y = pos + 30.0
        secondLabel.backgroundColor = UIColor.clear
        pos = secondLabel.frame.size.height + secondLabel.frame.origin.y
        self.ScrollView.addSubview(secondLabel)
    }
    
    func makeBulletinBlock(image: UIImage, title: String, description: String){
        
        let view = UIView()
        view.frame.size.width = self.view.frame.size.width
        view.frame.size.height = self.view.frame.size.height * 0.15
        view.center.x = self.view.center.x
        view.frame.origin.y = pos
        view.isUserInteractionEnabled = true
        //view.backgroundColor = UIColor.blue
        pos = view.frame.size.height + view.frame.origin.y - 10.0
        self.ScrollView.addSubview(view)
        
        
        let imageView = UIImageView()
        imageView.frame.size.width = self.view.frame.size.width * 0.129
        imageView.frame.size.height = AcademicsImage.frame.size.width
        imageView.frame.origin.x = studentBulletinLabel.frame.origin.x
        imageView.frame.origin.y = view.frame.size.height / 2
        imageView.image = image
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        //imageView.backgroundColor = UIColor.gray
        view.addSubview(imageView)
        

        let label = UILabel()
        label.frame.size.width = self.view.frame.size.width
        label.frame.size.height = view.frame.size.height * 0.3125
        label.frame.origin.x = imageView.frame.origin.x + imageView.frame.size.width + 10.0
        label.frame.origin.y = view.frame.size.height * 0.13
        label.attributedText = self.makeAttributedBulletinTop(title: title, message: "")
        label.backgroundColor = UIColor.clear
        view.addSubview(label)
        
        let des = UITextView()
        des.isScrollEnabled = false
        des.isEditable = false
        des.frame.size.width = self.view.frame.size.width * 0.80
        des.frame.size.height = view.frame.size.height * 0.70
        des.frame.origin.x = imageView.frame.origin.x + imageView.frame.size.width + 10.0
        des.frame.origin.y = label.frame.origin.y + label.frame.size.height - 10.0
        des.attributedText = self.makeAttributedBulletinBot(title: description, message: "")
        des.backgroundColor = UIColor.clear
        des.textContainer.maximumNumberOfLines = 4
        des.textContainer.lineBreakMode = .byTruncatingTail
        view.addSubview(des)
        
        var tap = UITapGestureRecognizer()
        
        if(title == "Academics"){
             tap = UITapGestureRecognizer(target: self, action: #selector(self.goToAcademics))
        }else if(title == "College Opportunity"){
             tap = UITapGestureRecognizer(target: self, action: #selector(self.goToCollege))
        }else if(title == "Volunteering"){
             tap = UITapGestureRecognizer(target: self, action: #selector(self.goToVolunteering))
        }else if(title == "Clubs"){
             tap = UITapGestureRecognizer(target: self, action: #selector(self.goToClubs))
        }else if(title == "Athletics"){
             tap = UITapGestureRecognizer(target: self, action: #selector(self.goToSports))
        }else{
            tap = UITapGestureRecognizer(target: self, action: #selector(self.goToOthers))
        }
     
        view.addGestureRecognizer(tap)
    }
    
    func makeSmallBlockLeft(position : CGFloat, link : String, tit: String, cap : String, index: CGFloat){
        let block = UIView()
        block.backgroundColor = UIColor.clear
        block.frame.size.width = smallBlockWidth
        block.frame.size.height = smallBlockHeight
        block.frame.origin.x = (self.view.frame.size.width - largeImageWidth) / 2
        block.frame.origin.y = position
        self.ScrollView.addSubview(block)
        
        
        let imageView = UIImageView()
        imageView.frame.size.width = smallImageWidth
        imageView.frame.size.height = smallImageHeight
        imageView.frame.origin.x = 0.0
        imageView.frame.origin.y = 10.0
        imageView.backgroundColor = UIColor.clear
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        imageView.downloadedFrom(url: URL(string : link)!, contentMode: UIView.ContentMode.scaleAspectFill)
        imageView.clipsToBounds = true
        block.addSubview(imageView)
        
        let captionLabel = UILabel()
        captionLabel.frame.size.width = imageView.frame.size.width
        captionLabel.frame.size.height = imageView.frame.size.height * 0.11
        captionLabel.frame.origin.x = imageView.frame.origin.x
        captionLabel.frame.origin.y = imageView.frame.origin.y + imageView.frame.size.height + 5.0
        //captionLabel.backgroundColor = UIColor.green
        captionLabel.attributedText = self.makeAttributedCaption(title: cap)
        block.addSubview(captionLabel)
        
        let titleLabel = UILabel()
        titleLabel.frame.size.width = imageView.frame.size.width
        titleLabel.frame.size.height = block.frame.size.height * 0.24
        titleLabel.frame.origin.x = imageView.frame.origin.x
        titleLabel.frame.origin.y = captionLabel.frame.origin.y + captionLabel.frame.size.height
        titleLabel.attributedText = self.makeAttributedStringSmall(title: tit, message: "")
        titleLabel.numberOfLines = 3
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.sizeToFit()
        //titleLabel.backgroundColor = UIColor.brown
        //titleLabel.backgroundColor = UIColor.cyan
        block.addSubview(titleLabel)

        let tap = MyTapGesture(target: self, action: #selector(self.handleTap(_:)))
        tap.numberOfTouchesRequired = 1
        tap.numberOfTapsRequired = 1
        tap.index = Int(index - 6)
        //tap.image = imageView.image!
        block.addGestureRecognizer(tap)
    }
    
    func makeSmallBlockRight(position : CGFloat, link : String, tit : String, cap : String, index: CGFloat){
        let block = UIView()
        block.backgroundColor = UIColor.clear
        block.frame.size.width = smallBlockWidth
        block.frame.size.height = smallBlockHeight
        block.frame.origin.x = self.view.center.x
        block.frame.origin.y = position
        self.ScrollView.addSubview(block)
        
        
        
        let imageView = UIImageView()
        imageView.frame.size.width = smallImageWidth
        imageView.frame.size.height = smallImageHeight
        imageView.frame.origin.x = smallBlockWidth - imageView.frame.size.width
        imageView.frame.origin.y = 10.0
        imageView.backgroundColor = UIColor.clear
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        imageView.downloadedFrom(url: URL(string : link)!, contentMode: UIView.ContentMode.scaleAspectFill)
        imageView.clipsToBounds = true
        block.addSubview(imageView)
        
        let captionLabel = UILabel()
        captionLabel.frame.size.width = imageView.frame.size.width
        captionLabel.frame.size.height = imageView.frame.size.height * 0.11
        captionLabel.frame.origin.x = imageView.frame.origin.x
        captionLabel.frame.origin.y = imageView.frame.origin.y + imageView.frame.size.height + 5.0
        //captionLabel.backgroundColor = UIColor.green
        captionLabel.attributedText = self.makeAttributedCaption(title: cap)
        
        block.addSubview(captionLabel)
        
        let titleLabel = UILabel()
        titleLabel.frame.size.width = imageView.frame.size.width
        titleLabel.frame.size.height = block.frame.size.height * 0.24
        titleLabel.frame.origin.x = imageView.frame.origin.x
        titleLabel.frame.origin.y = captionLabel.frame.origin.y + captionLabel.frame.size.height
        titleLabel.attributedText = self.makeAttributedStringSmall(title: tit, message: "")
        titleLabel.numberOfLines = 3
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.sizeToFit()
        //titleLabel.backgroundColor = UIColor.brown
        //titleLabel.backgroundColor = UIColor.cyan
        block.addSubview(titleLabel)

        let tap = MyTapGesture(target: self, action: #selector(self.handleTap(_:)))
        tap.numberOfTouchesRequired = 1
        tap.numberOfTapsRequired = 1
        tap.index = Int(index - 6)
        block.addGestureRecognizer(tap)
    }
    
    func makeLargeBlock(position : CGFloat, link : String, tit : String, cap : String, index: CGFloat){
        let block = UIView()
        block.backgroundColor = UIColor.clear
        block.frame.size.width = largeBlockWidth
        block.frame.size.height = largeBlockHeight
        block.center.x = self.view.center.x
        block.frame.origin.y = position
        self.ScrollView.addSubview(block)
        
        let imageView = UIImageView()
        imageView.frame.size.width = largeImageWidth
        imageView.frame.size.height = largeImageHeight
        imageView.center.x = block.center.x
        imageView.frame.origin.y = 10.0
        imageView.backgroundColor = UIColor.clear
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        imageView.downloadedFrom(url: URL(string : link)!, contentMode: UIView.ContentMode.scaleAspectFill)
        imageView.clipsToBounds = true
        block.addSubview(imageView)
        

        let captionLabel = UILabel()
        captionLabel.frame.size.width = imageView.frame.size.width
        captionLabel.frame.size.height = imageView.frame.size.height * 0.07
        captionLabel.frame.origin.x = imageView.frame.origin.x
        captionLabel.frame.origin.y = imageView.frame.origin.y + imageView.frame.size.height + 5.0
        //captionLabel.backgroundColor = UIColor.green
        captionLabel.attributedText = self.makeAttributedCaption(title: cap)
        block.addSubview(captionLabel)
        
        let titleLabel = UILabel()
        titleLabel.frame.size.width = imageView.frame.size.width
        titleLabel.frame.size.height = block.frame.size.height * 0.24


        titleLabel.frame.origin.x = imageView.frame.origin.x
        titleLabel.frame.origin.y = captionLabel.frame.origin.y + captionLabel.frame.size.height
        titleLabel.numberOfLines = 3
        titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel.attributedText = self.makeAttributedStringBig(title: tit, message: "")
        
        titleLabel.sizeToFit()
        
        //titleLabel.backgroundColor = UIColor.brown
        //titleLabel.backgroundColor = UIColor.cyan
       
        block.addSubview(titleLabel)

        self.pos = position + imageView.frame.size.height + captionLabel.frame.size.height + titleLabel.frame.size.height + 25.0
        
        let tap = MyTapGesture(target: self, action: #selector(self.handleTap(_:)))
        tap.numberOfTouchesRequired = 1
        tap.numberOfTapsRequired = 1
        tap.index = Int(index - 6)
        //tap.image = imageView.image!
        block.addGestureRecognizer(tap)
    }
    
    func JSONToTextView(urlstring: String, descriptionString : String) {
        let testURLString = urlstring
        let testURl = URL(string: testURLString)
        
        _ = URLSession.shared.dataTask(with: testURl!){
            (data, response, err) in
            let data = data
            do{
                let articleArray = try JSONDecoder().decode([Post].self, from: data!)
                
                var counter = 0
                var whichBlock = 0.0
                DispatchQueue.main.async {
                    
                    self.setupFirstLabel()
                    print(articleArray[6].topic)
                    self.makeLargeBlock(position: self.pos, link: articleArray[6].topic, tit: articleArray[6].title, cap: articleArray[6].message, index: 6)
                    
                    self.makeSmallBlockLeft(position: self.pos, link: articleArray[7].topic, tit: articleArray[7].title, cap: articleArray[7].message, index: 7)
                    
                    self.makeSmallBlockRight(position: self.pos, link: articleArray[8].topic, tit: articleArray[8].title, cap: articleArray[8].message, index: 8)
                    self.pos += self.smallBlockHeight
                    
                    self.setupStudentBulletin(acaString: articleArray[0].title + " " + articleArray[0].message, CollegeString: articleArray[1].title +  " " + articleArray[1].message, VolString: articleArray[2].title +  " " + articleArray[2].message, clubsString: articleArray[3].title +  " " + articleArray[3].message, SportString: articleArray[4].title +  " " + articleArray[4].message, ASBString: articleArray[5].title +  " " + articleArray[5].message)
                    
                    self.setupGradient(gradientLayer: self.gradientLayer1, height: self.studentBulletinLabel.frame.origin.y + self.studentBulletinLabel.frame.size.height - self.firstLabel.frame.size.height - self.firstLabel.frame.origin.y - 20.0, pos: self.firstLabel.frame.origin.y)
                    
                    self.setupSecondLabel()
                    
                    self.setupGradient(gradientLayer: self.gradientLayer2, height: self.secondLabel.frame.origin.y + self.secondLabel.frame.size.height - self.studentBulletinLabel.frame.size.height - self.studentBulletinLabel.frame.origin.y , pos: self.studentBulletinLabel.frame.origin.y)
                    
                    
                    //9 is the first article that needs to be looped
                    
                    
                    for _ in articleArray{
                        if(counter == 0 || counter == 1 || counter == 2 || counter == 3 || counter == 4 || counter == 5 || counter == 6 || counter == 7 || counter == 8){
                            
                        }else if(whichBlock == 0){
                            self.makeLargeBlock(position: self.pos, link: articleArray[counter].topic, tit: articleArray[counter].title, cap: articleArray[counter].message, index: CGFloat(counter))
                            //self.pos += self.largeBlockHeight
                            whichBlock += 1
                            print(counter)
                        }else if(whichBlock == 1){
                            self.makeSmallBlockLeft(position: self.pos, link: articleArray[counter].topic, tit: articleArray[counter].title, cap: articleArray[counter].message, index: CGFloat(counter))
                             whichBlock += 1
                            print(counter)
                            if(counter + 1 == articleArray.count){
                                self.pos += self.smallBlockHeight + 3.0
                            }
                            
                        }else{
                            self.makeSmallBlockRight(position: self.pos, link: articleArray[counter].topic, tit: articleArray[counter].title, cap: articleArray[counter].message, index: CGFloat(counter))
                            self.pos += self.smallBlockHeight + 3.0
                            whichBlock = 0
                            print(counter)
                        }
                        counter += 1
                        
                    }
                            self.pos += UIApplication.shared.statusBarFrame.height + 10.0 + 35.0
                            self.ScrollView.contentSize.height = self.pos
                    
                    self.setupGradient(gradientLayer: self.gradientLayer3, height: self.pos + self.secondLabel.frame.origin.y + self.secondLabel.frame.size.height, pos: self.secondLabel.frame.origin.y)
                }
                
                    } catch let error {
                            print("Error decoding JSON For Main Text")
                            print(error)
            }
        }.resume()
    }
    
    func JSONToTextViewRefresh(urlstring: String, descriptionString : String) {
        let testURLString = urlstring
        let testURl = URL(string: testURLString)
        
        _ = URLSession.shared.dataTask(with: testURl!){
            (data, response, err) in
            let data = data
            do{
                let articleArray = try JSONDecoder().decode([Post].self, from: data!)
                
                var counter = 0
                var whichBlock = 0.0
                DispatchQueue.main.async {
                    
                    self.pos = self.firstLabel.frame.origin.y + self.firstLabel.frame.size.height
                    
                    for views in self.ScrollView.subviews{
                        if views != self.dayLabel && views != self.dateLabel && views != self.GreyLine  && views != self.Topicon && views != self.firstLabel && views != self.refresh{
                             views.removeFromSuperview()
                        }
                    }
                    
                    //self.setupFirstLabel()
                    print(articleArray[6].topic)
                    self.makeLargeBlock(position: self.pos, link: articleArray[6].topic, tit: articleArray[6].title, cap: articleArray[6].message, index: 6)
                    
                    
                    self.makeSmallBlockLeft(position: self.pos, link: articleArray[7].topic, tit: articleArray[7].title, cap: articleArray[7].message, index: 7)
                    
                    self.makeSmallBlockRight(position: self.pos, link: articleArray[8].topic, tit: articleArray[8].title, cap: articleArray[8].message, index: 8)
                    self.pos += self.smallBlockHeight
                    
                    self.setupStudentBulletin(acaString: articleArray[0].title + articleArray[0].message, CollegeString: articleArray[1].title + articleArray[1].message, VolString: articleArray[2].title + articleArray[2].message, clubsString: articleArray[3].title + articleArray[3].message, SportString: articleArray[4].title + articleArray[4].message, ASBString: articleArray[5].title + articleArray[5].message)
                    
                    self.setupGradient(gradientLayer: self.gradientLayer1, height: self.studentBulletinLabel.frame.origin.y + self.studentBulletinLabel.frame.size.height - self.firstLabel.frame.size.height - self.firstLabel.frame.origin.y - 20.0, pos: self.firstLabel.frame.origin.y)
                    
                    self.setupSecondLabel()
                    
                    self.setupGradient(gradientLayer: self.gradientLayer2, height: self.secondLabel.frame.origin.y + self.secondLabel.frame.size.height - self.studentBulletinLabel.frame.size.height - self.studentBulletinLabel.frame.origin.y , pos: self.studentBulletinLabel.frame.origin.y)
                    //9 is the first article that needs to be looped
                    
                    
                    for _ in articleArray{
                        if(counter == 0 || counter == 1 || counter == 2 || counter == 3 || counter == 4 || counter == 5 || counter == 6 || counter == 7 || counter == 8){
                            
                        }else if(whichBlock == 0){
                            self.makeLargeBlock(position: self.pos, link: articleArray[counter].topic, tit: articleArray[counter].title, cap: articleArray[counter].message, index: CGFloat(counter))
                            //self.pos += self.largeBlockHeight
                            whichBlock += 1
                            print(counter)
                        }else if(whichBlock == 1){
                            self.makeSmallBlockLeft(position: self.pos, link: articleArray[counter].topic, tit: articleArray[counter].title, cap: articleArray[counter].message, index: CGFloat(counter))
                            whichBlock += 1
                            print(counter)
                            if(counter + 1 == articleArray.count){
                                self.pos += self.smallBlockHeight + 3.0
                            }
                            
                        }else{
                            self.makeSmallBlockRight(position: self.pos, link: articleArray[counter].topic, tit: articleArray[counter].title, cap: articleArray[counter].message, index: CGFloat(counter))
                            self.pos += self.smallBlockHeight + 3.0
                            whichBlock = 0
                            print(counter)
                        }
                        counter += 1
                        
                    }
                    self.pos += UIApplication.shared.statusBarFrame.height + 10.0 + 35.0
                    self.ScrollView.contentSize.height = self.pos
                    
                    self.setupGradient(gradientLayer: self.gradientLayer3, height: self.pos + self.secondLabel.frame.origin.y + self.secondLabel.frame.size.height, pos: self.secondLabel.frame.origin.y)
                }
                
            } catch let error {
                print("Error decoding JSON For Main Text")
                print(error)
            }
            }.resume()
    }
    
    func JSONToAca(urlstring: String, descriptionString : String) {
        let testURLString = urlstring
        let testURl = URL(string: testURLString)
        _ = URLSession.shared.dataTask(with: testURl!){
            (data, response, err) in
            let data = data
            do{
                let articleArray = try JSONDecoder().decode([PostBulletin].self, from: data!)
                DispatchQueue.main.async {
                    self.AcademicsView.attributedText = self.makeAttributedStringSmall(title: articleArray[0].message, message: "")
                }
            } catch _ {
                print("Error decoding JSON")
        }
            }.resume()
    }
    
    func JSONToCollege(urlstring: String, descriptionString : String) {
        let testURLString = urlstring
        let testURl = URL(string: testURLString)
        _ = URLSession.shared.dataTask(with: testURl!){
            (data, response, err) in
            let data = data
            do{
                let articleArray = try JSONDecoder().decode([PostBulletin].self, from: data!)
                DispatchQueue.main.async {
                    self.CollegeView.attributedText = self.makeAttributedStringSmall(title: articleArray[0].message, message: "")
                }
            } catch _ {
                print("Error decoding JSON")
            }
            }.resume()
    }
    
    func JSONToVolunteering(urlstring: String, descriptionString : String) {
        let testURLString = urlstring
        let testURl = URL(string: testURLString)
        _ = URLSession.shared.dataTask(with: testURl!){
            (data, response, err) in
            let data = data
            do{
                let articleArray = try JSONDecoder().decode([PostBulletin].self, from: data!)
                DispatchQueue.main.async {
                    self.VolunteeringView.attributedText = self.makeAttributedStringSmall(title: articleArray[0].message, message: "")
                }
            } catch _ {
                print("Error decoding JSON")
            }
            }.resume()
    }
    
    func JSONToASB(urlstring: String, descriptionString : String) {
        let testURLString = urlstring
        let testURl = URL(string: testURLString)
        _ = URLSession.shared.dataTask(with: testURl!){
            (data, response, err) in
            let data = data
            do{
                let articleArray = try JSONDecoder().decode([PostBulletin].self, from: data!)
                DispatchQueue.main.async {
                    self.ASBView.attributedText = self.makeAttributedStringSmall(title: articleArray[0].message, message: "")
                }
            } catch _ {
                print("Error decoding JSON")
            }
            }.resume()
    }
    
    func JSONToSport(urlstring: String, descriptionString : String) {
        let testURLString = urlstring
        let testURl = URL(string: testURLString)
        _ = URLSession.shared.dataTask(with: testURl!){
            (data, response, err) in
            let data = data
            do{
                let articleArray = try JSONDecoder().decode([PostBulletin].self, from: data!)
                DispatchQueue.main.async {
                    self.SportView.attributedText = self.makeAttributedStringSmall(title: articleArray[0].message, message: "")
                }
            } catch _ {
                print("Error decoding JSON")
            }
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
    
    func makeAttributedStringBig(title: String, message: String) -> NSMutableAttributedString{
        
        
        
        _ = UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        let paragraphLineSpacing = NSMutableParagraphStyle()
        paragraphLineSpacing.lineSpacing = -9
        
        
        let titleAttributes = [ NSAttributedString.Key.foregroundColor : UIColor.black,NSAttributedString.Key.paragraphStyle: paragraphLineSpacing, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 28.0)!] as [NSAttributedString.Key : Any]
        
        let attributedTitle = NSAttributedString(string: self.convertSpecialCharacters(string: title), attributes: titleAttributes)
        
        _ = NSAttributedString(string: "\n")
        let fullMessage = NSMutableAttributedString(string: "")
        fullMessage.append(attributedTitle)
        return fullMessage
    }
    
    func makeAttributedBulletinBot(title: String, message: String) -> NSMutableAttributedString{
        
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
    
    func makeAttributedBulletinTop(title: String, message: String) -> NSMutableAttributedString{
        
        _ = UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        let paragraphLineSpacing = NSMutableParagraphStyle()
        paragraphLineSpacing.lineSpacing = -9
        
        
        let titleAttributes = [ NSAttributedString.Key.foregroundColor : UIColor.black,NSAttributedString.Key.paragraphStyle: paragraphLineSpacing, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 20.0)!] as [NSAttributedString.Key : Any]
        
        let attributedTitle = NSAttributedString(string: title, attributes: titleAttributes)
        
        _ = NSAttributedString(string: "\n")
        let fullMessage = NSMutableAttributedString(string: "")
        fullMessage.append(attributedTitle)
        return fullMessage
    }
    
    func makeAttributedStringSmall(title: String, message: String) -> NSMutableAttributedString{
        
        _ = UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        let paragraphLineSpacing = NSMutableParagraphStyle()
        paragraphLineSpacing.lineSpacing = -3
        
        
        let titleAttributes = [ NSAttributedString.Key.foregroundColor : UIColor.black,NSAttributedString.Key.paragraphStyle: paragraphLineSpacing, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 18.0)!] as [NSAttributedString.Key : Any]
        
        let attributedTitle = NSAttributedString(string: self.convertSpecialCharacters(string: title), attributes: titleAttributes)
        
        _ = NSAttributedString(string: "\n")
        let fullMessage = NSMutableAttributedString(string: "")
        fullMessage.append(attributedTitle)
        return fullMessage
    }
    
    func makeAttributedStringBulletin(title: String, message: String) -> NSMutableAttributedString{
        
        let orangeColor = UIColor(red: 210.0/255.0, green: 77.0/255.0, blue: 87/255.0, alpha: 1.0)
        let paragraphLineSpacing = NSMutableParagraphStyle()
        paragraphLineSpacing.lineSpacing = -3
        
        
        let titleAttributes = [ NSAttributedString.Key.foregroundColor : orangeColor ,NSAttributedString.Key.paragraphStyle: paragraphLineSpacing, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 28.0)!] as [NSAttributedString.Key : Any]
        
        let attributedTitle = NSAttributedString(string: self.convertSpecialCharacters(string: title), attributes: titleAttributes)
        
        _ = NSAttributedString(string: "\n")
        let fullMessage = NSMutableAttributedString(string: "")
        fullMessage.append(attributedTitle)
        return fullMessage
    }
    
    func makeAttributedCaption(title: String) -> NSMutableAttributedString{
        
        _ = UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        let paragraphLineSpacing = NSMutableParagraphStyle()
        paragraphLineSpacing.lineSpacing = -5
        
        
        let titleAttributes = [ NSAttributedString.Key.foregroundColor : UIColor.black,NSAttributedString.Key.paragraphStyle: paragraphLineSpacing, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Thin", size: 13.0)!] as [NSAttributedString.Key : Any]
        
        let attributedTitle = NSAttributedString(string: self.convertSpecialCharacters(string: title), attributes: titleAttributes)
        
        _ = NSAttributedString(string: "\n")
        let fullMessage = NSMutableAttributedString(string: "")
        fullMessage.append(attributedTitle)
        return fullMessage
    }
    
    func makeAttributedDate(title: String) -> NSMutableAttributedString{
        
        _ = UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        let paragraphLineSpacing = NSMutableParagraphStyle()
        paragraphLineSpacing.lineSpacing = -5
        
        
        let titleAttributes = [ NSAttributedString.Key.foregroundColor : UIColor.black,NSAttributedString.Key.paragraphStyle: paragraphLineSpacing, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 35.0)!] as [NSAttributedString.Key : Any]
        
        let attributedTitle = NSAttributedString(string: self.convertSpecialCharacters(string: title), attributes: titleAttributes)
        
        _ = NSAttributedString(string: "\n")
        let fullMessage = NSMutableAttributedString(string: "")
        fullMessage.append(attributedTitle)
        return fullMessage
    }
    
    func setupGradient(gradientLayer : CAGradientLayer, height: CGFloat, pos: CGFloat){
        let greyColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        _ = UIColor(red: 210.0/255.0, green: 45.0/255.0, blue: 25.0/255.0, alpha: 1.0)
        gradientLayer.colors = [UIColor.white.cgColor, greyColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame.size.width = self.view.frame.size.width
        gradientLayer.frame.size.height = height
        gradientLayer.frame.origin.x = 0.0
        gradientLayer.frame.origin.y = pos
        self.ScrollView.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    @objc func handleTap(_ sender: MyTapGesture){
        print("Hi")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "PopOverViewController") as! PopOverViewController
        PassedIndex = sender.index
        PassedImage = sender.image
        PassedURL = "http://ahsmobile.ausd.net:8080/AHS-Mobile/home-full-json.jsp"
        self.present(tab, animated:true, completion:nil)
    }
    
    @objc func goToAcademics(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "AcademicViewController") as! AcademicViewController
        self.present(tab, animated:true, completion:nil)
    }
    
    @objc func goToCollege(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "CollegeViewController") as! CollegeViewController
        self.present(tab, animated:true, completion:nil)
    }
    
    @objc func goToClubs(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "MoreViewController") as! MoreViewController
        self.present(tab, animated:true, completion:nil)
    }
    
    @objc func goToVolunteering(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "VolunteeringViewController") as! VolunteeringViewController
        self.present(tab, animated:true, completion:nil)
    }
    
    func goToASB(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "MoreViewController") as! MoreViewController
        self.present(tab, animated:true, completion:nil)
    }
    
    @objc func goToSports(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "SportViewController") as! SportViewController
        self.present(tab, animated:true, completion:nil)
    }
    
    @objc func goToOthers(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "PerformingViewController") as! PerformingViewController
        self.present(tab, animated:true, completion:nil)
    }
    
}
