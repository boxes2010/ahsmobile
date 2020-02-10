//
//  TableViewController.swift
//  AHS
//
//  Created by Jason Zhao on 11/22/17.
//  Copyright © 2017 Jason Zhao. All rights reserved.
//

import UIKit

var FontSize : CGFloat = 0.0

class TableViewController: UITableViewController {
    @IBOutlet var FontLabel: UILabel!
    @IBOutlet var FontSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FontSlider.maximumValue = 50
        FontSlider.minimumValue = 1
        FontLabel.text = String(Int(UserDef.float(forKey: "FontSize")))
        FontSlider.value = UserDef.float(forKey: "FontSize")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        FontSize = CGFloat(sender.value)
        FontLabel.text = "\(String(Int(FontSize)))"
        UserDef.set(FontSize, forKey: "FontSize")
        UserDef.set(true, forKey: "didChangeFont")
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
