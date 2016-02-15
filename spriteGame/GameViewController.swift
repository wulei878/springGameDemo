//
//  GameViewController.swift
//  spriteGame
//
//  Created by 吴磊 on 14-10-14.
//  Copyright (c) 2014年 Renren. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: nil)
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData!)

            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {
    var backgroundMusicPlayer:AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        let skView = self.view as SKView
        if !(skView.scene != nil)
        {
            // Configure the view.
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            let scene = GameScene(size: skView.bounds.size) as SKScene
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        var error:NSError?
        let backgroundMusicURL = NSBundle.mainBundle().URLForResource("background-music-aac", withExtension: "caf")
        self.backgroundMusicPlayer = AVAudioPlayer(contentsOfURL: backgroundMusicURL, error: &error)
        self.backgroundMusicPlayer?.numberOfLoops = -1
        self.backgroundMusicPlayer?.prepareToPlay()
        self.backgroundMusicPlayer?.play()
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
