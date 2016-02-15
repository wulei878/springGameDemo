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
    
    func find(array:[Int]!,rows:Int,columns:Int,num:Int)->Bool {
        if array == nil || rows <= 0 || columns <= 0 {
            return false
        }
        var row = 0
        var column = columns - 1
        while row < rows && columns >= 0 {
            let number = array[row * columns + column]
            if number == num {
                return true
            } else if number > num {
                column--
            } else {
                row++
            }
        }
        return false
    }
}
