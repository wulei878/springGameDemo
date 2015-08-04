//
//  ZYOpenAddressGuideViewController.swift
//  ZhanYeZhuShou
//
//  Created by Owen on 15/8/4.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

import UIKit

class ZYOpenAddressGuideViewController: UIViewController {

    class func getInstance() -> ZYOpenAddressGuideViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ZYOpenAddressGuideViewController") as! ZYOpenAddressGuideViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
