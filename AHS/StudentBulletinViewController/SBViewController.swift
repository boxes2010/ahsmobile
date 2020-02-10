//
//  SBViewController.swift
//  AHS
//
//  Created by Jason Zhao on 10/13/17.
//  Copyright © 2017 Jason Zhao. All rights reserved.
//

import UIKit

class SBViewController: UIViewController {
    
    @IBOutlet var AcademicsButton: UIButton!
    @IBOutlet var CollegesButton: UIButton!
    @IBOutlet var PerformingArts: UIButton!
    @IBOutlet var VolunteeringButton: UIButton!
    @IBOutlet var MoreButton: UIButton!
    @IBOutlet var SportsButton: UIButton!
    
    @IBOutlet var StudentBulletin: UILabel!
    @IBOutlet var HamburgerButton: UIButton!
    
    var marginConstant : CGFloat = 0.0
    
    var buttonWidth : CGFloat = 0.0
    var buttonHeight : CGFloat = 0.0
    
    @IBOutlet var ScrollView: UIScrollView!
    @IBOutlet var LongGreyLine: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeMarginConstant()
        self.setWidthHeight()
        self.setupButtons()
        self.setupButtons2()
        self.setupStatusBar()
        HamburgerButton.frame.origin.x = self.view.frame.size.width - 60.0
        returning = true
        ScrollView.contentSize.height = MoreButton.frame.origin.y + MoreButton.frame.size.height + 50.0
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeMarginConstant(){
        self.marginConstant = self.view.frame.size.width * 0.04
    }
    
    func setWidthHeight(){
        buttonWidth = self.view.frame.size.width * 0.446
        buttonHeight = self.view.frame.size.height * 0.446
    }
    
    func setupStatusBar(){
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
    }
    
    @IBAction func AcademicsButtonPressed(_ sender: UIButton) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "AcademicViewController") as! AcademicViewController
        self.present(tab, animated:true, completion:nil)
        
    }
    
    func setupButtons(){
        
        StudentBulletin.frame.origin.y = UIApplication.shared.statusBarFrame.size.height
        print("Student Bulletin Height")
        print(StudentBulletin.frame.origin.y)
        
        LongGreyLine.center.x = self.view.center.x
        
        AcademicsButton.frame.size.width = buttonWidth
        AcademicsButton.frame.size.height = buttonWidth
        AcademicsButton.imageView?.contentMode = .scaleAspectFit
        
        PerformingArts.frame.size.width = buttonWidth
        PerformingArts.frame.size.height = buttonWidth
        PerformingArts.imageView?.contentMode = .scaleAspectFit
        
        CollegesButton.frame.size.width = buttonWidth
        CollegesButton.frame.size.height = buttonWidth
        CollegesButton.imageView?.contentMode = .scaleAspectFit
        
        MoreButton.frame.size.width = buttonWidth
        MoreButton.frame.size.height = buttonWidth
        MoreButton.imageView?.contentMode = .scaleAspectFit
        
        SportsButton.frame.size.width = buttonWidth
        SportsButton.frame.size.height = buttonWidth
        SportsButton.imageView?.contentMode = .scaleAspectFit
        
        VolunteeringButton.frame.size.width = buttonWidth
        VolunteeringButton.frame.size.height = buttonWidth
        VolunteeringButton.imageView?.contentMode = .scaleAspectFit

        AcademicsButton.center.x = self.view.frame.width / 4
        PerformingArts.center.x = self.view.frame.width / 4
        MoreButton.center.x = self.view.frame.width / 4
        CollegesButton.center.x = self.view.frame.width * (3/4)
        VolunteeringButton.center.x = self.view.frame.width * (3/4)
        SportsButton.center.x = self.view.frame.width * (3/4)
        
        AcademicsButton.frame.origin.x = (self.view.frame.size.width / 2) - self.AcademicsButton.frame.size.width - (marginConstant / 2) - 2.5
        PerformingArts.frame.origin.x = (self.view.frame.size.width / 2) - self.AcademicsButton.frame.size.width - (marginConstant / 2) - 2.5
        MoreButton.frame.origin.x = (self.view.frame.size.width / 2) - self.AcademicsButton.frame.size.width - (marginConstant / 2) - 2.5
        CollegesButton.frame.origin.x = (self.view.frame.width / 2) + (marginConstant / 2) + 2.5
        VolunteeringButton.frame.origin.x = (self.view.frame.width / 2) + (marginConstant / 2) + 2.5
        SportsButton.frame.origin.x = (self.view.frame.width / 2) + (marginConstant / 2) + 2.5
        
        
        AcademicsButton.center.y = self.view.frame.height * (1/4) + 20
        PerformingArts.center.y = self.view.frame.height * (1/2) + 20
        MoreButton.center.y = self.view.frame.height * (3/4) + 20
        
        CollegesButton.center.y = self.view.frame.height * (1/4) + 20
        VolunteeringButton.center.y = self.view.frame.height * (1/2) + 20
        SportsButton.center.y = self.view.frame.height * (3/4) + 23
        
    }
    
    func setupButtons2(){
        AcademicsButton.frame.size.width = buttonWidth
        CollegesButton.frame.size.width = buttonWidth
        PerformingArts.frame.size.width = buttonWidth
        MoreButton.frame.size.width = buttonWidth
        VolunteeringButton.frame.size.width = buttonWidth
        SportsButton.frame.size.width = buttonWidth
        
        AcademicsButton.frame.size.height = buttonWidth
        CollegesButton.frame.size.height = buttonWidth
        PerformingArts.frame.size.height = buttonWidth
        MoreButton.frame.size.height = buttonWidth
        VolunteeringButton.frame.size.height = buttonWidth
        SportsButton.frame.size.height = buttonWidth
        
        AcademicsButton.frame.origin.x = self.view.frame.size.width * 0.042
        SportsButton.frame.origin.x = self.view.frame.size.width * 0.042
        MoreButton.frame.origin.x = self.view.frame.size.width * 0.042
        
        CollegesButton.frame.origin.x = self.view.frame.size.width - (self.view.frame.size.width * 0.042) - buttonWidth
        VolunteeringButton.frame.origin.x = self.view.frame.size.width - (self.view.frame.size.width * 0.042) - buttonWidth
        PerformingArts.frame.origin.x = self.view.frame.size.width - (self.view.frame.size.width * 0.037) - buttonWidth
        
        let heightSeparation = self.view.frame.size.height * 0.014
        
        AcademicsButton.frame.origin.y = LongGreyLine.frame.origin.y + 15.0
        CollegesButton.frame.origin.y = LongGreyLine.frame.origin.y + 15.0
        
        SportsButton.frame.origin.y = AcademicsButton.frame.size.height + AcademicsButton.frame.origin.y + heightSeparation
        VolunteeringButton.frame.origin.y = AcademicsButton.frame.size.height + AcademicsButton.frame.origin.y + heightSeparation
        
        MoreButton.frame.origin.y = VolunteeringButton.frame.size.height + VolunteeringButton.frame.origin.y + heightSeparation
        PerformingArts.frame.origin.y = VolunteeringButton.frame.size.height + VolunteeringButton.frame.origin.y + heightSeparation
        
        ScrollView.contentSize.height = SportsButton.frame.origin.y + SportsButton.frame.size.height + heightSeparation + 100.0
        
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let tab = storyBoard.instantiateViewController(withIdentifier: "NavViewController") as! NavViewController
        self.present(tab, animated:true, completion:nil)
    }
    
    
}
