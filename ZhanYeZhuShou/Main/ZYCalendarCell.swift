//
//  ZYCalendarCell.swift
//  ZhanYeZhuShou
//
//  Created by Owen on 15/7/30.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

import UIKit

class ZYCalendarCell: UICollectionViewCell {
    @IBOutlet weak var dayNumButton: UIButton!
    @IBOutlet weak var whiteDot: UIView!
    
    
    class func getInstance() -> ZYCalendarCell {
        return UINib(nibName: "ZYElementViews", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! ZYCalendarCell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        whiteDot.layer.cornerRadius = whiteDot.height / 2
    }
    
    func configData(data:ZYMCalendarItem) {
        dayNumButton.setTitle("\(data.dayNum)", forState: .Normal)
        dayNumButton.setTitleColor(UIColor.hexColorWithAlpha(0xffffff, alpha: 1), forState: .Normal)
        if data.day == 0 || data.day == 6 {
            dayNumButton.alpha = 0.5
        } else {
            dayNumButton.alpha = 1
        }
        whiteDot.alpha = dayNumButton.alpha
    }
}
 