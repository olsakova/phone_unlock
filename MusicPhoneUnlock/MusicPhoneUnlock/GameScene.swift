//
//  GameScene.swift
//  MusicPhoneUnlock
//
//  Created by Zach Albers on 2/16/19.
//  Copyright © 2019 HCI581. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var gameTimer:Timer!
    var possibleNotes = ["MusicNote1", "MusicNote2", "MusicNote3", "MusicNote4", "MusicNote5", "MusicNote6", "MusicNote7", "MusicNote8", "MusicNote9", "MusicNote10" ]
    
    let noteCategory:UInt32 = 0x1 << 1
    
    let motionManger = CMMotionManager()
    var xAcceleration:CGFloat = 0
    
    override func didMove(to view: SKView) {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(addNote), userInfo: nil, repeats:true)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    @objc func addNote(){
        possibleNotes = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: possibleNotes) as! [String]
        
        let note = SKSpriteNode(imageNamed: possibleNotes[0])
        let randomNotePosition = GKRandomDistribution(lowestValue: -300, highestValue: 300)
        let position = CGFloat(randomNotePosition.nextInt())
        
        note.position = CGPoint(x: position, y: self.frame.size.height + note.size.height)
        
        note.physicsBody = SKPhysicsBody(rectangleOf: note.size)
        note.physicsBody?.isDynamic = true
        
        note.physicsBody?.categoryBitMask = noteCategory
        note.physicsBody?.collisionBitMask = 0
        
        self.addChild(note)
        let animationDuration:TimeInterval = 6
        var actionArray = [SKAction]()
        
        //actionArray.append(SKAction.move(to: CGPoint(x: position, y: -note.size.height), duration: animationDuration))
        actionArray.append(SKAction.move(to: CGPoint(x: position, y: -500), duration: animationDuration))
        actionArray.append(SKAction.removeFromParent())
        
        note.run(SKAction.sequence(actionArray))
    }
}
