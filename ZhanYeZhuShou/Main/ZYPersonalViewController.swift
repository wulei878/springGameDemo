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

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var headerImageView: UIImageView!
    class func getInstance() -> ZYPersonalViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ZYPersonalViewController") as! ZYPersonalViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for separatorHeight in separatorHeightArray {
            separatorHeight.constant /= UIScreen.mainScreen().scale
        }
        let userItem = ZYUserManager.sharedManager.userItem
        headerImageView.clipsToRound()
        headerImageView.sd_setImageWithURL(userItem?.headURL, placeholderImage: UIImage.imageWithColor(UIColor.hexColor(0x33b7ff)))
        userNameLabel.text = userItem?.userName
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
        let object = GZThirdPartyObject()
        object.shareDestionation = .WeixinLogout
        GZThirdPartyManager.sharedInstance().logoutWithShareObject(object)
        NSFileManager.defaultManager().removeItemAtPath(XGFileInfo.filePathAppendingUserIDWithString("UserInfo"), error: nil)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.changeRootViewController(ZYPreLoginViewController.getInstance())
    }
    
}
