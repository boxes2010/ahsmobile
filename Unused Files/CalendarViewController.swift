//
//  CalendarViewController.swift
//  AHS
//
//  Created by Jason Zhao on 11/20/17.
//  Copyright © 2017 Jason Zhao. All rights reserved.
//

import UIKit

struct CalendarDate : Decodable{
    let date : String
    let events : String
}

var PassedText = NSAttributedString()

class CalendarViewController: UIViewController {
    
    @IBOutlet var TopBar: UIImageView!
    @IBOutlet var Line1: UIImageView!
    @IBOutlet var Line2: UIImageView!
    @IBOutlet var Line3: UIImageView!
    @IBOutlet var Line4: UIImageView!
    @IBOutlet var Line5: UIImageView!
    @IBOutlet var Line6: UIImageView!
    @IBOutlet var MainTextView: UITextView!
    
    @IBOutlet var SunLabel: UILabel!
    @IBOutlet var MonLabel: UILabel!
    @IBOutlet var TuesLabel: UILabel!
    @IBOutlet var WedLabel: UILabel!
    @IBOutlet var ThrLabel: UILabel!
    @IBOutlet var FriLabel: UILabel!
    @IBOutlet var SatLabel: UILabel!
    
    @IBOutlet var Sunday1: UIButton!
    @IBOutlet var Monday1: UIButton!
    @IBOutlet var Tuesday1: UIButton!
    @IBOutlet var Wednesday1: UIButton!
    @IBOutlet var Thrusday1: UIButton!
    @IBOutlet var Friday1: UIButton!
    @IBOutlet var Saturday1: UIButton!
    
    @IBOutlet var Sunday2: UIButton!
    @IBOutlet var Monday2: UIButton!
    @IBOutlet var Tuesday2: UIButton!
    @IBOutlet var Wednesday2: UIButton!
    @IBOutlet var Thursday2: UIButton!
    @IBOutlet var Friday2: UIButton!
    @IBOutlet var Saturday2: UIButton!
    
    @IBOutlet var Sunday3: UIButton!
    @IBOutlet var Monday3: UIButton!
    @IBOutlet var Tuesday3: UIButton!
    @IBOutlet var Wednesday3: UIButton!
    @IBOutlet var Thrusday3: UIButton!
    @IBOutlet var Friday3: UIButton!
    @IBOutlet var Saturday3: UIButton!
    
    @IBOutlet var Sunday4: UIButton!
    @IBOutlet var Monday4: UIButton!
    @IBOutlet var Tuesday4: UIButton!
    @IBOutlet var Wednesday4: UIButton!
    @IBOutlet var Thrusday4: UIButton!
    @IBOutlet var Friday4: UIButton!
    @IBOutlet var Saturday4: UIButton!
    
    @IBOutlet var Sunday5: UIButton!
    @IBOutlet var Monday5: UIButton!
    @IBOutlet var Tuesday5: UIButton!
    @IBOutlet var Wednesday5: UIButton!
    @IBOutlet var Thrusday5: UIButton!
    @IBOutlet var Friday5: UIButton!
    @IBOutlet var Saturday5: UIButton!
    
    @IBOutlet var Sunday6: UIButton!
    @IBOutlet var Monday6: UIButton!
    @IBOutlet var Tuesday6: UIButton!
    @IBOutlet var Wednesday6: UIButton!
    @IBOutlet var Thrusday6: UIButton!
    @IBOutlet var Friday6: UIButton!
    @IBOutlet var Saturday6: UIButton!
    
    var lineSeparationConstant : CGFloat = 55.0
    var marginConstant : CGFloat = 0.0
    var datesXPosition : CGFloat = 0.0
    var buttonFactor : CGFloat = 12.0
    var LinePosition : CGFloat = 45.0
    var borderColor : UIColor = UIColor()
    var greyC : UIColor = UIColor(red: 102.0 / 255.0, green: 102.0 / 255.0, blue: 102.0 / 255.0, alpha: 1.0)
    
    @IBOutlet var HamburgerButton: UIButton!
    @IBOutlet var MainTextBackground: UIImageView!
    
    @IBOutlet var MonthLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 230.0 / 255.0, green: 230.0 / 255.0, blue: 230.0 / 255.0, alpha: 1.0)
        self.makeMarginConstant()
        self.makeWhyPosition()
        self.makeBorderColor()
        self.setupLines()
        self.setupMonthLabel()
        self.setupButton()
        self.makeTextView()
        self.JSONToTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeMarginConstant(){
        self.marginConstant = self.view.frame.size.width * 0.04
    }
    
    func makeWhyPosition(){
        self.datesXPosition = (self.view.frame.size.width - (self.view.frame.size.width * 0.08)) / 7.0
    }
    
    func makeBorderColor(){
        self.borderColor = UIColor(red: 210.0 / 255.0, green: 77.0 / 255.0, blue: 87.0 / 255.0, alpha: 1.0)
    }
    
    func makeLineSeparationConstant(){
        
    }
    
    func setupMonthLabel(){
        MonthLabel.frame.origin.y = TopBar.frame.origin.y + TopBar.frame.size.height
        MonthLabel.frame.origin.x = SunLabel.frame.origin.x
    }
    
    func makeTextView(){
        MainTextView.frame.size.width = self.view.frame.size.width - (2 * self.marginConstant)
        MainTextView.center.x = self.view.center.x
        MainTextView.frame.origin.y = Sunday6.frame.origin.y + Sunday6.frame.size.height + 30.0
        MainTextView.attributedText = self.makeAttributedTitle(titles: "Tapping here will bring up all the text.")
        MainTextBackground.frame.size.width = MainTextView.frame.size.width + (2 * self.marginConstant)
        MainTextBackground.frame.size.height = MainTextView.frame.size.height
        MainTextBackground.frame.origin.x = 0.0
        MainTextBackground.frame.origin.y = MainTextView.frame.origin.y
    }
    
    func setupLines(){
        Line1.frame.origin.y = TopBar.frame.origin.y + TopBar.frame.size.height + LinePosition
        Line2.frame.origin.y = Line1.frame.origin.y + lineSeparationConstant
        Line3.frame.origin.y = Line2.frame.origin.y + lineSeparationConstant
        Line4.frame.origin.y = Line3.frame.origin.y + lineSeparationConstant
        Line5.frame.origin.y = Line4.frame.origin.y + lineSeparationConstant
        Line6.frame.origin.y = Line5.frame.origin.y + lineSeparationConstant
        
        Line1.frame.size.width = self.view.frame.size.width + 30.0
        Line2.frame.size.width = self.view.frame.size.width + 30.0
        Line3.frame.size.width = self.view.frame.size.width + 30.0
        Line4.frame.size.width = self.view.frame.size.width + 30.0
        Line5.frame.size.width = self.view.frame.size.width + 30.0
        Line6.frame.size.width = self.view.frame.size.width + 30.0
        
        Line1.center.x = self.view.center.x
        Line2.center.x = self.view.center.x
        Line3.center.x = self.view.center.x
        Line4.center.x = self.view.center.x
        Line5.center.x = self.view.center.x
        Line6.center.x = self.view.center.x
        
        SunLabel.center.x = self.datesXPosition - buttonFactor
        MonLabel.center.x = 2 * self.datesXPosition - buttonFactor
        TuesLabel.center.x = 3 * self.datesXPosition - buttonFactor
        WedLabel.center.x = 4 * self.datesXPosition - buttonFactor
        ThrLabel.center.x = 5 * self.datesXPosition - buttonFactor
        FriLabel.center.x = 6 * self.datesXPosition - buttonFactor
        SatLabel.center.x = 7 * self.datesXPosition - buttonFactor
        
        SunLabel.frame.origin.y = TopBar.frame.origin.y + TopBar.frame.size.height + (LinePosition / 2)
        MonLabel.frame.origin.y = TopBar.frame.origin.y + TopBar.frame.size.height + (LinePosition / 2)
        TuesLabel.frame.origin.y = TopBar.frame.origin.y + TopBar.frame.size.height + (LinePosition / 2)
        WedLabel.frame.origin.y = TopBar.frame.origin.y + TopBar.frame.size.height + (LinePosition / 2)
        ThrLabel.frame.origin.y = TopBar.frame.origin.y + TopBar.frame.size.height + (LinePosition / 2)
        FriLabel.frame.origin.y = TopBar.frame.origin.y + TopBar.frame.size.height + (LinePosition / 2)
        SatLabel.frame.origin.y = TopBar.frame.origin.y + TopBar.frame.size.height + (LinePosition / 2)
    }
    
    func setupButton(){
        Sunday1.center.x = self.datesXPosition - buttonFactor
        Monday1.center.x = 2 * self.datesXPosition - buttonFactor
        Tuesday1.center.x = 3 * self.datesXPosition - buttonFactor
        Wednesday1.center.x = 4 * self.datesXPosition - buttonFactor
        Thrusday1.center.x = 5 * self.datesXPosition - buttonFactor
        Friday1.center.x = 6 * self.datesXPosition - buttonFactor
        Saturday1.center.x = 7 * self.datesXPosition - buttonFactor
        
        Sunday1.frame.origin.y = Line1.frame.origin.y + (Line1.frame.size.height / 2.0) + 2.0
        Monday1.frame.origin.y = Line1.frame.origin.y + (Line1.frame.size.height / 2.0) + 2.0
        Tuesday1.frame.origin.y = Line1.frame.origin.y + (Line1.frame.size.height / 2.0) + 2.0
        Wednesday1.frame.origin.y = Line1.frame.origin.y + (Line1.frame.size.height / 2.0) + 2.0
        Thrusday1.frame.origin.y = Line1.frame.origin.y + (Line1.frame.size.height / 2.0) + 2.0
        Friday1.frame.origin.y = Line1.frame.origin.y + (Line1.frame.size.height / 2.0) + 2.0
        Saturday1.frame.origin.y = Line1.frame.origin.y + (Line1.frame.size.height / 2.0) + 2.0
        
        Sunday2.center.x = self.datesXPosition - buttonFactor
        Monday2.center.x = 2 * self.datesXPosition - buttonFactor
        Tuesday2.center.x = 3 * self.datesXPosition - buttonFactor
        Wednesday2.center.x = 4 * self.datesXPosition - buttonFactor
        Thursday2.center.x = 5 * self.datesXPosition - buttonFactor
        Friday2.center.x = 6 * self.datesXPosition - buttonFactor
        Saturday2.center.x = 7 * self.datesXPosition - buttonFactor
        
        Sunday2.frame.origin.y = Line2.frame.origin.y + (Line2.frame.size.height / 2.0) + 2.0
        Monday2.frame.origin.y = Line2.frame.origin.y + (Line2.frame.size.height / 2.0) + 2.0
        Tuesday2.frame.origin.y = Line2.frame.origin.y + (Line2.frame.size.height / 2.0) + 2.0
        Wednesday2.frame.origin.y = Line2.frame.origin.y + (Line2.frame.size.height / 2.0) + 2.0
        Thursday2.frame.origin.y = Line2.frame.origin.y + (Line2.frame.size.height / 2.0) + 2.0
        Friday2.frame.origin.y = Line2.frame.origin.y + (Line2.frame.size.height / 2.0) + 2.0
        Saturday2.frame.origin.y = Line2.frame.origin.y + (Line2.frame.size.height / 2.0) + 2.0
        
        Sunday3.center.x = self.datesXPosition - buttonFactor
        Monday3.center.x = 2 * self.datesXPosition - buttonFactor
        Tuesday3.center.x = 3 * self.datesXPosition - buttonFactor
        Wednesday3.center.x = 4 * self.datesXPosition - buttonFactor
        Thrusday3.center.x = 5 * self.datesXPosition - buttonFactor
        Friday3.center.x = 6 * self.datesXPosition - buttonFactor
        Saturday3.center.x = 7 * self.datesXPosition - buttonFactor
        
        Sunday3.frame.origin.y = Line3.frame.origin.y + (Line3.frame.size.height / 2.0) + 2.0
        Monday3.frame.origin.y = Line3.frame.origin.y + (Line3.frame.size.height / 2.0) + 2.0
        Tuesday3.frame.origin.y = Line3.frame.origin.y + (Line3.frame.size.height / 2.0) + 2.0
        Wednesday3.frame.origin.y = Line3.frame.origin.y + (Line3.frame.size.height / 2.0) + 2.0
        Thrusday3.frame.origin.y = Line3.frame.origin.y + (Line3.frame.size.height / 2.0) + 2.0
        Friday3.frame.origin.y = Line3.frame.origin.y + (Line3.frame.size.height / 2.0) + 2.0
        Saturday3.frame.origin.y = Line3.frame.origin.y + (Line3.frame.size.height / 2.0) + 2.0
        
        Sunday4.center.x = self.datesXPosition - buttonFactor
        Monday4.center.x = 2 * self.datesXPosition - buttonFactor
        Tuesday4.center.x = 3 * self.datesXPosition - buttonFactor
        Wednesday4.center.x = 4 * self.datesXPosition - buttonFactor
        Thrusday4.center.x = 5 * self.datesXPosition - buttonFactor
        Friday4.center.x = 6 * self.datesXPosition - buttonFactor
        Saturday4.center.x = 7 * self.datesXPosition - buttonFactor
        
        Sunday4.frame.origin.y = Line4.frame.origin.y + (Line4.frame.size.height / 2.0) + 2.0
        Monday4.frame.origin.y = Line4.frame.origin.y + (Line4.frame.size.height / 2.0) + 2.0
        Tuesday4.frame.origin.y = Line4.frame.origin.y + (Line4.frame.size.height / 2.0) + 2.0
        Wednesday4.frame.origin.y = Line4.frame.origin.y + (Line4.frame.size.height / 2.0) + 2.0
        Thrusday4.frame.origin.y = Line4.frame.origin.y + (Line4.frame.size.height / 2.0) + 2.0
        Friday4.frame.origin.y = Line4.frame.origin.y + (Line4.frame.size.height / 2.0) + 2.0
        Saturday4.frame.origin.y = Line4.frame.origin.y + (Line4.frame.size.height / 2.0) + 2.0
        
        Sunday5.center.x = self.datesXPosition - buttonFactor
        Monday5.center.x = 2 * self.datesXPosition - buttonFactor
        Tuesday5.center.x = 3 * self.datesXPosition - buttonFactor
        Wednesday5.center.x = 4 * self.datesXPosition - buttonFactor
        Thrusday5.center.x = 5 * self.datesXPosition - buttonFactor
        Friday5.center.x = 6 * self.datesXPosition - buttonFactor
        Saturday5.center.x = 7 * self.datesXPosition - buttonFactor
        
        Sunday5.frame.origin.y = Line5.frame.origin.y + (Line5.frame.size.height / 2.0) + 2.0
        Monday5.frame.origin.y = Line5.frame.origin.y + (Line5.frame.size.height / 2.0) + 2.0
        Tuesday5.frame.origin.y = Line5.frame.origin.y + (Line5.frame.size.height / 2.0) + 2.0
        Wednesday5.frame.origin.y = Line5.frame.origin.y + (Line5.frame.size.height / 2.0) + 2.0
        Thrusday5.frame.origin.y = Line5.frame.origin.y + (Line5.frame.size.height / 2.0) + 2.0
        Friday5.frame.origin.y = Line5.frame.origin.y + (Line5.frame.size.height / 2.0) + 2.0
        Saturday5.frame.origin.y = Line5.frame.origin.y + (Line5.frame.size.height / 2.0) + 2.0
        
        Sunday6.center.x = self.datesXPosition - buttonFactor
        Monday6.center.x = 2 * self.datesXPosition - buttonFactor
        Tuesday6.center.x = 3 * self.datesXPosition - buttonFactor
        Wednesday6.center.x = 4 * self.datesXPosition - buttonFactor
        Thrusday6.center.x = 5 * self.datesXPosition - buttonFactor
        Friday6.center.x = 6 * self.datesXPosition - buttonFactor
        Saturday6.center.x = 7 * self.datesXPosition - buttonFactor
        
        Sunday6.frame.origin.y = Line6.frame.origin.y + (Line6.frame.size.height / 2.0) + 2.0
        Monday6.frame.origin.y = Line6.frame.origin.y + (Line6.frame.size.height / 2.0) + 2.0
        Tuesday6.frame.origin.y = Line6.frame.origin.y + (Line6.frame.size.height / 2.0) + 2.0
        Wednesday6.frame.origin.y = Line6.frame.origin.y + (Line6.frame.size.height / 2.0) + 2.0
        Thrusday6.frame.origin.y = Line6.frame.origin.y + (Line6.frame.size.height / 2.0) + 2.0
        Friday6.frame.origin.y = Line6.frame.origin.y + (Line6.frame.size.height / 2.0) + 2.0
        Saturday6.frame.origin.y = Line6.frame.origin.y + (Line6.frame.size.height / 2.0) + 2.0
        
        Sunday1.layer.cornerRadius = Sunday1.frame.size.height / 2
        Sunday1.layer.masksToBounds = true
        Sunday2.layer.cornerRadius = Sunday1.frame.size.height / 2
        Sunday2.layer.masksToBounds = true
        Sunday3.layer.cornerRadius = Sunday1.frame.size.height / 2
        Sunday3.layer.masksToBounds = true
        Sunday4.layer.cornerRadius = Sunday1.frame.size.height / 2
        Sunday4.layer.masksToBounds = true
        Sunday5.layer.cornerRadius = Sunday1.frame.size.height / 2
        Sunday5.layer.masksToBounds = true
        Sunday6.layer.cornerRadius = Sunday1.frame.size.height / 2
        Sunday6.layer.masksToBounds = true
        
        Monday1.layer.cornerRadius = Monday1.frame.size.height / 2
        Monday1.layer.masksToBounds = true
        Monday2.layer.cornerRadius = Monday1.frame.size.height / 2
        Monday2.layer.masksToBounds = true
        Monday3.layer.cornerRadius = Monday1.frame.size.height / 2
        Monday3.layer.masksToBounds = true
        Monday4.layer.cornerRadius = Monday1.frame.size.height / 2
        Monday4.layer.masksToBounds = true
        Monday5.layer.cornerRadius = Monday1.frame.size.height / 2
        Monday5.layer.masksToBounds = true
        Monday6.layer.cornerRadius = Monday1.frame.size.height / 2
        Monday6.layer.masksToBounds = true
        
        Tuesday1.layer.cornerRadius = Tuesday1.frame.size.height / 2
        Tuesday1.layer.masksToBounds = true
        Tuesday2.layer.cornerRadius = Tuesday1.frame.size.height / 2
        Tuesday2.layer.masksToBounds = true
        Tuesday3.layer.cornerRadius = Tuesday1.frame.size.height / 2
        Tuesday3.layer.masksToBounds = true
        Tuesday4.layer.cornerRadius = Tuesday1.frame.size.height / 2
        Tuesday4.layer.masksToBounds = true
        Tuesday5.layer.cornerRadius = Tuesday1.frame.size.height / 2
        Tuesday5.layer.masksToBounds = true
        Tuesday6.layer.cornerRadius = Tuesday1.frame.size.height / 2
        Tuesday6.layer.masksToBounds = true
        
        Wednesday1.layer.cornerRadius = Wednesday1.frame.size.height / 2
        Wednesday1.layer.masksToBounds = true
        Wednesday2.layer.cornerRadius = Wednesday1.frame.size.height / 2
        Wednesday2.layer.masksToBounds = true
        Wednesday3.layer.cornerRadius = Wednesday1.frame.size.height / 2
        Wednesday3.layer.masksToBounds = true
        Wednesday4.layer.cornerRadius = Wednesday1.frame.size.height / 2
        Wednesday4.layer.masksToBounds = true
        Wednesday5.layer.cornerRadius = Wednesday1.frame.size.height / 2
        Wednesday5.layer.masksToBounds = true
        Wednesday6.layer.cornerRadius = Wednesday1.frame.size.height / 2
        Wednesday6.layer.masksToBounds = true
        
        Thrusday1.layer.cornerRadius = Thrusday1.frame.size.height / 2
        Thrusday1.layer.masksToBounds = true
        Thursday2.layer.cornerRadius = Thrusday1.frame.size.height / 2
        Thursday2.layer.masksToBounds = true
        Thrusday3.layer.cornerRadius = Thrusday1.frame.size.height / 2
        Thrusday3.layer.masksToBounds = true
        Thrusday4.layer.cornerRadius = Thrusday1.frame.size.height / 2
        Thrusday4.layer.masksToBounds = true
        Thrusday5.layer.cornerRadius = Thrusday1.frame.size.height / 2
        Thrusday5.layer.masksToBounds = true
        Thrusday6.layer.cornerRadius = Thrusday1.frame.size.height / 2
        Thrusday6.layer.masksToBounds = true
        
        Friday1.layer.cornerRadius = Friday1.frame.size.height / 2
        Friday1.layer.masksToBounds = true
        Friday2.layer.cornerRadius = Friday1.frame.size.height / 2
        Friday2.layer.masksToBounds = true
        Friday3.layer.cornerRadius = Friday1.frame.size.height / 2
        Friday3.layer.masksToBounds = true
        Friday4.layer.cornerRadius = Friday1.frame.size.height / 2
        Friday4.layer.masksToBounds = true
        Friday5.layer.cornerRadius = Friday1.frame.size.height / 2
        Friday5.layer.masksToBounds = true
        Friday6.layer.cornerRadius = Friday1.frame.size.height / 2
        Friday6.layer.masksToBounds = true
        
        Saturday1.layer.cornerRadius = Saturday1.frame.size.height / 2
        Saturday1.layer.masksToBounds = true
        Saturday2.layer.cornerRadius = Saturday1.frame.size.height / 2
        Saturday2.layer.masksToBounds = true
        Saturday3.layer.cornerRadius = Saturday1.frame.size.height / 2
        Saturday3.layer.masksToBounds = true
        Saturday4.layer.cornerRadius = Saturday1.frame.size.height / 2
        Saturday4.layer.masksToBounds = true
        Saturday5.layer.cornerRadius = Saturday1.frame.size.height / 2
        Saturday5.layer.masksToBounds = true
        Saturday6.layer.cornerRadius = Saturday1.frame.size.height / 2
        Saturday6.layer.masksToBounds = true
        
        
    }
    
    func JSONToTextView(urlstring: String) {
        let testURLString = urlstring
        let testURl = URL(string: testURLString)
        _ = 0
        URLSession.shared.dataTask(with: testURl!){
            (data, response, err) in
            let data = data
            do{
                let day = try JSONDecoder().decode([CalendarDate].self, from: data!)
                DispatchQueue.main.async {
                    
                    self.Sunday1.setTitle(day[0].date, for: .normal)
                    self.Monday1.setTitle(day[1].date, for: .normal)
                    self.Tuesday1.setTitle(day[2].date, for: .normal)
                    self.Wednesday1.setTitle(day[3].date, for: .normal)
                    self.Thrusday1.setTitle(day[4].date, for: .normal)
                    self.Friday1.setTitle(day[5].date, for: .normal)
                    self.Saturday1.setTitle(day[6].date, for: .normal)
                    
                    self.Sunday2.setTitle(day[7].date, for: .normal)
                    self.Monday2.setTitle(day[8].date, for: .normal)
                    self.Tuesday2.setTitle(day[9].date, for: .normal)
                    self.Wednesday2.setTitle(day[10].date, for: .normal)
                    self.Thursday2.setTitle(day[11].date, for: .normal)
                    self.Friday2.setTitle(day[12].date, for: .normal)
                    self.Saturday2.setTitle(day[13].date, for: .normal)
                    
                    self.Sunday3.setTitle(day[14].date, for: .normal)
                    self.Monday3.setTitle(day[15].date, for: .normal)
                    self.Tuesday3.setTitle(day[16].date, for: .normal)
                    self.Wednesday3.setTitle(day[17].date, for: .normal)
                    self.Thrusday3.setTitle(day[18].date, for: .normal)
                    self.Friday3.setTitle(day[19].date, for: .normal)
                    self.Saturday3.setTitle(day[20].date, for: .normal)
                    
                    self.Sunday4.setTitle(day[21].date, for: .normal)
                    self.Monday4.setTitle(day[22].date, for: .normal)
                    self.Tuesday4.setTitle(day[23].date, for: .normal)
                    self.Wednesday4.setTitle(day[24].date, for: .normal)
                    self.Thrusday4.setTitle(day[25].date, for: .normal)
                    self.Friday4.setTitle(day[26].date, for: .normal)
                    self.Saturday4.setTitle(day[27].date, for: .normal)
                    
                    self.Sunday5.setTitle(day[28].date, for: .normal)
                    self.Monday5.setTitle(day[29].date, for: .normal)
                    self.Tuesday5.setTitle(day[30].date, for: .normal)
                    self.Wednesday5.setTitle(day[31].date, for: .normal)
                    self.Thrusday5.setTitle(day[32].date, for: .normal)
                    self.Friday5.setTitle(day[33].date, for: .normal)
                    self.Saturday5.setTitle(day[34].date, for: .normal)
                    
                    self.Sunday6.setTitle(day[35].date, for: .normal)
                    self.Monday6.setTitle(day[36].date, for: .normal)
                    self.Tuesday6.setTitle(day[37].date, for: .normal)
                    self.Wednesday6.setTitle(day[38].date, for: .normal)
                    self.Thrusday6.setTitle(day[39].date, for: .normal)
                    self.Friday6.setTitle(day[40].date, for: .normal)
                    self.Saturday6.setTitle(day[41].date, for: .normal)
                   
                }
            } catch let _ { print("error") }
        }.resume()
    }
    
    func JSONToMainTextView(urlstring: String, index: Int) {
        let testURLString = urlstring
        let testURl = URL(string: testURLString)
        URLSession.shared.dataTask(with: testURl!){
            (data, response, err) in
            let data = data
            do{
                let day = try JSONDecoder().decode([CalendarDate].self, from: data!)
                DispatchQueue.main.async {
                    self.MainTextView.attributedText = self.makeAttributedMessage(message: day[index].events)
                }
            } catch let _ { print("error") }
        }.resume()
    }
    
    func makeAttributedMessage(message: String) -> NSMutableAttributedString{
        
        _ = UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        let paragraphLineSpacing = NSMutableParagraphStyle()
        paragraphLineSpacing.lineSpacing = 4
        
        let messageAttributes = [ NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.paragraphStyle: paragraphLineSpacing, NSAttributedString.Key.font: UIFont(name: "MyriadPro-Regular", size: CGFloat(UserDef.float(forKey: "FontSize")))!] as [NSAttributedString.Key : Any]
        
        let attributedMessage = NSAttributedString(string:  message, attributes: messageAttributes)
        
        let fullMessage = NSMutableAttributedString(string: "")
        fullMessage.append(attributedMessage)
        
        return fullMessage
    }
    
    func makeAttributedTitle(titles: String) -> NSMutableAttributedString{
        var messageAttributes = [NSAttributedString.Key.font: UIFont(name: "Georgia", size: CGFloat(UserDef.float(forKey: "FontSize")))!] as [NSAttributedString.Key : Any]
        
        var attributedMessage = NSAttributedString(string: titles, attributes: messageAttributes)
        
        var fullMessage = NSMutableAttributedString(string: "")
        fullMessage.append(attributedMessage)
        
        return fullMessage
    }
    
    func setTextColor(){
        Sunday1.setTitleColor(greyC, for: .normal)
        Sunday2.setTitleColor(greyC, for: .normal)
        Sunday3.setTitleColor(greyC, for: .normal)
        Sunday4.setTitleColor(greyC, for: .normal)
        Sunday5.setTitleColor(greyC, for: .normal)
        Sunday6.setTitleColor(greyC, for: .normal)
        
        Monday1.setTitleColor(UIColor.black, for: .normal)
        Monday2.setTitleColor(UIColor.black, for: .normal)
        Monday3.setTitleColor(UIColor.black, for: .normal)
        Monday4.setTitleColor(UIColor.black, for: .normal)
        Monday5.setTitleColor(UIColor.black, for: .normal)
        Monday6.setTitleColor(UIColor.black, for: .normal)
        
        Tuesday1.setTitleColor(UIColor.black, for: .normal)
        Tuesday2.setTitleColor(UIColor.black, for: .normal)
        Tuesday3.setTitleColor(UIColor.black, for: .normal)
        Tuesday4.setTitleColor(UIColor.black, for: .normal)
        Tuesday5.setTitleColor(UIColor.black, for: .normal)
        Tuesday6.setTitleColor(UIColor.black, for: .normal)
        
        Wednesday1.setTitleColor(UIColor.black, for: .normal)
        Wednesday2.setTitleColor(UIColor.black, for: .normal)
        Wednesday3.setTitleColor(UIColor.black, for: .normal)
        Wednesday4.setTitleColor(UIColor.black, for: .normal)
        Wednesday5.setTitleColor(UIColor.black, for: .normal)
        Wednesday6.setTitleColor(UIColor.black, for: .normal)
        
        Thrusday1.setTitleColor(UIColor.black, for: .normal)
        Thursday2.setTitleColor(UIColor.black, for: .normal)
        Thrusday3.setTitleColor(UIColor.black, for: .normal)
        Thrusday4.setTitleColor(UIColor.black, for: .normal)
        Thrusday5.setTitleColor(UIColor.black, for: .normal)
        Thrusday6.setTitleColor(UIColor.black, for: .normal)
        
        Friday1.setTitleColor(UIColor.black, for: .normal)
        Friday2.setTitleColor(UIColor.black, for: .normal)
        Friday3.setTitleColor(UIColor.black, for: .normal)
        Friday4.setTitleColor(UIColor.black, for: .normal)
        Friday5.setTitleColor(UIColor.black, for: .normal)
        Friday6.setTitleColor(UIColor.black, for: .normal)
        
        Saturday1.setTitleColor(greyC, for: .normal)
        Saturday2.setTitleColor(greyC, for: .normal)
        Saturday3.setTitleColor(greyC, for: .normal)
        Saturday4.setTitleColor(greyC, for: .normal)
        Saturday5.setTitleColor(greyC, for: .normal)
        Saturday6.setTitleColor(greyC, for: .normal)
        
    }
    
    @IBAction func Sunday1Pressed(_ sender: UIButton) {

        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 0)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                buttonRef.backgroundColor = UIColor.clear
                buttonRef.setTitleColor(greyC, for: .normal)
                }
            
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Sunday2Pressed(_ sender: UIButton) {

        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 7)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(greyC, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Sunday3Pressed(_ sender: UIButton) {

        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 0)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(greyC, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Sunday4Pressed(_ sender: UIButton) {
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 0)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(greyC, for: .normal)
                }
                
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Sunday5Pressed(_ sender: UIButton) {
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 0)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(greyC, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Sunday6Pressed(_ sender: UIButton) {
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 0)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(greyC, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Monday1Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 1)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(UIColor.black, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Monday2Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 8)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(UIColor.black, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Monday3Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 15)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(UIColor.black, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Monday4Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 22)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(UIColor.black, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Monday5Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 29)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(UIColor.black, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Monday6Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 36)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(UIColor.black, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Tuesday1Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 2)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(UIColor.black, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Tuesday2Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 9)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(UIColor.black, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Tuesday3Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 16)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(UIColor.black, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Tuesday4Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 23)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(UIColor.black, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Tuesday5Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 30)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(UIColor.black, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Tuesday6Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 37)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(UIColor.black, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Wednesday1Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 3)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(UIColor.black, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Wednesday2Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 10)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(UIColor.black, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Wednesday3Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 17)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(UIColor.black, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Wednesday4Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 24)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(UIColor.black, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Wednesday5Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 31)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(UIColor.black, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Wednesday6Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 38)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(UIColor.black, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Thursday1Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 4)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(UIColor.black, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Thursday2Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 11)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(UIColor.black, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Thursday3Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 18)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(UIColor.black, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Thursday4Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 25)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(UIColor.black, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Thursday5Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 32)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(UIColor.black, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Thursday6Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 39)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(UIColor.black, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Friday1Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 5)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(UIColor.black, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Friday2Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 12)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(UIColor.black, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Friday3Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 19)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(UIColor.black, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Friday4Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 26)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(UIColor.black, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Friday5Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 33)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(UIColor.black, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Friday6Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 39)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(UIColor.black, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Saturday1Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 6)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(greyC, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Saturday2Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 13)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(greyC, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Saturday3Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 20)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(greyC, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Saturday4Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 27)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(greyC, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Saturday5Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 34)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(greyC, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func Saturday6Pressed(_ sender: UIButton) {
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
        self.MainTextView.attributedText = self.makeAttributedTitle(titles: "Loading...")
        self.JSONToMainTextView(urlstring: "http://arcadiaprojectapp.xyz/version%201%20php/Upcoming/calendar.php", index: 41)
        for view in self.view.subviews as [UIView] {
            if let buttonRef = view as? UIButton {
                if(buttonRef != sender){
                    buttonRef.backgroundColor = UIColor.clear
                    buttonRef.setTitleColor(greyC, for: .normal)
                }
            }
        }
        self.setTextColor()
        sender.backgroundColor = borderColor
        sender.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func MainTextViewTapped(_ sender: UITapGestureRecognizer) {
        PassedText = MainTextView.attributedText
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "CalendarPopOverViewController") as! CalendarPopOverViewController
        self.present(tab, animated:true, completion:nil)
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "NavViewController") as! NavViewController
        self.present(tab, animated:true, completion:nil)
    }
    
}
