//
//  ZYMCalendarItem.swift
//  ZhanYeZhuShou
//
//  Created by Owen on 15/7/31.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

import UIKit

class ZYMCalendarItem: NSObject {
    var day:Int!
    var dayNum:Int!
    
    init(day:Int,dayNum:Int) {
        self.day = day
        self.dayNum = dayNum
    }
}
