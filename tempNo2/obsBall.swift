//
//  obsBall.swift
//  tempNo2
//
//  Created by Tianjiao Mo on 2/10/15.
//  Copyright (c) 2015 Tianjiao Mo. All rights reserved.
//

import Foundation
import SpriteKit

class obsBall{
    var xScale = CGFloat(0.75)
    var yScale = CGFloat(0.75)
    
    var name = "ball2"
    var node : SKSpriteNode
    
    init(){
        self.node = SKSpriteNode(imageNamed: name)
        self.node.xScale = self.xScale
        self.node.yScale = self.yScale
        var action = SKAction.rotateByAngle(CGFloat(2 * (M_PI)) , duration: 1.0)
        
        self.node.runAction(SKAction.repeatActionForever(action))
        
        self.node.name = self.name
        self.node.physicsBody = SKPhysicsBody(circleOfRadius: self.node.size.width/3)
        self.node.physicsBody?.categoryBitMask = collidetype.obstacle.rawValue
        self.node.physicsBody?.contactTestBitMask = collidetype.hero.rawValue
        self.node.physicsBody?.collisionBitMask = collidetype.hero.rawValue
        
//       self.node.runAction(SKAction.moveToX(0, duration: 10))
        self.node.physicsBody?.restitution = 1
    }
    
    func setPosition(location:CGPoint){
        self.node.position = location
    }
    
}