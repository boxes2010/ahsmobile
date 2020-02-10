//
//  TermsSettingsViewController.swift
//  GoogleToolboxForMac
//
//  Created by Jason Zhao on 3/30/18.
//

import UIKit

class TermsSettingsViewController: UIViewController {

    @IBOutlet var agreementsText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupStatusBar()
        agreementsText.frame = self.view.frame
        agreementsText.frame.origin.y = UIApplication.shared.statusBarFrame.height
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupStatusBar(){
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
    }
    
    

}
