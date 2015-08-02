//
//  ZYSetPasswordViewController.swift
//  ZhanYeZhuShou
//
//  Created by Owen on 15/7/29.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

import UIKit

class ZYSetPasswordViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var passwordTextField: ZYPasswordTextField!
    @IBOutlet weak var confirmTextField: ZYPasswordTextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet var separatorHeightArray: [NSLayoutConstraint]!
    var currentTextField:UITextField?
    
    class func getInstance()->ZYSetPasswordViewController {
        return UIStoryboard(name: "ZYLoginViewController", bundle: nil).instantiateViewControllerWithIdentifier("ZYSetPasswordViewController") as! ZYSetPasswordViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var attributeString = NSAttributedString(string: "再次输入密码", attributes: [NSForegroundColorAttributeName:UIColor.hexColor(0x999999),NSFontAttributeName:UIFont(name: "STHeitiSC-Light", size: 18.0)!])
        confirmTextField.attributedPlaceholder = attributeString
        doneButton.enabled = false
        doneButton.setBackgroundImage(UIImage.imageWithColor(UIColor.hexColor(0xd3d3d3)), forState: .Disabled)
        doneButton.setBackgroundImage(UIImage.imageWithColor(UIColor.hexColor(0x33b7ff)), forState: .Normal)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textFieldTextDidChange", name: UITextFieldTextDidChangeNotification, object: nil)
        let tap1 = UITapGestureRecognizer(target: self, action: "showPassword:")
        passwordTextField.rightView!.addGestureRecognizer(tap1)
        passwordTextField.rightView?.tag = 1
        let tap2 = UITapGestureRecognizer(target: self, action: "showPassword:")
        confirmTextField.rightView!.addGestureRecognizer(tap2)
        confirmTextField.rightView?.tag = 2
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textFieldTextDidChange", name: UITextFieldTextDidChangeNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func textFieldTextDidChange() {
        var text = currentTextField!.text
        if count(text) > 12 {
            currentTextField?.text = text.substringToIndex(advance(text.startIndex, 12))
        }
        if count(currentTextField!.text) > 0 {
            doneButton.enabled = true
        }
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        currentTextField = textField
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func doneAction(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.changeRootViewController(ZYMainViewController.getInstance())
    }

    @IBAction func goBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func showPassword(gesture:UITapGestureRecognizer) {
        let textField = gesture.view?.tag == 1 ? passwordTextField : confirmTextField
        textField.secureTextEntry = !textField.secureTextEntry
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
