//
//  ZYInputtingPhoneNumViewController.swift
//  ZhanYeZhuShou
//
//  Created by Owen on 15/7/29.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

import UIKit

let phoneNumberCount = 11
class ZYInputtingPhoneNumViewController: UIViewController,UITextFieldDelegate {

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
        ZYLoginManager.sharedManager.loginPhoneNum = phoneNumTextFiled.text
        navigationController?.pushViewController(ZYVerificationCodeViewController.getInstance(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        separatorHeight.constant /= UIScreen.mainScreen().scale
        nextButton.enabled = false
        nextButton.setBackgroundImage(UIImage.imageWithColor(UIColor.hexColor(0xd3d3d3)), forState: .Disabled)
        nextButton.setBackgroundImage(UIImage.imageWithColor(UIColor.hexColor(0x33b7ff)), forState: .Normal)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textFieldTextDidChange", name: UITextFieldTextDidChangeNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldTextDidChange() {
        var text = phoneNumTextFiled.text
        if count(text) >= phoneNumberCount {
            phoneNumTextFiled.text = text.substringToIndex(advance(text.startIndex, phoneNumberCount))
            nextButton.enabled = true
        } else if count(text) < phoneNumberCount {
            nextButton.enabled = false
        }
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
