//
//  CalendarPopOverViewController.swift
//  AHS
//
//  Created by Jason Zhao on 11/24/17.
//  Copyright © 2017 Jason Zhao. All rights reserved.
//

import UIKit

class CalendarPopOverViewController: UIViewController {
    @IBOutlet var MainTextLabel: UITextView!
    
    var marginConstant : CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeMarginConstant()
        self.setupText()
    }
    
    func makeMarginConstant(){
        self.marginConstant = self.view.frame.size.width * 0.04
    }
    
    func setupText(){
        MainTextLabel.frame.size.width = self.view.frame.size.width - (5 * marginConstant)
        MainTextLabel.frame.size.height = self.view.frame.size.height - (12 * marginConstant)
        MainTextLabel.center = self.view.center
        MainTextLabel.layer.cornerRadius = MainTextLabel.frame.size.width / 12
        MainTextLabel.layer.masksToBounds = true
        MainTextLabel.attributedText = PassedText
    }
    @IBAction func outsidePressed(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
