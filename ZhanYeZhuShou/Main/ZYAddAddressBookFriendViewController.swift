//
//  ZYAddAddressBookFriendViewController.swift
//  ZhanYeZhuShou
//
//  Created by Owen on 15/8/4.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

import UIKit
import AddressBook
import AddressBookUI

class ZYAddAddressBookFriendViewController: UIViewController,ABPeoplePickerNavigationControllerDelegate {
    var emptyDictionary: CFDictionaryRef?
    var addressBook: ABAddressBookRef?
    
    class func getInstance() -> ZYAddAddressBookFriendViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ZYAddAddressBookFriendViewController") as! ZYAddAddressBookFriendViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func openAddressBook(sender: AnyObject) {
        if ZYAddressBookHelper.sharedInstance().canAccessAdressBook() {
//            let viewController = ZYSelecteFriendsViewController.getInstance()
//            viewController.friends = ZYAddressBookHelper.sharedInstance().startReadAdressBook() as! [ZYMContactor]
            let peoplePicker = ABPeoplePickerNavigationController()
            peoplePicker.peoplePickerDelegate = self
            presentViewController(peoplePicker, animated: true, completion: { () -> Void in
                UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: false)
            })
        } else {
            navigationController?.pushViewController(ZYOpenAddressGuideViewController.getInstance(), animated: true)
        }
    }

    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController!, didSelectPerson person: ABRecord!) {
        let vc = ZYNewFriendViewController.getInstance()
        vc.newFriend = ZYMContactor(ABRecord: person)
        navigationController?.pushViewController(vc, animated: true)
    }
}
