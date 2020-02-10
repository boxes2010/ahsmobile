//
//  TabViewController.swift
//  AHS
//
//  Created by Jason Zhao on 11/11/17.
//  Copyright © 2017 Jason Zhao. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController, UITabBarControllerDelegate {
    
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        let home = storyBoard.instantiateViewController(withIdentifier: "HomePage") as! FeaturedPageViewController
//        // Allows scrolling to top on second tab bar click
//        if (tabBarController.selectedIndex == 0) {
//            print("asdkjhasdshadhjasdjn")
//                home.scrollToTop()
//        }
//    }
    
    
}
