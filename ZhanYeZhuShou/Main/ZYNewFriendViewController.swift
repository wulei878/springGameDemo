//
//  ZYNewFriendViewController.swift
//  ZhanYeZhuShou
//
//  Created by Owen on 15/8/2.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

import UIKit

protocol ZYNewFriendViewControllerProtocol:NSObjectProtocol {
    func newFriendViewControllerDidFinished(contacter:ZYMContactor)
}

class ZYNewFriendViewController: UITableViewController,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UITextFieldDelegate {

    var newFriend:ZYMContactor!
    @IBOutlet var separatorHeightArray: [NSLayoutConstraint]!
    
    @IBOutlet weak var nameTextField: ZYCustomTextField!
    @IBOutlet weak var companyNameTextField: ZYCustomTextField!
    @IBOutlet weak var jobTextField: ZYCustomTextField!
    @IBOutlet weak var headerImage: UIImageView!
    
    @IBOutlet weak var addImageView: UIView!
    weak var delegate:ZYNewFriendViewControllerProtocol?
    
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
        attributeString.replaceCharactersInRange(NSMakeRange(0, attributeString.length), withString: "点击填写")
        companyNameTextField.attributedPlaceholder = attributeString
        attributeString.replaceCharactersInRange(NSMakeRange(0, attributeString.length), withString: "点击填写")
        jobTextField.attributedPlaceholder = attributeString
        if newFriend != nil {
            nameTextField.text = newFriend.firstName
        }
        let tap = UITapGestureRecognizer(target: self, action: "changeCard")
        headerImage.addGestureRecognizer(tap)
        headerImage.hidden = true
    }
    @IBAction func doneAction(sender: AnyObject) {
        if nameTextField.text == "" {
            MBProgressHUD.showTimedDetailsTextHUDOnView(view, message: "请输入联系人姓名", animated: true)
            return
        }
        newFriend.firstName = nameTextField.text
        newFriend.companyName = companyNameTextField.text
        newFriend.job = jobTextField.text
        delegate?.newFriendViewControllerDidFinished(newFriend)
        navigationController?.popToRootViewControllerAnimated(true)
    }

    @IBAction func goBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func uploadHeaderAction(sender: AnyObject) {
        let actionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "从照片选取","拍照")
        actionSheet.showInView(view)
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
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        let image = editingInfo[UIImagePickerControllerOriginalImage] as? UIImage
        let imageData = UIImagePNGRepresentation(image)
        imageData.writeToFile(XGFileInfo.filePathWithString("MyCard"), atomically: true)
        headerImage.image = UIImage.scaleImage(image, scaleToSize: CGSizeMake(screen_width, screen_width))
        headerImage.hidden = false
        addImageView.hidden = true
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        if headerImage.image == nil {
            headerImage.hidden = true
        } else {
            headerImage.hidden = false
        }
        addImageView.hidden = !headerImage.hidden
    }
}
