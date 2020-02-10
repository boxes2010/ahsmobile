//
//  ImageViewController.swift
//  AHS
//
//  Created by Jason Zhao on 12/20/17.
//  Copyright © 2017 Jason Zhao. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var ScrollView: UIScrollView!
    @IBOutlet var MainImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ScrollView.minimumZoomScale = 1.0
        ScrollView.maximumZoomScale = 6.0
        MainImageView.center = self.view.center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return MainImageView
    }

}
