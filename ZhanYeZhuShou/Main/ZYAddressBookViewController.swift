//
//  ZYMainViewController.swift
//  XGCG
//
//  Created by Sean on 15/4/10.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

import UIKit

class ZYAddressBookViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var titleMessageButton: UIButton!
    @IBOutlet weak var newFriendButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    class func getInstance() -> ZYAddressBookViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ZYAddressBookViewController") as! ZYAddressBookViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    
    @IBAction func newFriendAction(sender: AnyObject) {
        navigationController?.pushViewController(ZYChooseWayToAddViewController.getInstance(), animated: true)
    }
    
}
