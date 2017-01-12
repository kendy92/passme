//
//  GameScene.swift
//  Game5
//
//  Created by Dinh Cong Thang on 2016-12-29.
//  Copyright © 2016 Dinh Cong Thang. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    struct BodyMask {
        static let player:UInt32 = 0x1 << 1
        static let barrier:UInt32 = 0x1 << 2
    }
    
    var player = SKSpriteNode()
    var player2 = SKSpriteNode()
    var initPostion = CGPoint()
    var boxSize = 30
    var scorelbl = SKLabelNode()
    var score = 0{
        didSet{
            scorelbl.text = "\(score)"
        }
    }

    var isDie = false
    
    var restartBtn = SKSpriteNode()
    
    var barriers = SKNode()
    
    
    func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / 0xffffffff)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat{
        return random() * (max - min) + min
    }
    
    
    func addPLayer(){
        initPostion = CGPoint(x: frame.size.width/2, y: frame.size.height/2 - 100)
        player = SKSpriteNode(color: UIColor.white, size: CGSize(width: boxSize, height: boxSize))
        player.position = initPostion
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.categoryBitMask = BodyMask.player
        player.physicsBody?.contactTestBitMask = BodyMask.barrier
        player.physicsBody?.collisionBitMask = BodyMask.barrier
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.isDynamic = true
        self.addChild(player)
        player2 = SKSpriteNode(color: UIColor.red, size: CGSize(width: boxSize, height: boxSize))
        player2.position = initPostion
        player2.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player2.physicsBody?.categoryBitMask = BodyMask.player
        player2.physicsBody?.contactTestBitMask = BodyMask.barrier
        player2.physicsBody?.collisionBitMask = BodyMask.barrier
        player2.physicsBody?.affectedByGravity = false
        player2.physicsBody?.isDynamic = true
        self.addChild(player2)
    }
    
    func addBarriers(){
        barriers = SKNode()
        barriers.name = "barriers"
        let randType = arc4random_uniform(3)
        switch randType {
        case 0:
            typeLarge()
            break
        case 1:
            typeMedium()
            break
        case 2:
            typeSmall()
            break
        default:
            typeLarge()
        }
        self.addChild(barriers)
        
        let moveBarrier = SKAction.moveTo(y: -frame.size.height, duration: TimeInterval(2.0))
        let removeBarrier = SKAction.removeFromParent()
        barriers.run(SKAction.sequence([moveBarrier,removeBarrier]))
        score = score + 1
        
    }
    
    func spawnBarriers(){
        let spawnBarrier = SKAction.run({
            () in self.addBarriers()
        })
        let delaySpawn = SKAction.wait(forDuration: TimeInterval(0.65))
        self.run(SKAction.repeatForever(SKAction.sequence([spawnBarrier,delaySpawn])))
    }
    
    func typeLarge(){
        
        let b1 = SKSpriteNode(color: UIColor.white, size: CGSize(width: frame.size.width/4, height: 15))
        b1.position = CGPoint(x: b1.size.width/2, y: frame.size.height) //place left
        b1.physicsBody = SKPhysicsBody(rectangleOf: b1.size)
        b1.physicsBody?.categoryBitMask = BodyMask.barrier
        b1.physicsBody?.contactTestBitMask = BodyMask.player
        b1.physicsBody?.collisionBitMask = BodyMask.player
        b1.physicsBody?.affectedByGravity = false
        b1.physicsBody?.isDynamic = true
        
        let b2 = SKSpriteNode(color: UIColor.white, size: CGSize(width: 50, height: 15))
        b2.position = CGPoint(x: frame.size.width/2, y: frame.size.height) //center
        b2.physicsBody = SKPhysicsBody(rectangleOf: b2.size)
        b2.physicsBody?.categoryBitMask = BodyMask.barrier
        b2.physicsBody?.contactTestBitMask = BodyMask.player
        b2.physicsBody?.collisionBitMask = BodyMask.player
        b2.physicsBody?.affectedByGravity = false
        b2.physicsBody?.isDynamic = true
        
        let b3 = SKSpriteNode(color: UIColor.white, size: CGSize(width: frame.size.width/4, height: 15))
        b3.position = CGPoint(x: frame.size.width - b3.size.width/2, y: frame.size.height) //right
        b3.physicsBody = SKPhysicsBody(rectangleOf: b3.size)
        b3.physicsBody?.categoryBitMask = BodyMask.barrier
        b3.physicsBody?.contactTestBitMask = BodyMask.player
        b3.physicsBody?.collisionBitMask = BodyMask.player
        b3.physicsBody?.affectedByGravity = false
        b3.physicsBody?.isDynamic = true
        
        barriers.addChild(b1)
        barriers.addChild(b2)
        barriers.addChild(b3)
    }
    
    func typeMedium(){
        
        let b1 = SKSpriteNode(color: UIColor.white, size: CGSize(width: frame.size.width/3, height: 15))
        b1.position = CGPoint(x: b1.size.width/2, y: frame.size.height) //place left
        b1.physicsBody = SKPhysicsBody(rectangleOf: b1.size)
        b1.physicsBody?.categoryBitMask = BodyMask.barrier
        b1.physicsBody?.contactTestBitMask = BodyMask.player
        b1.physicsBody?.collisionBitMask = BodyMask.player
        b1.physicsBody?.affectedByGravity = false
        b1.physicsBody?.isDynamic = true
        
        
        let b3 = SKSpriteNode(color: UIColor.white, size: CGSize(width: frame.size.width/3, height: 15))
        b3.position = CGPoint(x: frame.size.width - b3.size.width/2, y: frame.size.height) //right
        b3.physicsBody = SKPhysicsBody(rectangleOf: b3.size)
        b3.physicsBody?.categoryBitMask = BodyMask.barrier
        b3.physicsBody?.contactTestBitMask = BodyMask.player
        b3.physicsBody?.collisionBitMask = BodyMask.player
        b3.physicsBody?.affectedByGravity = false
        b3.physicsBody?.isDynamic = true
        
        barriers.addChild(b1)
        barriers.addChild(b3)
    }
    
    func typeSmall(){
        let randX = random(min: frame.size.width - 100, max: frame.size.width - 300)
        let b2 = SKSpriteNode(color: UIColor.white, size: CGSize(width: randX, height: 15))
        b2.position = CGPoint(x: frame.size.width/2, y: frame.size.height) //center
        b2.physicsBody = SKPhysicsBody(rectangleOf: b2.size)
        b2.physicsBody?.categoryBitMask = BodyMask.barrier
        b2.physicsBody?.contactTestBitMask = BodyMask.player
        b2.physicsBody?.collisionBitMask = BodyMask.player
        b2.physicsBody?.affectedByGravity = false
        b2.physicsBody?.isDynamic = true

        barriers.addChild(b2)
    }

    
    func initScene(){
        self.physicsWorld.contactDelegate = self
        //add score label
        scorelbl.text = "0"
        scorelbl.fontSize = 50.0
        scorelbl.fontColor = UIColor.white
        scorelbl.position = CGPoint(x: frame.size.width/2, y: frame.size.height - 50)
        scorelbl.zPosition = 5
        self.addChild(scorelbl)
        
        addPLayer()
        spawnBarriers()
    }
    
    override func didMove(to view: SKView) {
        self.run(SKAction.playSoundFileNamed("sound/bg_sound.mp3", waitForCompletion: true))
        initScene()
        
    }
    
    func createBtn(){
        restartBtn = SKSpriteNode(imageNamed: "restart")
        restartBtn.size = CGSize(width: 200, height: 100)
        restartBtn.position = CGPoint(x: frame.width/2, y: frame.height/2)
        restartBtn.zPosition = 6
        restartBtn.setScale(0)
        self.addChild(restartBtn)
        restartBtn.run(SKAction.scale(to: 1.0, duration: 0.3))
        
    }
    
    func resetGame(){
        self.removeAllActions()
        self.removeAllChildren()
        score = 0
        isDie = false
        initScene()
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        if(bodyA.categoryBitMask == BodyMask.player && bodyB.categoryBitMask == BodyMask.barrier ||
            bodyA.categoryBitMask == BodyMask.barrier && bodyB.categoryBitMask == BodyMask.player){
            
            enumerateChildNodes(withName: "barriers", using: ({
                (node,error) in
                node.speed = 0
                self.removeAllActions()
                self.run(SKAction.playSoundFileNamed("sound/break.wav", waitForCompletion: true))
                self.player.physicsBody?.affectedByGravity = true
                self.player2.physicsBody?.affectedByGravity = true
            }))
            if(isDie == false){
                isDie = true
                createBtn()
            }
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            if(isDie == true){
                if(restartBtn.contains(location)){
                    resetGame()
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            player.run(SKAction.moveTo(x: location.x, duration: 0.2))
            player2.run(SKAction.moveTo(x: frame.size.width - location.x, duration: 0.1))
            
        }
    }
    

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if(isDie == false){
            player.run(SKAction.repeatForever(SKAction.rotate(byAngle: 10.0, duration: TimeInterval(2.0))))
            player2.run(SKAction.repeatForever(SKAction.rotate(byAngle: 10.0, duration: TimeInterval(2.0))))
            
        }

    }
}
