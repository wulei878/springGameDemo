//
//  ZYScheduleCell.swift
//  ZhanYeZhuShou
//
//  Created by Owen on 15/7/31.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

import UIKit

class ZYScheduleCell: UITableViewCell {
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var timeIntervalLabel: UILabel!
    @IBOutlet weak var separatorHeight: NSLayoutConstraint!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var delayButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        separatorHeight.constant /= UIScreen.mainScreen().scale
        UIButton.changeButtonsVertical(5, buttons: [doneButton,delayButton,editButton])
    }
    
    func configData(item:ZYMScheduleItem) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        paragraphStyle.alignment = NSTextAlignment.Center
        let attributedString = NSMutableAttributedString(string: item.timeInterval, attributes: [NSParagraphStyleAttributeName:paragraphStyle])
        timeIntervalLabel.attributedText = attributedString
        if item.selected {
            separator.hidden = true
        } else {
            separator.hidden = false
        }
        menuView.hidden = !separator.hidden
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
