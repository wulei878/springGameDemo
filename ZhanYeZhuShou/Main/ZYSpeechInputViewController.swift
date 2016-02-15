//
//  ZYSpeechInputViewController.swift
//  ZhanYeZhuShou
//
//  Created by Owen on 15/8/2.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

import UIKit

class ZYSpeechInputViewController: UIViewController {
    @IBOutlet weak var textView: HPGrowingTextView!
    @IBOutlet weak var speechButton: UIButton!

    
    class func getInstance() -> ZYSpeechInputViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ZYSpeechInputViewController") as! ZYSpeechInputViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.placeholder = "请说话..."
        textView.userInteractionEnabled = false
        let longPress = UILongPressGestureRecognizer(target: self, action: "longPressAction:")
        speechButton.addGestureRecognizer(longPress)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func longPressAction(gesture:UILongPressGestureRecognizer) {
        speechButton.selected = !(gesture.state == .Ended)
        if gesture.state == .Ended {
            navigationController?.pushViewController(ZYNewScheduleViewController.getInstance(), animated: true)
        }
    }

    @IBAction func closeAction(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func keyboardInputAction(sender: AnyObject) {
        navigationController?.pushViewController(ZYInputNewScheduleViewController.getInstance(), animated: true)
    }
    
    
}
