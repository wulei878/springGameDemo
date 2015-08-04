//
//  ZYMainViewController.swift
//  XGCG
//
//  Created by Sean on 15/4/10.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

import UIKit
import MessageUI

class ZYAddressBookViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,MFMessageComposeViewControllerDelegate,ZYAddressBookCellProtocol {
    @IBOutlet weak var titleMessageButton: UIButton!
    @IBOutlet weak var newFriendButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addTypeView: UIView!
    @IBOutlet weak var addByScanButton: UIView!
    @IBOutlet weak var addByAddressBookButton: UIView!
    @IBOutlet weak var addByInputButton: UIView!
    var buttons:[UIView]!
    
    @IBOutlet var separatorHeight: [NSLayoutConstraint]!

    class func getInstance() -> ZYAddressBookViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ZYAddressBookViewController") as! ZYAddressBookViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTypeView.hidden = true
        buttons = [addByScanButton,addByAddressBookButton,addByInputButton]
        for view in buttons {
            let tap = UITapGestureRecognizer(target: self, action: "tapAction:")
            view.addGestureRecognizer(tap)
        }
        for height in separatorHeight {
            height.constant /= UIScreen.mainScreen().scale
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor.hexColor(0x33b7ff)
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        (navigationController?.parentViewController as! ZYMainViewController).showTabBar()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if let navi = navigationController {
            (navi.parentViewController as! ZYMainViewController).hideTabBar()
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ZYAddressBookCell", forIndexPath: indexPath) as! ZYAddressBookCell
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 63
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        navigationController?.pushViewController(ZYFriendProfileViewController.getInstance(), animated: true)
    }

    @IBAction func messageAction(sender: AnyObject) {
        if MFMessageComposeViewController.canSendText() {
            var vc = MFMessageComposeViewController()
            vc.messageComposeDelegate = self
            vc.body = "这是一封短信"
        }
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        var string = "发送失败"
        switch result.value {
        case MessageComposeResultCancelled.value:
            string = "发送已被取消"
        case MessageComposeResultSent.value:
            string = "发送成功"
        case MessageComposeResultFailed.value:
            string = "发送失败"
        default:
            break;
        }
        MBProgressHUD.showTimedDetailsTextHUDOnView(view.window, message: "发送成功", animated: true)
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tapAction(tapGesutre:UITapGestureRecognizer) {
        if tapGesutre.view == addByAddressBookButton {
            navigationController?.pushViewController(ZYAddAddressBookFriendViewController.getInstance(), animated: true)
        } else if tapGesutre.view == addByInputButton {
            navigationController?.pushViewController(ZYNewFriendViewController.getInstance(), animated: true)
        } else {
            
        }
    }
    
    @IBAction func newFriendAction(sender: AnyObject) {
        addTypeView.hidden = !addTypeView.hidden
    }
    
    func addressBookCellMakePhoneCall(cell: ZYAddressBookCell) {
        let index = tableView.indexPathForCell(cell)?.row
        
    }
    
    func addressBookCellSendMessage(cell: ZYAddressBookCell) {
        let index = tableView.indexPathForCell(cell)?.row
    }
    
}
