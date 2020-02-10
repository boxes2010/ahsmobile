//
//  TestVideoViewController.swift
//  AHS
//
//  Created by Jason Zhao on 10/21/18.
//  Copyright © 2018 Jason Zhao. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase
import MediaPlayer

class TestVideoViewController: UIViewController {
    
    var dataref : DatabaseReference!
    var player = MPMoviePlayerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storage = Storage.storage().reference(forURL: "gs://arcadia-high-mobile.appspot.com")
        let videoRef = storage.root()
        dataref = Database.database().reference()
        let podcastRef = dataref.ref.child("podcasts")
        print("\n")
        
        getUser()
        
        print("Video")
        
        playMovie()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playMovie(){
        let url:NSURL = NSURL(string: "https://firebasestorage.googleapis.com/v0/b/arcadia-high-mobile.appspot.com/o/apn.mp4?alt=media&token=cbf99dc8-2155-4aad-8126-2301ddc9d604")!
        player = MPMoviePlayerController(contentURL: url as URL)
        player.view.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        self.view.addSubview(player.view)
        player.isFullscreen = true
        player.controlStyle = .embedded
    }
    
    func getUser(){
        self.dataref.child("podcasts").observe(DataEventType.value, with: { (snapshot) in
            print("self.datared.child")
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
                print("snapshot = snapshot.children")
                for snap in snapshot{
                    print("loop")
                    if let dict = snap.value as? [String : Any]{
                        
                        if let name = dict["URLs"] as? String{
                            print("Name:")
                            print(name)
                        }
                    }
                }
            }
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
