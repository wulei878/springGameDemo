//
//  ZYNewFriendViewController.swift
//  ZhanYeZhuShou
//
//  Created by Owen on 15/8/2.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

import UIKit

class ZYNewFriendViewController: UITableViewController {

    var newFriend:ZYMContactor!
    @IBOutlet var separatorHeightArray: [NSLayoutConstraint]!
    
    @IBOutlet weak var nameTextField: ZYCustomTextField!
    @IBOutlet weak var companyNameTextField: ZYCustomTextField!
    @IBOutlet weak var jobTextField: ZYCustomTextField!
    
    class func getInstance() -> ZYNewFriendViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ZYNewFriendViewController") as! ZYNewFriendViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for separatorHeight in separatorHeightArray {
            separatorHeight.constant /= UIScreen.mainScreen().scale
        }
        var attributeString = NSMutableAttributedString(attributedString: NSAttributedString(string: "必填", attributes: [NSForegroundColorAttributeName:UIColor.hexColor(0x999999),NSFontAttributeName:UIFont(name: "STHeitiSC-Light", size: 15.0)!]))
        nameTextField.attributedPlaceholder = attributeString
        attributeString.replaceCharactersInRange(NSMakeRange(0, attributeString.length), withString: "点击选择")
        companyNameTextField.attributedPlaceholder = attributeString
        attributeString.replaceCharactersInRange(NSMakeRange(0, attributeString.length), withString: "点击填写")
        jobTextField.attributedPlaceholder = attributeString
        nameTextField.text = newFriend.firstName
    }
    @IBAction func doneAction(sender: AnyObject) {
        navigationController?.popToRootViewControllerAnimated(true)
    }

    @IBAction func goBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
