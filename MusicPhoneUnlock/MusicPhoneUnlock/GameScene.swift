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
    var background:SKEmitterNode!
    var i = 0
    var gameTimer:Timer!
    var possibleNotes = ["MusicNote1", "MusicNote2", "MusicNote3", "MusicNote4", "MusicNote5", "MusicNote6", "MusicNote7", "MusicNote8", "MusicNote9", "MusicNote10" ]
    var password = ["MusicNote3", "MusicNote8", "MusicNote1"]
    var previous = "MusicNoteX"
    
    let noteCategory:UInt32 = 0x1 << 1
    
    let motionManger = CMMotionManager()
    var xAcceleration:CGFloat = 0
    
    override func didMove(to view: SKView) {
        background = SKEmitterNode(fileNamed: "Background")
        background.position = CGPoint(x: 0, y: 1472)
        background.advanceSimulationTime(10)
        self.addChild(background)
        
        background.zPosition = -1
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(addNote), userInfo: nil, repeats:true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            if touch == touches.first {
                enumerateChildNodes(withName: "//*", using: { (note, stop) in
                    if (self.i < self.password.count && note.name == self.password[self.i]) {
                        if note.contains(touch.location(in: self)){
                            print("Note " + String(self.i))
                            self.previous = self.password[self.i]
                            self.i = self.i+1;
                            
                            if (self.i == self.password.count){
                                print("UNLOCK MY PHONE")
                                
                                let scene = SuccessScene(fileNamed: "SuccessScene")!
                                let transition = SKTransition.moveIn(with: .right, duration: 1)
                                self.view?.presentScene(scene, transition: transition)
                            }
                        }
                    }
                    else if note.name == self.possibleNotes[0] || note.name == self.possibleNotes[1] || note.name == self.possibleNotes[2] || note.name == self.possibleNotes[3] || note.name == self.possibleNotes[4] || note.name == self.possibleNotes[5] || note.name == self.possibleNotes[6] || note.name == self.possibleNotes[7] || note.name == self.possibleNotes[8] || note.name == self.possibleNotes[9]  {
                        if note.contains(touch.location(in: self)){
                            print("Its one of the notes")
                            if (note.name != self.previous) {
                                print("Wrong pick")
                                self.i = 0
                            }
                        }
                    }
                    else {
                        print("Screen was clicked")
                    }
                    
                })
            }
            else {
                break
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    @objc func addNote(){
        possibleNotes = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: possibleNotes) as! [String]
        
        let note = SKSpriteNode(imageNamed: possibleNotes[0])
        let randomNotePosition = GKRandomDistribution(lowestValue: -300, highestValue: 300)
        let position = CGFloat(randomNotePosition.nextInt())
        
        note.name = possibleNotes[0]
        
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
    
    @objc func clickNote(){
        print("Print note")
    }
}
