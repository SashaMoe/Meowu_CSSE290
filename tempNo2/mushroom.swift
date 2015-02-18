//
//  mushroom.swift
//  tempNo2
//
//  Created by Tianjiao Mo on 2/13/15.
//  Copyright (c) 2015 Tianjiao Mo. All rights reserved.
//

import Foundation
import SpriteKit

class mushroom{
    var node : SKSpriteNode
    var name = "mushroom"
    var speed = CGFloat(5)
    
    init(){
        self.node = SKSpriteNode(imageNamed: name)
        self.node.xScale = 0.4
        self.node.yScale = 0.4
        var action = SKAction.rotateByAngle(CGFloat(2 * (M_PI)) , duration: 1.0)
        self.node.name = name
        self.node.runAction(SKAction.repeatActionForever(action))
        
        
        
        self.node.physicsBody = SKPhysicsBody(circleOfRadius: self.node.size.width/2.5)
        self.node.physicsBody?.affectedByGravity = false
        self.node.physicsBody?.categoryBitMask = collidetype.mushroom.rawValue
        self.node.physicsBody?.contactTestBitMask = collidetype.star.rawValue
        self.node.physicsBody?.collisionBitMask = collidetype.star.rawValue
        
        
        self.fire()
    }
    
    
    
    func setPosition (location: CGPoint){
        self.node.position = location
    }
    
    
    func fire(){
        var action = SKAction.moveBy(CGVectorMake(0.0, 1000), duration: 1)
        self.node.runAction(SKAction.repeatActionForever(action))
        
    }
}