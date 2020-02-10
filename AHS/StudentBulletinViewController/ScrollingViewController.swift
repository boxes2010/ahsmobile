//
//  ScrollingViewController.swift
//  AHS
//
//  Created by Jason Zhao on 10/7/17.
//  Copyright © 2017 Jason Zhao. All rights reserved.
//

import UIKit
import Foundation
import AVKit
import WebKit
class ScrollingViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var MainTextView: UITextView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var RedLine: UIImageView!
    @IBOutlet var APNButton: UIButton!
    
    @IBOutlet var FreshmenButton: UIButton!
    @IBOutlet var SophomoreButton: UIButton!
    @IBOutlet var JuniorButton: UIButton!
    
    @IBOutlet var FreshmenView: UIView!
    @IBOutlet var SophomoreView: UIView!
    @IBOutlet var JuniorView: UIView!
    
    var APN_VIDEO_URL = "https://arcadiaprojectapp.000webhostapp.com/APN.mp4"
    
     let playerViewController = AVPlayerViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupGradeViews()
        self.setupVideoPlayer()
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        
        // Do any additional setup after loading the view.
    }
    
    func setupGradeViews(){
        
        FreshmenView.frame.size.width = self.view.frame.width
        SophomoreView.frame.size.width = self.view.frame.width
        JuniorView.frame.size.width = self.view.frame.width
        
        SophomoreView.frame.origin.x = FreshmenView.frame.width
        JuniorView.frame.origin.x = (FreshmenView.frame.width) * 2
    }
    
    
    
    @IBAction func FreshmenButtonPressed(_ sender: UIButton) {
        scrollView.contentOffset.x = 0.0
        RedLine.frame.origin.x = scrollView.contentOffset.x / 3
    }

    @IBAction func SophomoreButtonPressed(_ sender: UIButton) {
        scrollView.contentOffset.x = FreshmenView.frame.size.width
        RedLine.frame.origin.x = (scrollView.contentOffset.x / 3) + 17
    }
    
    @IBAction func JuniorButtonPressed(_ sender: UIButton) {
        scrollView.contentOffset.x = FreshmenView.frame.size.width * 2
        RedLine.frame.origin.x = (scrollView.contentOffset.x / 3) + 30
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        RedLine.frame.origin.x = ((scrollView.contentOffset.x) / 3 ) + 10
    }
    
    func setupVideoPlayer(){
        let videoURL = APN_VIDEO_URL
        let videoPlayer = AVPlayer(url: URL(string: videoURL)!)
        playerViewController.player = videoPlayer

    }
    
    @IBAction func APNButtonPressed(_ sender: UIButton) {
        self.present(playerViewController,animated: true){
            self.playerViewController.player?.play()
        }
    }
    

}
