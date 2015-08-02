//
//  ZYChooseWayToAddViewController.swift
//  ZhanYeZhuShou
//
//  Created by Owen on 15/8/1.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

import UIKit

class ZYChooseWayToAddViewController: UITableViewController {
    @IBOutlet var separatorHeightArray: [NSLayoutConstraint]!

    
    class func getInstance() -> ZYChooseWayToAddViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ZYChooseWayToAddViewController") as! ZYChooseWayToAddViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for separatorHeight in separatorHeightArray {
            separatorHeight.constant /= UIScreen.mainScreen().scale
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        if indexPath.row == 3 {
            navigationController?.pushViewController(ZYNewFriendViewController.getInstance(), animated: true)
        }
    }

    @IBAction func goBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
