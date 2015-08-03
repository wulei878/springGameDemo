//
//  ZYMUserItem.swift
//  ZhanYeZhuShou
//
//  Created by Owen on 15/8/3.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

import UIKit

class ZYMUserItem: NSObject {
    var userID:String!
    var userName:String!
    var gender:Int!
    var headURL:NSURL!
    
    init(dic:[NSObject:AnyObject]) {
        userID = dic["userID"] as? String
        headURL = NSURL(string: (dic["headURL"] as? String)!)
    }
}
