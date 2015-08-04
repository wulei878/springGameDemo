//
//  ZYSelecteFriendsViewController.swift
//  ZhanYeZhuShou
//
//  Created by Owen on 15/8/4.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

import UIKit

class ZYSelecteFriendsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var friends:[ZYMContactor]!

    class func getInstance() -> ZYSelecteFriendsViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ZYSelecteFriendsViewController") as! ZYSelecteFriendsViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "addressBook")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("addressBook", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = friends[indexPath.row].firstName
        cell.detailTextLabel?.text = friends[indexPath.row].phoneNumbers[0] as? String
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        navigationController?.pushViewController(ZYNewFriendViewController.getInstance(), animated: true)
    }

}
