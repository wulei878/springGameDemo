//
//  ZYPreLoginViewController.swift
//  ZhanYeZhuShou
//
//  Created by Owen on 15/8/3.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

import UIKit

class ZYPreLoginViewController: UIViewController {
    @IBOutlet weak var wechatButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!

    class func getInstance()->UINavigationController {
        return UIStoryboard(name: "ZYLoginViewController", bundle: nil).instantiateInitialViewController() as! UINavigationController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.layer.borderWidth = 1 / UIScreen.mainScreen().scale
        registerButton.layer.borderColor = UIColor.hexColor(0x33b7ff).CGColor
        loginButton.layer.borderWidth = 1 / UIScreen.mainScreen().scale
        loginButton.layer.borderColor = UIColor.hexColor(0x33b7ff).CGColor
        wechatButton.centerButtonWithSpacing(15)
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: false)
        if navigationController!.respondsToSelector("interactivePopGestureRecognizer") {
            navigationController?.interactivePopGestureRecognizer.delegate = nil
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    @IBAction func wechatLoginAction(sender: AnyObject) {
        let thirdParty = GZThirdPartyManager.sharedInstance()
        let thirdPartyObject = GZThirdPartyObject()
        thirdPartyObject.shareDestionation = EThirdPartyDestination.WeChatLogin
        thirdParty.thirdPartyActionWithShareObject(thirdPartyObject, completionBlock: { (errorCode, info) -> Void in
            if errorCode == 0 {
                thirdParty.getUserInfoWithShareObject(thirdPartyObject, completionBlock: { (errorCode, dic) -> Void in
                    let userItem = ZYMUserItem()
                    userItem.setObject(dic)
                    ZYUserManager.sharedManager.userItem = userItem
                    userItem.wechatToken = info["token"] as? String
                    NSKeyedArchiver.archiveRootObject(userItem, toFile: XGFileInfo.filePathAppendingUserIDWithString("UserInfo"))
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDelegate.changeRootViewController(ZYMainViewController.getInstance())
                })
            }
        })
    }
    
    @IBAction func registerAction(sender: AnyObject) {
        navigationController?.pushViewController(ZYInputtingPhoneNumViewController.getInstance(), animated: true)
    }
    
    @IBAction func loginAction(sender: AnyObject) {
        navigationController?.pushViewController(ZYLoginViewController.getInstance(), animated: true)
    }
}
