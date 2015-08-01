//
//  ZYNewScheduleView.swift
//  ZhanYeZhuShou
//
//  Created by Owen on 15/8/1.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

import UIKit

class ZYNewScheduleView: UIView {
    
    @IBOutlet weak var textView: UITextView!
    
    
    class func getInstance() -> ZYNewScheduleView {
        return UINib(nibName: "ZYNewScheduleView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! ZYNewScheduleView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func closeAction(sender: AnyObject) {
        hidden = true
    }
}
