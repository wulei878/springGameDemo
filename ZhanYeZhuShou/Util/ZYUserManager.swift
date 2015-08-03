//
//  ZYUserManager.swift
//  ZhanYeZhuShou
//
//  Created by Owen on 15/8/3.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

import UIKit

private let sharedInstance = ZYUserManager()

class ZYUserManager: NSObject {
    class var sharedManager : ZYUserManager {
        return sharedInstance
    }
    
    var userItem:ZYMUserItem?
}
