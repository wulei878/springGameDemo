//
//  ZYNewScheduleView.swift
//  ZhanYeZhuShou
//
//  Created by Owen on 15/8/1.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

import UIKit

class ZYNewScheduleViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    
    class func getInstance() -> ZYNewScheduleViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ZYNewScheduleViewController") as! ZYNewScheduleViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func closeAction(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
}
