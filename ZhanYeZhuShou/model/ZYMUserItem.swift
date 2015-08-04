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
    var wechatToken:String?
    var token:String!
    
    func setObject(dic:[NSObject:AnyObject]) {
        userID = dic["userID"] as? String
        headURL = NSURL(string: (dic["headURL"] as? String)!)
    }
    
    override init() {}
    
    required init(coder aDecoder: NSCoder) {
        userID  = aDecoder.decodeObjectForKey("userID") as? String
        headURL = aDecoder.decodeObjectForKey("headURL") as? NSURL
        wechatToken = aDecoder.decodeObjectForKey("wechatToken") as? String
        token = aDecoder.decodeObjectForKey("token") as? String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(userID, forKey: "userID")
        aCoder.encodeObject(headURL,forKey:"headURL")
        aCoder.encodeObject(wechatToken, forKey: "wechatToken")
        aCoder.encodeObject(token, forKey: "token")
    }
}
