//
//  bar.swift
//  tempNo2
//
//  Created by Tianjiao Mo on 2/10/15.
//  Copyright (c) 2015 Tianjiao Mo. All rights reserved.
//

import Foundation
import SpriteKit

class bar{
    
    var name = "bar"
    var node : SKSpriteNode
    
    init(){
        self.node = SKSpriteNode(imageNamed: name)
        self.node.xScale = 0.15
        self.node.yScale = 0.2
        
        self.node.name = self.name
        
        self.node.physicsBody = SKPhysicsBody(rectangleOfSize: self.node.size)
        self.node.physicsBody?.categoryBitMask = collidetype.bar.rawValue
        self.node.physicsBody?.collisionBitMask = collidetype.bar.rawValue
        self.node.physicsBody?.contactTestBitMask = collidetype.hero.rawValue
        self.node.physicsBody?.dynamic = false
        self.node.physicsBody?.restitution = 1
        
        self.node.runAction(SKAction.moveToY(-10, duration: 8))
        self.node.removeFromParent()
        
    }
   
    
    func setPosition (location: CGPoint){
        self.node.position = location
    }
    
    
    
}