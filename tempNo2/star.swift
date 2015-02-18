//
//  star.swift
//  tempNo2
//
//  Created by Tianjiao Mo on 2/10/15.
//  Copyright (c) 2015 Tianjiao Mo. All rights reserved.
//

import Foundation
import SpriteKit


class star{
    var node : SKSpriteNode
    var name = "star"
    var xScale = CGFloat(0.75)
    var yScale = CGFloat(0.75)
    
    init(){
        self.node = SKSpriteNode(imageNamed: name)
        var action = SKAction.rotateByAngle(CGFloat(2 * (M_PI)) , duration: 1.0)
        self.node.name = name
        self.node.runAction(SKAction.repeatActionForever(action))
        
        self.node.xScale = self.xScale
        self.node.yScale = self.yScale
        
        self.node.physicsBody = SKPhysicsBody(circleOfRadius: self.node.size.width/2.5)
        self.node.physicsBody?.affectedByGravity = false
        self.node.physicsBody?.dynamic = false
        self.node.physicsBody?.categoryBitMask = collidetype.star.rawValue
        self.node.physicsBody?.contactTestBitMask = collidetype.None.rawValue
        self.node.physicsBody?.collisionBitMask = collidetype.None.rawValue
        
        
        
    }
    
    
    
    func setPosition (location: CGPoint){
        self.node.position = location
    }
    
    
    
    
    
}