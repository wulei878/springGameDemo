//
//  ZYInputtingPhoneNumViewController.swift
//  ZhanYeZhuShou
//
//  Created by Owen on 15/7/29.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

import UIKit

class ZYInputtingPhoneNumViewController: UIViewController {

    @IBOutlet weak var phoneNumTextFiled: ZYCustomTextField!
    @IBOutlet weak var separatorHeight: NSLayoutConstraint!
    @IBOutlet weak var nextButton: UIButton!
    
    class func getInstance()->ZYInputtingPhoneNumViewController {
        return UIStoryboard(name: "ZYLoginViewController", bundle: nil).instantiateViewControllerWithIdentifier("ZYInputtingPhoneNumViewController") as! ZYInputtingPhoneNumViewController
    }
    
    @IBAction func goBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func goNext(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        separatorHeight.constant /= UIScreen.mainScreen().scale
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        UIApplication.sharedApplication().statusBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
