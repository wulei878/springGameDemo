//
//  GameScene.swift
//  spriteGame
//
//  Created by 吴磊 on 14-10-14.
//  Copyright (c) 2014年 Renren. All rights reserved.
//

import SpriteKit

enum Vector {
    static func rwAdd(a:CGPoint, b:CGPoint) -> CGPoint {
        return CGPointMake(a.x + b.x, a.y + b.y)
    }

    static func rwSub(a:CGPoint , b:CGPoint) -> CGPoint {
        return CGPointMake(a.x - b.x, a.y - b.y)
    }

    static func rwMult(a:CGPoint , b:CGFloat) -> CGPoint {
        return CGPointMake(a.x * b, a.y * b)
    }

    static func rwLength(a:CGPoint) -> CGFloat {
        return CGFloat(sqrtf(Float(a.x * a.x + a.y * a.y)))
    }

    // Makes a vector have a length of 1
    static func rwNormalize(a:CGPoint) -> CGPoint {
        let length = rwLength(a);
        return CGPointMake(a.x / length, a.y / length);
    }

    static let projectileCategory:uint_fast32_t = 0x1 << 0
    static let monsterCategory:uint_fast32_t = 0x1 << 1
}

class GameScene: SKScene,SKPhysicsContactDelegate {
    var player : SKSpriteNode?
    var lastSpawnTimeInterval : NSTimeInterval?
    var lastUpdateTimeInterval : NSTimeInterval?
    var monstersDestroyed:Int?

    override init(size: CGSize) {
        self.lastSpawnTimeInterval = 0
        self.lastUpdateTimeInterval = 0
        self.monstersDestroyed = 0
        super.init(size: size)
        self.backgroundColor = SKColor.whiteColor()
        self.player = SKSpriteNode(imageNamed: "jugg")
        self.player?.position = CGPointMake(self.player!.size.width/2, self.frame.size.height/2);
        self.physicsWorld.gravity = CGVectorMake(0, 1000)
        self.physicsWorld.contactDelegate = self;
        self.addChild(self.player!)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addMonster() {
        let monster = SKSpriteNode(imageNamed: "monster")
        let minY = monster.size.height / 2
        let maxY = self.frame.size.height - monster.size.height / 2
        let rangeY = maxY - minY
        let actualY = (CGFloat(arc4random()) % rangeY) + minY
        monster.position = CGPointMake(self.frame.size.width + monster.size.width / 2, actualY)
        self.addChild(monster)
        let minDuration = 2.0
        let maxDuration = 4.0
        let rangeDuration = maxDuration - minDuration
        let actualDuration = (Double(arc4random()) % rangeDuration) + minDuration

        let actionMove = SKAction.moveTo(CGPointMake(-monster.size.width / 2, actualY), duration: actualDuration)
        let actionMoveDone = SKAction.removeFromParent()
        monster.physicsBody = SKPhysicsBody(rectangleOfSize: monster.size)
        monster.physicsBody?.dynamic = true
        monster.physicsBody?.categoryBitMask = Vector.monsterCategory
        monster.physicsBody?.contactTestBitMask = Vector.projectileCategory
        monster.physicsBody?.collisionBitMask = 0
        monster.physicsBody?.affectedByGravity = false
        let loseAction = SKAction .runBlock { () -> Void in
            let reveal = SKTransition.flipHorizontalWithDuration(0.5)
            let gameOverScene = GameOverScene(size: self.size, won: false)
            self.view?.presentScene(gameOverScene, transition: reveal)
        }
        monster .runAction(SKAction.sequence([actionMove,actionMoveDone]))

    }

    func updateWithTimeSinceLastUpdate(timeSinceLast:CFTimeInterval) {
        self.lastSpawnTimeInterval? += timeSinceLast
        if self.lastSpawnTimeInterval > 1 {
            self.lastSpawnTimeInterval = 0
            self.addMonster()
        }
    }

    override func update(currentTime: NSTimeInterval) {
        var timeSinceLast = currentTime - self.lastUpdateTimeInterval!
        self.lastUpdateTimeInterval = currentTime
        if timeSinceLast > 1 {
            timeSinceLast = 1.0 / 60.0
            self.lastUpdateTimeInterval = currentTime
        }

        self.updateWithTimeSinceLastUpdate(timeSinceLast)

    }

    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        self.runAction(SKAction.playSoundFileNamed("pew-pew-lei.caf", waitForCompletion: false))
        var touch = touches.anyObject() as UITouch
        let location = touch.locationInNode(self)
        var projectile = SKSpriteNode(imageNamed: "projectile")
        projectile.position = self.player!.position
        var offset = Vector.rwSub(location, b: projectile.position)
        if offset.x <= 0 {
            return;
        }
        self.addChild(projectile)
        let direction = Vector.rwNormalize(offset)
        let shootAmount = Vector.rwMult(direction, b: 1000)
        let realDest = Vector.rwAdd(shootAmount, b: projectile.position)
        let velocity = 480.0 / 1.0
        let realMoveDuration = (Double(self.size.width)) / velocity
        var actionMove = SKAction.moveTo(realDest, duration: 4)
        var actionMoveDone = SKAction.removeFromParent()
        projectile.physicsBody = SKPhysicsBody(circleOfRadius: projectile.size.width / 2)
        projectile.physicsBody?.dynamic = false
        projectile.physicsBody?.categoryBitMask = Vector.projectileCategory
        projectile.physicsBody?.contactTestBitMask = Vector.monsterCategory
        projectile.physicsBody?.collisionBitMask = 0
        projectile.physicsBody?.usesPreciseCollisionDetection = true
        projectile.runAction(SKAction.sequence([actionMove,actionMoveDone]))
    }

    func projectileDidCollideWithMonster(projectile:SKSpriteNode,monster:SKSpriteNode) {
        NSLog("Hit")
        projectile.removeFromParent()
        monster.removeFromParent()
        self.monstersDestroyed?++
        if self.monstersDestroyed > 30 {
            let reveal = SKTransition.flipHorizontalWithDuration(0.5)
            let gameOverScene = GameOverScene(size: self.size, won: true)
            self.view?.presentScene(gameOverScene, transition: reveal)
        }
    }

    func didBeginContact(contact:SKPhysicsContact) {
        var firstBody:SKPhysicsBody,secondBody:SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }

        if firstBody.categoryBitMask & Vector.projectileCategory != 0 && secondBody.categoryBitMask & Vector.monsterCategory != 0 {
            self.projectileDidCollideWithMonster(firstBody.node as SKSpriteNode, monster: secondBody.node as SKSpriteNode)
        }
    }
}

class GameOverScene: SKScene {
    init(size: CGSize, won:Bool) {
        super.init(size: size)
        self.backgroundColor = SKColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        var message:NSString
        if won {
            message = "You Won!"
        } else {
            message = "You Lose :["
        }
        var label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = message
        label.fontSize = 40
        label.fontColor = SKColor.blackColor()
        label.position = CGPointMake(self.size.width / 2, self.size.height / 2)
        self.addChild(label)
        self.runAction(SKAction.sequence([SKAction.waitForDuration(3.0),SKAction.runBlock({ () -> Void in
            let reveal = SKTransition.flipHorizontalWithDuration(0.5)
            let myScene = GameScene(size: self.size)
            self.view?.presentScene(myScene, transition: reveal)
        })]))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
