//
//  SettingsViewController.swift
//  StudentBulletinFinal
//
//  Created by Jason Zhao on 9/1/17.
//  Copyright © 2017 Jason Zhao. All rights reserved.
//

import UIKit



class InfoViewController: UIViewController {
    
    @IBOutlet var CreditsImage: UIImageView!
    
    override func viewDidLoad() {
       self.setupStatusBar()
        CreditsImage.frame = self.view.frame
        CreditsImage.frame.origin.y = UIApplication.shared.statusBarFrame.height
        
    }
    
    func setupStatusBar(){
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        returning = true 
        dismiss(animated: true, completion: nil)
    }
    
}
