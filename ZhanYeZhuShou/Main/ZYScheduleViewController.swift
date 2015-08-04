//
//  ZYMainViewController.swift
//  XGCG
//
//  Created by Sean on 15/4/10.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

import UIKit

class ZYScheduleViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,FSCalendarDataSource, FSCalendarDelegate {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var topView: UIView!
    var calendarData = [ZYMCalendarItem]()
    let calendarDay = ["日","一","二","三","四","五","六",]
    let cellWidth = screen_width / 7
    var scheduleData = [ZYMScheduleItem]()
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarBottom: NSLayoutConstraint!
    
    
    class func getInstance() -> ZYScheduleViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ZYScheduleViewController") as! ZYScheduleViewController
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        customUI()
        for index in 0...3 {
            let item = ZYMScheduleItem()
            item.timeInterval = "11:00\n/\n12:00"
            scheduleData.append(item)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let navi = navigationController {
            navi.setNavigationBarHidden(true, animated: false)
        }
        (navigationController?.parentViewController as! ZYMainViewController).showTabBar()
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
        let swipe1 = UISwipeGestureRecognizer(target: self, action: "swipeAction:")
        swipe1.direction = .Down
        let swipe2 = UISwipeGestureRecognizer(target: self, action: "swipeAction:")
        swipe2.direction = .Up
        topView.addGestureRecognizer(swipe1)
        topView.addGestureRecognizer(swipe2)
        calendar.layoutIfNeeded()
        calendar.delegate = self
        calendar.selectedDate = NSDate()
        calendar.dataSource = self
        calendar.appearance.weekdayFont = UIFont(name: "STHeitiSC-Light", size: 11)
        calendar.appearance.weekdayTextColor = UIColor.whiteColor()
        calendar.appearance.titleFont = UIFont(name: "Helvetica-Bold", size: 15)
        calendar.appearance.titleDefaultColor = UIColor.whiteColor()
        calendar.appearance.titleSelectionColor = UIColor.hexColor(0x33b7ff)
        calendar.appearance.selectionColor = UIColor.whiteColor()
        calendar.appearance.titlePlaceholderColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        calendar.appearance.eventColor = UIColor.whiteColor()
        calendar.appearance.autoAdjustTitleSize = false
        calendar.needsAdjustingMonthPosition = true
    }

    func swipeAction(gesture:UISwipeGestureRecognizer) {
        if gesture.direction == .Down && topViewHeight.constant < 400 {
            self.calendar.sectionCount = 5
            topViewHeight.constant = 400
            calendarBottom.constant = 64
            view.setNeedsUpdateConstraints()
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.view.layoutIfNeeded()
            })
        } else if gesture.direction == .Up && topViewHeight.constant == 400 {
            self.calendar.sectionCount = 1
            topViewHeight.constant = 160
            calendarBottom.constant = 20
            view.setNeedsUpdateConstraints()
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.view.layoutIfNeeded()
            })
        }
        calendar.reloadData()
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
        for data in scheduleData {
            if data != item {
                data.selected = false
            }
        }
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    @IBAction func addNewAction(sender: AnyObject) {
        navigationController?.pushViewController(ZYSpeechInputViewController.getInstance(), animated: true)
    }
    
    func calendarCurrentMonthDidChange(calendar: FSCalendar!) {
        dateLabel.text = calendar.currentMonth.fs_stringWithFormat("yyyy.MM")
    }
    
    func calendar(calendar: FSCalendar!, hasEventForDate date: NSDate!) -> Bool {
        return true
    }
    
    func calendar(calendar: FSCalendar!, shouldSelectDate date: NSDate!) -> Bool {

        return true
    }
    
    func calendar(calendar: FSCalendar!, didSelectDate date: NSDate!) {

    }
}
