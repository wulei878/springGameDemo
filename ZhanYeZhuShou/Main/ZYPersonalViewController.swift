//
//  ZYMainViewController.swift
//  XGCG
//
//  Created by Sean on 15/4/10.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

import UIKit

class ZYPersonalViewController: UITableViewController {
    @IBOutlet var separatorHeightArray: [NSLayoutConstraint]!

    @IBOutlet weak var headerImageView: UIImageView!
    class func getInstance() -> ZYPersonalViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ZYPersonalViewController") as! ZYPersonalViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for separatorHeight in separatorHeightArray {
            separatorHeight.constant /= UIScreen.mainScreen().scale
        }
        headerImageView.clipsToRound()
        headerImageView.image = UIImage.imageWithColor(UIColor.hexColor(0x33b7ff))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        (navigationController?.parentViewController as! ZYMainViewController).showTabBar()
        navigationController?.navigationBar.barTintColor = UIColor.hexColor(0x33b7ff)
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if let navi = navigationController {
            (navi.parentViewController as! ZYMainViewController).hideTabBar()
        }
    }
    
    @IBAction func logoutAction(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.changeRootViewController(ZYLoginViewController.getInstance())
    }
    
}
