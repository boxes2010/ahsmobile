//
//  AppDelegate.swift
//  StudentBulletinFinal
//
//  Created by Jason Zhao on 6/27/17.
//  Copyright © 2017 Jason Zhao. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseMessaging
import UserNotifications
    
let UserDef = UserDefaults.standard
    
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        FirebaseApp.configure()
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        if #available(iOS 10.0, *) {
            //iOS 10 or above version
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert], completionHandler: {(granted, error) in
                if (granted){
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
                else{
                   print("Failed to set up remote notification")
                }
            })
        }
        else{
            //iOS 9
            let type: UIUserNotificationType = [UIUserNotificationType.badge, UIUserNotificationType.alert, UIUserNotificationType.sound]
            let setting = UIUserNotificationSettings(types: type, categories: nil)
            UIApplication.shared.registerUserNotificationSettings(setting)
            UIApplication.shared.registerForRemoteNotifications()
        }
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var initialViewController = storyboard.instantiateViewController(withIdentifier: "TermsView")
        
        if(!UserDef.bool(forKey: "DidAgree")){
            initialViewController = storyboard.instantiateViewController(withIdentifier: "TermsView")
        }else {
            initialViewController = storyboard.instantiateViewController(withIdentifier: "TabViewController") }

        var bypassRootViewController = ScrollingViewController()
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        if(!UserDef.bool(forKey: "didChangeFont")){
        UserDef.set(18.0, forKey: "FontSize")
        }
        
        // Remove notification badge
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        let token = Messaging.messaging().fcmToken
        print("FCM token: \(token ?? "")")
        
        Messaging.messaging().subscribe(toTopic: "Academics")
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        //print("Message ID  : \(userInfo["gcm_message_id"]!)")
        print(userInfo)
        
        let tabBar = self.window?.rootViewController as! UITabBarController // Getting Tab Bar
        tabBar.selectedIndex = 2 //Selecting tab here

        UIApplication.shared.applicationIconBadgeNumber = 1
    }

}

