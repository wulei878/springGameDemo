//
//  ZYFriendProfileViewController.swift
//  ZhanYeZhuShou
//
//  Created by Owen on 15/8/2.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

import UIKit

enum ZYFriendProfileType {
    case Record,Profile
}

class ZYFriendProfileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,HPGrowingTextViewDelegate {
    @IBOutlet weak var firstPartHeight: NSLayoutConstraint!

    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet var separatorHeightArray: [NSLayoutConstraint]!
    @IBOutlet weak var dateTabelView: UITableView!
    @IBOutlet weak var recordTabelView: UITableView!
    @IBOutlet weak var bottombar: UIView!
    
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var bottombarBottom: NSLayoutConstraint!
    var textView:HPGrowingTextView!
    @IBOutlet weak var textViewContainer:UIView!
    @IBOutlet weak var textViewContainerHeight: NSLayoutConstraint!
    var placeholderLabel:UILabel!
    @IBOutlet weak var scrollView:UIScrollView!
    var friendProfileType = ZYFriendProfileType.Record
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    
    class func getInstance() -> ZYFriendProfileViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ZYFriendProfileViewController") as! ZYFriendProfileViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for separatorHeight in separatorHeightArray {
            separatorHeight.constant /= UIScreen.mainScreen().scale
        }
        doneButton.layoutIfNeeded()
        customTextViewContainer()
        bottombar.addSubview(textViewContainer)
        let tap = UITapGestureRecognizer(target: self, action: "hideKeyboard")
        view.addGestureRecognizer(tap)
        recordButton.selected = true
    }
    
    func customTextViewContainer() {
        textViewContainer.layoutIfNeeded()
        textViewContainer.layer.borderWidth = 1
        textViewContainer.layer.borderColor = UIColor.hexColor(0x999999).CGColor
        textViewContainer.layer.cornerRadius = textViewContainer.height / 2
        textView = HPGrowingTextView(frame: textViewContainer.bounds)
        textView.contentInset = UIEdgeInsetsMake(6, 18, 6, 18)
        textView.returnKeyType = UIReturnKeyType.Done
        textView.delegate = self
        placeholderLabel = UILabel(frame: textView.bounds)
        placeholderLabel.text = "写点啥..."
        placeholderLabel.font = UIFont(name: "STHeitiSC-Light", size: 15)
        placeholderLabel.textColor = UIColor.hexColor(0x999999)
        textView.font = placeholderLabel.font
        textView.textColor = UIColor.hexColor(0x333333)
        textViewContainer.addSubview(textView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillChangeFrame(notification:NSNotification) {
        let userInfo = notification.userInfo
        if let userInfo = userInfo {
            let value = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue?
            if let value = value {
                let keyBoardRect = value.CGRectValue()
                let keyBoardHeight = keyBoardRect.height
                let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
                if bottombarBottom.constant < keyBoardHeight {
                    bottombarBottom.constant = keyBoardHeight
                    bottombar.setNeedsUpdateConstraints()
                    UIView.animateWithDuration(animationDuration.doubleValue, animations: { () -> Void in
                        self.bottombar.layoutIfNeeded()
                    })
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func messageAction(sender: AnyObject) {
    }
    
    @IBAction func phoneCallAction(sender: AnyObject) {
    }
    
    @IBAction func switchAction(sender: AnyObject) {
        if sender as! UIButton == recordButton {
            friendProfileType = .Record
        } else {
            friendProfileType = .Profile
        }
        switch friendProfileType {
        case .Record:
            scrollView.hidden = true
            recordButton.selected = true
            profileButton.selected = false

        case .Profile:
            scrollView.hidden = false
            customScrollView()
            recordButton.selected = false
            profileButton.selected = true
        }
        dateTabelView.hidden = !scrollView.hidden
        recordTabelView.hidden = !scrollView.hidden
    }
    
    func customScrollView() {
        let backView = UIView(frame: CGRectMake(25, 25, screen_width - 50, 0))
        scrollView.addSubview(backView)
        var top:CGFloat = 0
        var preLabelRight:CGFloat = 0
        for index in 0...10 {
            var label = UILabel()
            label.text = "经常浏览互联网产品"
            label.textAlignment = NSTextAlignment.Center
            label.font = UIFont(name: "STHeitiSC-Light", size: 15)
            label.textColor = UIColor.whiteColor()
            label.sizeToFit()
            label.size = CGSizeMake(label.width + 32, 32)
            label.backgroundColor = UIColor.redColor()
            label.left = preLabelRight
            preLabelRight += label.width + 12
            if label.right > backView.width {
                top += label.height + 15
                label.left = 0
            }
            label.top = top
            backView.addSubview(label)
            if index == 10 {
                backView.height = label.bottom
            }
        }
        scrollView.contentSize = CGSizeMake(scrollView.width, backView.bottom + 25)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == dateTabelView {
            let cell = tableView.dequeueReusableCellWithIdentifier("ZYFriendProfileDateCell", forIndexPath: indexPath) as! ZYFriendProfileDateCell
            return cell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("ZYFriendProfileLogCell", forIndexPath: indexPath) as! ZYFriendProfileLogCell
        return cell
    }
    
    func hideKeyboard() {
        textView.resignFirstResponder()
    }
    
    func growingTextView(growingTextView: HPGrowingTextView!, willChangeHeight height: Float) {
        textViewContainerHeight.constant = CGFloat(height)
        textViewContainer.setNeedsUpdateConstraints()
        UIView.animateWithDuration(growingTextView.animationDuration, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.textViewContainer.layer.cornerRadius = self.textViewContainer.height / 2
            self.bottombar.layoutIfNeeded()
        }) { (finished) -> Void in
            
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == dateTabelView {
            return 1
        }
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView == dateTabelView {
            return 100
        }
        return 41
    }

    @IBAction func goBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func moreAction(sender: AnyObject) {
        MBProgressHUD.showTimedDetailsTextHUDOnView(view, message: "敬请期待", animated: true)
    }
    
}
