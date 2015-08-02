//
//  ZYFriendProfileDateCell.swift
//  ZhanYeZhuShou
//
//  Created by Owen on 15/8/2.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

import UIKit

class ZYFriendProfileDateCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        dateLabel.numberOfLines = 0
        dateLabel.text = "13\n07"
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
