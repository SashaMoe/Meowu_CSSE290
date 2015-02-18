//
//  SBscene.swift
//  tempNo2
//
//  Created by Tianjiao Mo on 2/15/15.
//  Copyright (c) 2015 Tianjiao Mo. All rights reserved.
//

import Foundation

import SpriteKit
import CoreData


class LevelScene: SKScene, NSFetchedResultsControllerDelegate{
    var managedObjectContext: NSManagedObjectContext?
    let playbutton = SKSpriteNode(imageNamed: "mushroom")
    let entityName = "Level"
    
    
    var fetchedResultsController: NSFetchedResultsController {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest = NSFetchRequest(entityName: entityName)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "level", ascending: false)]
        
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
        aFetchedResultsController.delegate = self
        
        _fetchedResultsController = aFetchedResultsController
        
        
        
        var error: NSError? = nil
        
        
        
        if !_fetchedResultsController!.performFetch(&error) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //println("Unresolved error \(error), \(error.userInfo)")
            abort()
        }
        //
        
        
        return _fetchedResultsController!
    }
    var _fetchedResultsController: NSFetchedResultsController! = nil
    
    
    func saveManagedObjectContext(){
        var error : NSError?
        self.managedObjectContext?.save(&error)
        if(error != nil){
            println("save error?")
            abort()
        }
    }
    
    
    override func didMoveToView(view: SKView) {
        var number1 = NSIndexPath(forRow: 0, inSection: 0)
        var number = self.fetchedResultsController.objectAtIndexPath(number1) as Level
        var number2 = number.level
        
        for i in 1..<16 {
            var temp = SKLabelNode(fontNamed: "Chalkduster")
            if(i <= number2.integerValue){
                temp.text = "Level\(i) *"
            }else{
            temp.text = "Level\(i)"
            }
            temp.name = "\(i)"
            temp.fontSize = 18
            temp.position = CGPointMake(self.size.width/4*CGFloat((i-1)%3+1), self.size.height-self.size.height/20*CGFloat(i+2))
            self.addChild(temp)
        }
//        self.playbutton.position = CGPointMake(self.size.width/2, self.size.height/2)
//        addChild(self.playbutton)
        self.backgroundColor = UIColor(hue: 5.0, saturation: 5.0, brightness: 5.0, alpha: 5.0)
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches{
            let location = touch.locationInNode(self)

            if let node: SKLabelNode? = self.nodeAtPoint(location) as? SKLabelNode{
                var number1 = NSIndexPath(forRow: 0, inSection: 0)
                var number = self.fetchedResultsController.objectAtIndexPath(number1) as Level
                var number2 = number.level
                
                if let i = node?.name?.toInt() {
                    if number2.integerValue >= i {
                    println(node?.name)
                    var scene = GameScene()
                    // Configure the view.
                    
                    let skView = self.view! as SKView
                    
                    skView.showsFPS = true
                    skView.showsNodeCount = true
                    
                    /* Sprite Kit applies additional optimizations to improve rendering performance */
                    skView.ignoresSiblingOrder = true
                    
                    /* Set the scale mode to scale to fit the window */
                    scene.scaleMode = .AspectFill
                    scene.size = skView.bounds.size
                    
                    scene.managedObjectContext = self.managedObjectContext
                    scene.gameLevel = Double(i)
                    skView.presentScene(scene)
                    }
                }
            }
        }
    }
    
    
    

}