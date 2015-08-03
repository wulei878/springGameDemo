//
//  ViewController.swift
//  ZhanYeZhuShou
//
//  Created by Owen on 15/7/28.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

import UIKit

class ZYLoginViewController: UIViewController,UIScrollViewDelegate,UITextFieldDelegate {
    @IBOutlet weak var phoneNumTextField: ZYCustomTextField!
    @IBOutlet var separatorHeightArray: [NSLayoutConstraint]!

    @IBOutlet weak var passwordTextField: ZYPasswordTextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    var currentTextField:UITextField?
    @IBOutlet weak var secondPartView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    class func getInstance()->ZYLoginViewController {
        return UIStoryboard(name: "ZYLoginViewController", bundle: nil).instantiateViewControllerWithIdentifier("ZYLoginViewController") as! ZYLoginViewController
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.layer.borderWidth = 1 / UIScreen.mainScreen().scale
        registerButton.layer.borderColor = UIColor.hexColor(0x33b7ff).CGColor
        let tap = UITapGestureRecognizer(target: self, action: "showPassword:")
        passwordTextField.rightView!.addGestureRecognizer(tap)
        for heightConstraint in separatorHeightArray {
            heightConstraint.constant /= UIScreen.mainScreen().scale
        }
        let scrollViewTap = UITapGestureRecognizer(target: self, action: "hideKeyboard")
        scrollView.addGestureRecognizer(scrollViewTap)
        if navigationController!.respondsToSelector("interactivePopGestureRecognizer") {
            navigationController?.interactivePopGestureRecognizer.delegate = nil
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func keyboardWillChangeFrame(notification:NSNotification) {
        let userInfo = notification.userInfo
        if let userInfo = userInfo {
            let value = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue?
            if let value = value {
                let keyBoardRect = value.CGRectValue()
                let keyBoardHeight = keyBoardRect.height
                let point = view.convertPoint(CGPointMake(0, currentTextField!.bottom + 1), fromView: secondPartView)
                if point.y + keyBoardHeight > view.height {
                    scrollView.setContentOffset(CGPointMake(0, point.y + keyBoardHeight - view.height), animated: true)
                } else {
                    scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
                }
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        currentTextField = textField
        return true
    }

    func hideKeyboard() {
        currentTextField?.resignFirstResponder()
    }

    @IBAction func loginAction(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.changeRootViewController(ZYMainViewController.getInstance())
    }

    @IBAction func forgotPasswordAction(sender: AnyObject) {
        navigationController?.pushViewController(ZYInputtingPhoneNumViewController.getInstance(), animated: true)
    }
    @IBAction func registerAction(sender: AnyObject) {
        let viewController = ZYInputtingPhoneNumViewController.getInstance()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showPassword(gesture:UITapGestureRecognizer) {
        passwordTextField.secureTextEntry = !passwordTextField.secureTextEntry
    }
    
}

