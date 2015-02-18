//
//  GameScene.swift
//  tempNo2
//
//  Created by Tianjiao Mo on 2/10/15.
//  Copyright (c) 2015 Tianjiao Mo. All rights reserved.
//

import SpriteKit
import CoreData

class GameScene: SKScene , SKPhysicsContactDelegate, NSFetchedResultsControllerDelegate{
    
    var managedObjectContext: NSManagedObjectContext?
    var entityName = "Level"
    var gameLevel : Double?

    
    var isGameRunning = true
    var bars = [bar]()
    var obsBalls = [obsBall]()
    var ball3s = [ball]()
    
    
    var leftBar = true
    var barCount = 20
    
    
    var hero : ball1!
    
    var _star : star!
    
    var ballCount = 20.0
    var increment = 0.0
    
    
    var passedCount = 0
    
    var selectedNodes = [UITouch : SKSpriteNode] ()

    var gameMode = 0
    
    var heroTapCount = 0
    
    var starTapCount = 0
    
    var doubleTapIntervalTime = 0
    
    var timeRest = 30
    var timeCount = 0
    var time : SKLabelNode?
    
    
    
    
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
    
    func isLevelEmpty() -> Bool{
        return self.fetchedResultsController.sections![0].numberOfObjects == 0
    }
    
    
    
    override func didMoveToView(view: SKView) {
        addBG()
        self.addlabel()
        addHero()
        addBackButton()
        addPauseButton()
        self.increment = cbrt(self.gameLevel!)
        self.addStar()
        println(self.fetchedResultsController.sections![0].numberOfObjects)
        
        
        if(self.gameLevel>10){
            self.gameMode = 1
        }
        if(self.gameLevel>15){
            self.gameMode = 2
        }
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -self.increment)
        self.physicsWorld.contactDelegate = self
        
        

    }
   
    

    
    
 
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
//        self.nextLevel()
        if !self.paused && self.isGameRunning{
        if(ballCount >= 100){
            var rand = arc4random_uniform(2)
            if rand == 0{
                self.addObsBall()
            }
            else {
                self.addBall3()
            }
            ballCount = 0
        }
        ballCount += self.increment
        
        if(self.barCount >= 100){
            self.addBar()
                barCount = 0
            }
            barCount += 1
        
        for ball in self.obsBalls{
            if(ball.node.position.y <= ball.node.size.height/4*3){
                ball.node.removeFromParent()
                
            }
        }
        
        self.timeCount++
        if(self.timeCount >= 60){
            self.timeRest--
            self.timeCount = 0
            if self.timeRest == 0{
                self.nextLevel()
            }
        }
        self.updateLabel()
        
        self.applyForce()
            
            
        self.doubleTapIntervalTime--
            if self.doubleTapIntervalTime<0{
                self.heroTapCount = 0
                self.starTapCount = 0
            }
            if self.hero.dead == true{
                self.isGameRunning = false
            }
        }
        
        if(!isGameRunning){
            hero.emitCount++
            if(hero.emitCount >= hero.maxEmitCount){
                self.resetGame()
            }
        }

    }
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        if self.isGameRunning{
        let firstNode = contact.bodyA.node
        let secondNode = contact.bodyB.node
        
        if firstNode?.name == "hero" {
            self.hero.emit()
            self.hero.node.removeFromParent()
        }
        
        if secondNode?.name == "hero" {
            self.hero.emit()
            self.hero.node.removeFromParent()
            }
        }
    }

    
    func resetGame(){
        
        
        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            // Configure the view.
            self.removeAllChildren()
            let skView = self.view! as SKView
            
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            scene.size = skView.bounds.size
            scene.gameLevel = self.gameLevel
            scene.managedObjectContext = self.managedObjectContext
            
            skView.presentScene(scene)
        }

    }
    
    
    func nextLevel(){
        self.gameLevel! += 1.0
        var level1 = self.fetchedResultsController.objectAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as Level
        if Double(level1.level) < self.gameLevel!{
            
        
            level1.level = self.gameLevel!
        }
        
        
        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            // Configure the view.
            self.removeAllChildren()
            let skView = self.view! as SKView
            
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            scene.size = skView.bounds.size
            scene.managedObjectContext = self.managedObjectContext
            scene.gameLevel = self.gameLevel

            
            skView.presentScene(scene)
        }
    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
//        self.nextLevel()
        
        
        for touch: AnyObject in touches {
        if !self.paused{
            let location = touch.locationInNode(self)
            
            
            if let node: SKSpriteNode? = self.nodeAtPoint(location) as? SKSpriteNode{
                if(node?.name == "hero" ){
                    if(self.gameMode < 2){
                    self.selectedNodes[touch as UITouch] = node
                    }
                    self.heroTapCount++
                    self.doubleTapIntervalTime = 10
                    if(self.heroTapCount >= 2 && self.gameMode >= 1){
                        self.heroTapCount = 0
                        var post = self.hero.node.position
                        self.hero.node.position = self._star.node.position
                        self._star.node.position = post
                    }
                }
                else if(node?.name == "star"){
                    self.selectedNodes[touch as UITouch] = node

                    self.starTapCount++
                    self.doubleTapIntervalTime = 10
                    if(self.starTapCount >= 2 && self.gameMode >= 1){
                        self.starTapCount = 0
                        var post = self.hero.node.position
                        self.hero.node.position = self._star.node.position
                        self._star.node.position = post
                    }
 
                }
                else if(node?.name == "pause"){
                    self.paused = true
                    node?.removeFromParent()
                    self.addcontinueButton()
                }
                else if(node?.name == "back"){
                    self.backToGameView()
                }
                
            }
            
        }
        else{
            let location = touch.locationInNode(self)
            if let node: SKSpriteNode? = self.nodeAtPoint(location) as? SKSpriteNode{
                if(node?.name == "continue"){
                    self.paused = false
                    node?.removeFromParent()
                    self.addPauseButton()
                }
            }
        }
        
        }
    }
    
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches{
            let location = touch.locationInNode(self)
            
        
            if let node: SKSpriteNode? = selectedNodes[touch as UITouch]{
                if(node?.name == "hero"){
                node?.position.x = min(location.x, self.size.width - self.hero.node.size.width/2)
                node?.position.x = max(node!.position.x, self.hero.node.size.width/2)
                
                
                node?.position.y = sqrt( pow(self.size.width/2,2)-pow( abs(node!.position.x -  self.size.width/2) ,2))
                }
                else{
                    node?.position = location
                    
                }
            }
            
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches{
            if let exist: AnyObject? = selectedNodes[touch as UITouch]{
                selectedNodes[touch as UITouch] = nil
            }
        }
    }
    
    
    
   
    func addlabel(){
        var label = SKLabelNode(text: "LeveL\( UInt32(self.gameLevel!))")
        
        label.position = CGPointMake(self.size.width/2-50, self.size.height-28)
        label.setScale(CGFloat(0.75))
        self.addChild(label)
        
        var timeLabel = SKLabelNode(text:"\(timeRest)'s left")
        timeLabel.position = CGPointMake(self.size.width/2+50, self.size.height-28)
        timeLabel.setScale(CGFloat(0.75))
        self.addChild(timeLabel)
        self.time = timeLabel
    }
    
    
    
    
    
    func backToGameView(){
        if let scene = LevelScene.archiveFromFile("GameScene") as? LevelScene {
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
            
            
            skView.presentScene(scene)
        }
    }
    
    
    func addBG(){
        var node = SKSpriteNode(imageNamed: "background")
        node.size = self.size
        node.position = CGPointMake(self.size.width/2, self.size.height/2)
        self.addChild(node)
    }
    
    
    
    func addHero(){
        self.hero = ball1()
        self.hero.setPosition(CGPointMake(self.size.width/2, self.size.width/2))
        
        self.addChild(self.hero.particles)
        self.addChild(self.hero.node)
    }
    
    
    func addBar(){
        var temp = bar()
        if(self.leftBar){
            temp.setPosition(CGPointMake(temp.node.size.width/2, self.size.height-temp.node.size.height/2))}
        else{
        temp.setPosition(CGPointMake(self.size.width-temp.node.size.width/2, self.size.height-temp.node.size.height/2))
        }
        self.leftBar = !self.leftBar
        
        self.bars.append(temp)
        self.addChild(temp.node)
        
    }
    
    
    func addObsBall(){
        var temp = obsBall()
        temp.setPosition(CGPointMake(randX(temp.node), self.size.height))
        self.obsBalls.append(temp)
        self.addChild(temp.node)
    }
    
    func addBall3(){
        var temp = ball()
        temp.setPosition(CGPointMake(randX(temp.node), self.size.height))
        self.ball3s.append(temp)
        self.addChild(temp.node)
    }
 
    
    
    func addStar(){
        var temp = star()
        temp.setPosition(CGPointMake(self.size.width/4, self.size.height/6))
        self._star = temp
        self.addChild(temp.node)
        
    }
    
    
    func addBackButton(){
        var temp = backButton()
        temp.setPosition(CGPointMake(temp.node.size.width/2, self.size.height-temp.node.size.height/2))
        self.addChild(temp.node)
    }
    
    func addcontinueButton(){
        var temp = continueButton()
        temp.setPosition(CGPointMake(self.size.width-temp.node.size.width/2, self.size.height-temp.node.size.height/2))
        self.addChild(temp.node)
    }
    
    func addPauseButton(){
        var temp = pauseButton()
        temp.setPosition(CGPointMake(self.size.width-temp.node.size.width/2, self.size.height-temp.node.size.height/2))
        self.addChild(temp.node)
    }
    
    
    func randX(node:SKSpriteNode) -> CGFloat{
        var number = CGFloat(arc4random_uniform(UInt32(self.size.width-node.size.width)))
        number += node.size.width/2
        
        return number
    }
    
    
    func addForce(node:SKSpriteNode){
//        var distance = abs(self._star.node.position.x - node.position.x)/self.size.width
        var force = CGVector(dx: 25, dy: 0)
        
        if(node.position.x > self._star.node.position.x){
            force = CGVector(dx: force.dx * -1, dy: force.dy * -1)
        }
        
        if(node.name == "ball"){
            force = CGVector(dx: force.dx * -0.2, dy: force.dy * -0.2)
        }
        node.physicsBody?.applyForce(force)
        
    }
    
    
    func updateLabel(){
        self.time?.text = "\(self.timeRest)'s left"
    }
    
    func applyForce(){
        for ball in obsBalls{
            self.addForce(ball.node)
        }
        
        for ball in ball3s{
            self.addForce(ball.node)
        }
    }
    
    
    func fire(){
        var mush = mushroom()
        mush.setPosition(self.hero.node.position)
        self.addChild(mush.node)
    }
    
    
}
