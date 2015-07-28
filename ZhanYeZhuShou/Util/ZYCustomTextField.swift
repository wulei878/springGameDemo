//
//  XGSearchTextField.swift
//  BiuLiCai
//
//  Created by Owen on 15/5/25.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

import UIKit

class ZYCustomTextField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
//        var attributeString = NSAttributedString(string: "请输入密码", attributes: [NSForegroundColorAttributeName:UIColor.hexColor(0x747083),NSFontAttributeName:UIFont(name: "STHeitiSC-Light", size: 18.0)!])
//        self.attributedPlaceholder = attributeString
//        var imageView = UIImageView(image: UIImage(named: "search_button"))
//        imageView.frame.size = CGSizeMake(15, 15)
//        self.leftView = imageView
//        self.leftViewMode = UITextFieldViewMode.Always
//        self.background = UIImage(named: "searchBorder")
//        self.textColor = UIColor.hexColor(0x747083)
//        self.font = UIFont(name: "STHeitiSC-Light", size: 12.0)!
//        var rightView = UIImageView(image: UIImage(named: "clear_button"))
//        self.rightView = rightView
//        self.rightViewMode = UITextFieldViewMode.WhileEditing
//        rightView.userInteractionEnabled = true
    }
    
    override func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectMake(15, bounds.origin.y, bounds.size.width, bounds.size.height)
    }
    
//    override func leftViewRectForBounds(bounds: CGRect) -> CGRect {
//        return CGRectMake(7, (bounds.height - 15) / 2, 15, 15)
//    }
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectMake(15, bounds.origin.y, bounds.size.width, bounds.size.height)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectMake(15, bounds.origin.y, bounds.size.width, bounds.size.height)
    }
    
    override func rightViewRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectMake(bounds.width - 44, (bounds.height - 44) / 2, 44, 44)
    }

}