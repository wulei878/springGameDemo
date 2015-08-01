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
        navigationController?.setNavigationBarHidden(true, animated: false)
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
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

    @IBAction func messageAction(sender: AnyObject) {
    }
    
    @IBAction func newFriendAction(sender: AnyObject) {
        
    }
    
}
