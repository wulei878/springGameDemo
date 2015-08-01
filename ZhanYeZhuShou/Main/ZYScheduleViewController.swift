//
//  ZYMainViewController.swift
//  XGCG
//
//  Created by Sean on 15/4/10.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

import UIKit

class ZYScheduleViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var calendarData = [ZYMCalendarItem]()
    let calendarDay = ["日","一","二","三","四","五","六",]
    @IBOutlet weak var calendarDayContainer: UIView!
    let cellWidth = screen_width / 7
    var scheduleData = [ZYMScheduleItem]()
    var newScheduleView:ZYNewScheduleView?
    
    class func getInstance() -> ZYScheduleViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ZYScheduleViewController") as! ZYScheduleViewController
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.registerNib(UINib(nibName: "ZYElementViews", bundle: nil), forCellWithReuseIdentifier: "ZYCalendarCell")
        customUI()
        let array = [1,2,3,4,5,6,7,8,9,10,11,12,13,14]
        for (index, dayNum) in enumerate(array) {
            var item = ZYMCalendarItem(day: index % 7, dayNum: dayNum)
            calendarData.append(item)
        }
        for index in 0...3 {
            let item = ZYMScheduleItem()
            item.timeInterval = "11:00\n/\n12:00"
            scheduleData.append(item)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.Default, animated: false)
        if navigationController != nil {
            (navigationController?.parentViewController as! ZYMainViewController).hideTabBar()
        }
    }
    
    func customUI() {
        calendarDayContainer.layoutIfNeeded()
        for (index, day) in enumerate(calendarDay) {
            var label = UILabel(frame: CGRectMake(CGFloat(index) * cellWidth, 0, cellWidth, calendarDayContainer.height))
            label.font = UIFont(name: "STHeitiSC-Light", size: 11)
            label.textColor = UIColor.hexColorWithAlpha(0xffffff, alpha: 1)
            label.textAlignment = NSTextAlignment.Center
            label.text = day
            if day == "日" || day == "六" {
                label.textColor = UIColor.hexColorWithAlpha(0xffffff, alpha: 0.5)
            }
            calendarDayContainer.addSubview(label)
        }
    }

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendarData.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("ZYCalendarCell", forIndexPath: indexPath) as! ZYCalendarCell
        cell.configData(calendarData[indexPath.row])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(cellWidth, 66)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let item = scheduleData[indexPath.row]
        if item.selected {
            return 85 + 50
        } else {
            return 85
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ZYScheduleCell", forIndexPath: indexPath) as! ZYScheduleCell
        cell.configData(scheduleData[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = scheduleData[indexPath.row]
        item.selected = !item.selected
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    @IBAction func addNewAction(sender: AnyObject) {
        if newScheduleView == nil {
            newScheduleView = ZYNewScheduleView.getInstance()
            newScheduleView?.size = CGSizeMake(view.width, 440)
            newScheduleView?.center = CGPointMake(view.width / 2, view.height / 2)
            newScheduleView?.layoutIfNeeded()
            view.addSubview(newScheduleView!)
        }
        newScheduleView?.hidden = false
    }
}
