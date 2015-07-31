//
//  ZYMainViewController.swift
//  XGCG
//
//  Created by Sean on 15/4/10.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

import UIKit

class ZYMainViewController: UIViewController {
    @IBOutlet weak var scheduleButton: UIButton!
    @IBOutlet weak var addressBookButton: UIButton!
    @IBOutlet weak var personalButton: UIButton!
    @IBOutlet weak var bottomBarBottom: NSLayoutConstraint!
    @IBOutlet weak var tabbarSeparatorHeightConstraint: NSLayoutConstraint!
    
    var viewControllers: [UIViewController!] = []
    
    var rootNavController: UINavigationController? {
        return self.childViewControllers.first as? UINavigationController
    }
    
    var tabButtons: [UIButton] {
        return [scheduleButton, addressBookButton, personalButton]
    }
    class func getInstance() -> ZYMainViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! ZYMainViewController
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [rootNavController!.viewControllers.first as! ZYScheduleViewController, ZYAddressBookViewController.getInstance(), ZYPersonalViewController.getInstance()]
        UIButton.changeButtonsVertical(5, buttons: tabButtons)
        tabbarSeparatorHeightConstraint.constant = tabbarSeparatorHeightConstraint.constant / UIScreen.mainScreen().scale
        self.hidesBottomBarWhenPushed = true
    }
    
    override func childViewControllerForStatusBarStyle() -> UIViewController? {
        return rootNavController?.viewControllers.first as? UIViewController
    }
    
    @IBAction func tabButtonDidTapped(sender: UIButton) {
        for btn: UIButton in tabButtons {
            btn.selected = false
            btn.userInteractionEnabled = true
        }
        sender.selected = true
        sender.userInteractionEnabled = false
        
        var toRootViewController: UIViewController! = viewControllers.first!
        self.rootNavController!.navigationBarHidden = false
        switch (sender) {
        case scheduleButton:
            toRootViewController = viewControllers[0]
            if rootNavController!.viewControllers.first as? UIViewController != viewControllers.first {
                self.rootNavController!.setViewControllers([viewControllers.first!], animated: false)
            }
        case addressBookButton:
            toRootViewController = viewControllers[1]
        case personalButton:
            toRootViewController = viewControllers[2]
        default:
            println("not suppose to happen")
        }

        if rootNavController!.viewControllers.first as? UIViewController != toRootViewController {
            self.rootNavController!.setViewControllers([toRootViewController!], animated: false)
        }
    }
    
    func hideTabBar() {
        self.bottomBarBottom.constant = -50
        self.view.setNeedsUpdateConstraints()
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    func showTabBar() {
        self.bottomBarBottom.constant = 0
        self.view.setNeedsUpdateConstraints()
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
}
