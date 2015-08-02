//
//  ZYFriendProfileLogCell.swift
//  ZhanYeZhuShou
//
//  Created by Owen on 15/8/2.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

import UIKit

let ZYFriendProfileNameColor = UIColor.hexColor(0x333333)
let ZYFriendProfileRcordColor = UIColor.hexColor(0x666666)

class ZYFriendProfileLogCell: UITableViewCell {
    @IBOutlet weak var recordLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        var attributedText:NSMutableAttributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: "祝佳", attributes: [NSForegroundColorAttributeName:UIColor.hexColor(0x333333)]))
        let text2 = NSAttributedString(string: "创建了客户", attributes: [NSForegroundColorAttributeName:UIColor.hexColor(0x666666)])
        let text3 = NSAttributedString(string: "钟秀", attributes: [NSForegroundColorAttributeName:UIColor.hexColor(0x333333)])
        
        attributedText.insertAttributedString(text2, atIndex: attributedText.length)
        attributedText.insertAttributedString(text3, atIndex: attributedText.length)
        recordLabel.attributedText = attributedText
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
