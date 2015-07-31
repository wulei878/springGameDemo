//
//  ZYMainViewController.swift
//  XGCG
//
//  Created by Sean on 15/4/10.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

import UIKit

class ZYAddressBookViewController: UIViewController {

    class func getInstance() -> ZYAddressBookViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ZYAddressBookViewController") as! ZYAddressBookViewController
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
