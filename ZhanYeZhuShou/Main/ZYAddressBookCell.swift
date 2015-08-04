//
//  ZYAddressBookCell.swift
//  ZhanYeZhuShou
//
//  Created by Owen on 15/8/1.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

import UIKit

protocol ZYAddressBookCellProtocol:NSObjectProtocol {
    func addressBookCellMakePhoneCall(cell:ZYAddressBookCell)
    func addressBookCellSendMessage(cell:ZYAddressBookCell)
}

class ZYAddressBookCell: UITableViewCell {

    @IBOutlet weak var separatorHeight: NSLayoutConstraint!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    weak var addressBookCellProtocol:ZYAddressBookCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        separatorHeight.constant /= UIScreen.mainScreen().scale
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func phoneCallAction(sender: AnyObject) {
        addressBookCellProtocol?.addressBookCellMakePhoneCall(self)
    }
    
    @IBAction func messageAction(sender: AnyObject) {
        addressBookCellProtocol?.addressBookCellSendMessage(self)
    }
}
