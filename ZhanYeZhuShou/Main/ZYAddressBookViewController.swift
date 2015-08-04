//
//  ZYMainViewController.swift
//  XGCG
//
//  Created by Sean on 15/4/10.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

import UIKit
import MessageUI
import AddressBook
import AddressBookUI

class ZYAddressBookViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,MFMessageComposeViewControllerDelegate,ZYAddressBookCellProtocol,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,ABPeoplePickerNavigationControllerDelegate,ZYNewFriendViewControllerProtocol {
    @IBOutlet weak var titleMessageButton: UIButton!
    @IBOutlet weak var newFriendButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addTypeView: UIView!
    @IBOutlet weak var addByScanButton: UIView!
    @IBOutlet weak var addByAddressBookButton: UIView!
    @IBOutlet weak var addByInputButton: UIView!
    var buttons:[UIView]!
    var contacters = [ZYMContactor]()
    var phoneCallWebView:UIWebView!
    
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
        let user = contacters[indexPath.row]
        cell.nameLabel.text = user.firstName
        cell.descLabel.text = user.job
        cell.addressBookCellProtocol = self
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 63
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacters.count
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
            presentViewController(vc, animated: true, completion: { () -> Void in
                UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: false)
            })
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
            if !NSUserDefaults.standardUserDefaults().boolForKey("accessToAddressBook") {
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "accessToAddressBook")
                navigationController?.pushViewController(ZYAddAddressBookFriendViewController.getInstance(), animated: true)
                return
            }
            if ZYAddressBookHelper.sharedInstance().canAccessAdressBook() {
                let peoplePicker = ABPeoplePickerNavigationController()
                peoplePicker.peoplePickerDelegate = self
                presentViewController(peoplePicker, animated: true, completion: { () -> Void in
                    UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: false)
                })
            } else {
                navigationController?.pushViewController(ZYOpenAddressGuideViewController.getInstance(), animated: true)
            }
        } else if tapGesutre.view == addByInputButton {
            let vc = ZYNewFriendViewController.getInstance()
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let actionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "从照片选取","拍照")
            actionSheet.showInView(view)
        }
    }
    
    @IBAction func newFriendAction(sender: AnyObject) {
        addTypeView.hidden = !addTypeView.hidden
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.modalTransitionStyle = .CoverVertical
        imagePicker.allowsEditing = true

        if buttonIndex == 0 {
            actionSheet.dismissWithClickedButtonIndex(buttonIndex, animated: true)
            return
        } else if buttonIndex == 1 {
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        } else if buttonIndex == 2 {
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        }
        actionSheet.dismissWithClickedButtonIndex(buttonIndex, animated: true)
        presentViewController(imagePicker, animated: true, completion: { () -> Void in
            UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: false)
        })
    }
    
    func addressBookCellMakePhoneCall(cell: ZYAddressBookCell) {
        let index = tableView.indexPathForCell(cell)?.row
        let phoneNums = contacters[index!].phoneNumbers[0] as! [String:String]
        var phoneNum = ""
        for (key,value) in phoneNums {
            phoneNum = value
            break
        }
        if phoneCallWebView == nil {
            phoneCallWebView = UIWebView(frame: CGRectZero)
        }
        if phoneNum != "" {
            phoneCallWebView.loadRequest(NSURLRequest(URL: NSURL(string: "tel:" + phoneNum)!))   
        }
    }
    
    func addressBookCellSendMessage(cell: ZYAddressBookCell) {
        let index = tableView.indexPathForCell(cell)?.row
        let phoneNums = contacters[index!].phoneNumbers[0] as! [String:String]
        var phoneNum = ""
        for (key,value) in phoneNums {
            phoneNum = value
            break
        }
        if MFMessageComposeViewController.canSendText() {
            var vc = MFMessageComposeViewController()
            vc.messageComposeDelegate = self
            vc.body = "这是一封短信"
            vc.recipients = [phoneNum]
            presentViewController(vc, animated: true, completion: { () -> Void in
                UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: false)
            })
        }
    }
    
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController!, didSelectPerson person: ABRecord!) {
        let vc = ZYNewFriendViewController.getInstance()
        vc.newFriend = ZYMContactor(ABRecord: person)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func newFriendViewControllerDidFinished(contacter: ZYMContactor) {
        contacters.append(contacter)
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    func addressBookCellViewPersonalMainPage(cell: ZYAddressBookCell) {
        let index = tableView.indexPathForCell(cell)?.row
        let contacter = contacters[index!]
        let vc = ZYFriendProfileViewController.getInstance()
        navigationController?.pushViewController(vc, animated: true)
    }
}
