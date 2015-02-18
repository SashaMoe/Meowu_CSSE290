//
//  hero.swift
//  tempNo2
//
//  Created by Tianjiao Mo on 2/10/15.
//  Copyright (c) 2015 Tianjiao Mo. All rights reserved.
//

import Foundation
import SpriteKit




class ball1 {
    
    var node : SKSpriteNode
    var name = "hero"
    var xScale = CGFloat(0.75)
    var yScale = CGFloat(0.75)
    
    
    var emitCount = 0
    var maxEmitCount = 50
    var particles = SKEmitterNode(fileNamed: "MyParticle.sks")
    var dead = false
    
    init(){
        self.particles.hidden = true
        self.node = SKSpriteNode(imageNamed: "ball1")
        var action = SKAction.rotateByAngle(CGFloat(2 * (M_PI)) , duration: 1.0)
        self.node.name = name
        self.node.runAction(SKAction.repeatActionForever(action))
        
        self.node.xScale = self.xScale
        self.node.yScale = self.yScale
        
        self.node.physicsBody = SKPhysicsBody(circleOfRadius: self.node.size.width/2.5)
        self.node.physicsBody?.affectedByGravity = false
        self.node.physicsBody?.dynamic = true
        self.node.physicsBody?.categoryBitMask = collidetype.hero.rawValue
        self.node.physicsBody?.contactTestBitMask = collidetype.bar.rawValue
        self.node.physicsBody?.collisionBitMask = collidetype.bar.rawValue
        
         self.particles.position = self.node.position
    }
    
    
    func emit(){
        self.particles.position = self.node.position
        self.particles.hidden = false
        self.dead = true
    }
    
    func setPosition(location: CGPoint){
        self.node.position = location
    }
    
    
    
    
    
}