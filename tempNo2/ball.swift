//
//  ball.swift
//  tempNo2
//
//  Created by Tianjiao Mo on 2/10/15.
//  Copyright (c) 2015 Tianjiao Mo. All rights reserved.
//

import Foundation
import SpriteKit

class ball {
    var node : SKSpriteNode
    var name = "ball"
    
    init(){
        self.node = SKSpriteNode(imageNamed: name)
        self.node.xScale = 0.75
        self.node.yScale = 0.75
        var action = SKAction.rotateByAngle(CGFloat(2 * (M_PI)) , duration: 1.0)
        self.node.name = name
        self.node.runAction(SKAction.repeatActionForever(action))
        
        
        
        self.node.physicsBody = SKPhysicsBody(circleOfRadius: self.node.size.width/2.5)
//        self.node.physicsBody?.affectedByGravity = false
//        self.node.physicsBody?.dynamic = false
        self.node.physicsBody?.categoryBitMask = collidetype.obstacle.rawValue
        self.node.physicsBody?.contactTestBitMask = collidetype.hero.rawValue
        self.node.physicsBody?.collisionBitMask = collidetype.bar.rawValue
        
        
        
    }
    
    
    
    func setPosition (location: CGPoint){
        self.node.position = location
    }
    
}