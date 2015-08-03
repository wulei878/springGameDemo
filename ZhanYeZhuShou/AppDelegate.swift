//
//  AppDelegate.swift
//  ZhanYeZhuShou
//
//  Created by Owen on 15/7/28.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UINavigationBar.appearance().translucent = false
        UINavigationBar.appearance().barTintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        UINavigationBar.appearance().setBackgroundImage(UIImage(), forBarPosition: .Any, barMetrics: .Default)
        UINavigationBar.appearance().shadowImage = UIImage()
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.makeKeyAndVisible()
        let thirdPartyManager = GZThirdPartyManager.sharedInstance()
        thirdPartyManager.uploadAppKey()
        window?.rootViewController = ZYMainViewController.getInstance()
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool
    {
        return GZThirdPartyManager.sharedInstance().handleOpenURL(url)
    }


    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func changeRootViewController(viewController:UIViewController) {
        if window?.rootViewController != nil {
            window?.rootViewController = viewController
            return
        }
        
        let snapShot = window?.snapshotViewAfterScreenUpdates(true)
        viewController.view.addSubview(snapShot!)
        window?.rootViewController = viewController
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            snapShot?.layer.opacity = 0
            snapShot?.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
            }) { (flag) -> Void in
            snapShot?.removeFromSuperview()
        }
    }
}

