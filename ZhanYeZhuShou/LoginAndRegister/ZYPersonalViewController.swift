//
//  ZYMainViewController.swift
//  XGCG
//
//  Created by Sean on 15/4/10.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

import UIKit

class ZYPersonalViewController: UIViewController {

    class func getInstance() -> ZYPersonalViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ZYPersonalViewController") as! ZYPersonalViewController
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
