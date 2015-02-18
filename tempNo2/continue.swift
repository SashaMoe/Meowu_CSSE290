//
//  continue.swift
//  tempNo2
//
//  Created by Tianjiao Mo on 2/15/15.
//  Copyright (c) 2015 Tianjiao Mo. All rights reserved.
//



import Foundation
import SpriteKit

class continueButton{
    var node : SKSpriteNode
    var name = "continue"
    
    
    init(){
        self.node = SKSpriteNode(imageNamed: name)
        self.node.xScale = 0.2
        self.node.yScale = 0.2
        self.node.name = name
    }
    
    
    
    func setPosition (location: CGPoint){
        self.node.position = location
    }

    }