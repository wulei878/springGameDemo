//
//  ZYInputNewScheduleViewController.swift
//  ZhanYeZhuShou
//
//  Created by Owen on 15/8/5.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

import UIKit

class ZYInputNewScheduleViewController: UITableViewController {
    @IBOutlet var separatorHeight: [NSLayoutConstraint]!

    @IBOutlet weak var descTextField: ZYCustomTextField!
    
    @IBOutlet weak var remindTextField: ZYCustomTextField!
    @IBOutlet weak var locationTextField: ZYCustomTextField!
    @IBOutlet weak var beginTimeTextField: ZYCustomTextField!
    class func getInstance() -> ZYOpenAddressGuideViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ZYOpenAddressGuideViewController") as! ZYOpenAddressGuideViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for height in separatorHeight {
            height.constant /= UIScreen.mainScreen().scale
        }
        var attributeString = NSMutableAttributedString(attributedString: NSAttributedString(string: "日程", attributes: [NSForegroundColorAttributeName:UIColor.hexColor(0x999999),NSFontAttributeName:UIFont(name: "STHeitiSC-Light", size: 15.0)!]))
        descTextField.attributedPlaceholder = attributeString
        attributeString.replaceCharactersInRange(NSMakeRange(0, attributeString.length), withString: "点击选择")
        beginTimeTextField.attributedPlaceholder = attributeString
        remindTextField.attributedPlaceholder = attributeString
        attributeString.replaceCharactersInRange(NSMakeRange(0, attributeString.length), withString: "点击填写")
        locationTextField.attributedPlaceholder = attributeString
        let datePicker = UIDatePicker(frame: CGRectMake(0, 0, screen_width, 300))
        datePicker.minimumDate = NSDate()
        datePicker.datePickerMode = .DateAndTime
        beginTimeTextField.inputView = datePicker
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
