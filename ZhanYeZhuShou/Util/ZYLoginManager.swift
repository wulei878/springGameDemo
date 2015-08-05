//
//  ZYLoginManager.swift
//  ZhanYeZhuShou
//
//  Created by Owen on 15/8/5.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

import UIKit

private let sharedInstance = ZYLoginManager()

class ZYLoginManager: NSObject {
    class var sharedManager : ZYLoginManager {
        return sharedInstance
    }
    
    var loginPhoneNum:String?
    var loginPassword:String?
}
