//
//  ZYVerificationCodeViewController.swift
//  ZhanYeZhuShou
//
//  Created by Owen on 15/7/29.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

import UIKit

class ZYVerificationCodeViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var phoneNumLabel: UILabel!
    @IBOutlet weak var verficationCodeView: UIView!
    @IBOutlet weak var resendCodeButton: UIButton!
    var textField:UITextField!
    var codeLabels:[UILabel]?
    
    class func getInstance()->ZYVerificationCodeViewController {
        return UIStoryboard(name: "ZYLoginViewController", bundle: nil).instantiateViewControllerWithIdentifier("ZYVerificationCodeViewController") as! ZYVerificationCodeViewController
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        verficationCodeView.layoutIfNeeded()
        customUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textFieldTextDidChange", name: UITextFieldTextDidChangeNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func customUI() {
        textField = UITextField(frame: verficationCodeView.bounds)
        verficationCodeView.addSubview(textField)
        codeLabels = [UILabel]()
        for index in 0...3 {
            var label = UILabel(frame: CGRectMake(CGFloat(index) * (44 + 15), 0, 44, verficationCodeView.height - 11))
            label.font = UIFont(name: "HelveticaNeue", size: 24)
            label.textColor = UIColor.hexColor(0x33b7ff)
            label.textAlignment = NSTextAlignment.Center
            var bottomLine = UIView(frame: CGRectMake(label.left, label.bottom + 10, label.width, 1/UIScreen.mainScreen().scale))
            bottomLine.backgroundColor = label.textColor
            verficationCodeView.addSubview(label)
            verficationCodeView.addSubview(bottomLine)
            codeLabels?.append(label)
        }
        textField.hidden = true
        textField.keyboardType = UIKeyboardType.NumberPad
        textField.becomeFirstResponder()
    }
    
    func textFieldTextDidChange() {
        var text = textField.text
        if count(text) > 4 {
            textField.text = text.substringToIndex(advance(text.startIndex, 4))
        } else {
            let myText = text as NSString
            for var i=0;i<codeLabels?.count;i++ {
                if i > myText.length - 1 {
                    codeLabels![i].text = ""
                } else {
                    codeLabels![i].text = myText.substringWithRange(NSRange(location: i, length: 1))
                }
            }
        }
        
        if count(textField.text) == 4 {
            navigationController?.pushViewController(ZYSetPasswordViewController.getInstance(), animated: true)
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func goBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func resendAction(sender: AnyObject) {
    }
}
