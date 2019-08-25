//
//  GameScene.swift
//  Fidget
//
//  Created by StarPlayr on 5/3/17.
//  Copyright © 2017 Todd Bruss. All rights reserved.
//

import SpriteKit


var fidget = SKSpriteNode()
let imagearray = ["logo2","logo2","beachspin","iFidget","complexPrimary","colorYingYang","circular","whipper","viralspiral","starro","nicemac","candy2","fed","fed"]
let spinarray = ["g100","g100","g75","g50","g25","g0","g0"]
let forcearray = ["12","12","25","50","75","100","100"]
var counter = 0
var checkpoint1 = false
var checkpoint2 = false
var checkpoint3 = false
var checkpoint4 = false
var checkpoint5 = false
var checkpoint6 = false
var currentSprite = "logo2"
var rot = false
var demo = false
var demoCounter = 0

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var globalDistance = CGFloat(0.0)
    var mySensitiveArea = CGRect()
    var gestureView = UIView()
    var maxforce = 4
    var minforce = 1
    var maxspin = 4
    var minspin = 1
    var maxfgt = 13
    var minfgt = 1
    var cforce = 3
    var cspin = 3
    var cfgt = 1
    var force = 36
    var spinLabel = SKLabelNode()
    var resetLabel = SKLabelNode()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches as Set<UITouch>, with: event)
        for touch: AnyObject in touches {
            let location: CGPoint = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            if let name = touchedNode.name {
                if name == "fgt-right" {
                    let fadeIn = SKAction.fadeAlpha(to: 0.8, duration:TimeInterval(0.15))
                    let myDecay = SKAction.wait(forDuration: 0.15)
                    let fadeOut = SKAction.fadeAlpha(to: 1.0, duration:TimeInterval(0.15))
                    touchedNode.run(SKAction.sequence([fadeIn,myDecay,fadeOut]))
                    
                    if cfgt <= maxfgt {
                        cfgt = cfgt + 1
                    }
                    
                    if cfgt <= maxfgt  {
                        currentSprite = imagearray[ cfgt ]
                        
                        let texture = SKTexture(imageNamed: currentSprite )
                        let action =  SKAction.setTexture(texture)
                        fidget.run(action)
                    } else {
                        cfgt = minfgt
                        currentSprite =  imagearray[ cfgt ]
                        
                        let texture = SKTexture(imageNamed: currentSprite )
                        let action =  SKAction.setTexture(texture)
                        fidget.run(action)
                    }
                }
                
                if name == "fgt-left" {
                    let fadeIn = SKAction.fadeAlpha(to: 0.5, duration:TimeInterval(0.15))
                    let myDecay = SKAction.wait(forDuration: 0.15)
                    let fadeOut = SKAction.fadeAlpha(to: 0.75, duration:TimeInterval(0.15))
                    touchedNode.run(SKAction.sequence([fadeIn,myDecay,fadeOut]))
                    
                    if  cfgt >= minfgt {
                        cfgt = cfgt - 1
                    }
                    
                    if cfgt >= minfgt  {
                        currentSprite = imagearray[ cfgt ]
                        
                        let texture = SKTexture(imageNamed: currentSprite )
                        let action =  SKAction.setTexture(texture)
                        fidget.run(action)
                    } else {
                        cfgt = maxfgt
                        currentSprite = imagearray[ cfgt ]
                        
                        let texture = SKTexture(imageNamed: currentSprite )
                        let action = SKAction.setTexture(texture)
                        fidget.run(action)
                    }
                }
                
                if name == "rot-left" {
                    
                    let fadeIn = SKAction.fadeAlpha(to: 0.3, duration:TimeInterval(0.15))
                    let myDecay = SKAction.wait(forDuration: 0.15)
                    let fadeOut = SKAction.fadeAlpha(to: 0.6, duration:TimeInterval(0.15))
                    touchedNode.run(SKAction.sequence([fadeIn,myDecay,fadeOut]))
                    
                    let velocity = CGFloat(fidget.physicsBody?.angularVelocity ?? 0.0)
                    if velocity < CGFloat(force) {
                        fidget.physicsBody?.angularVelocity = 1 * .pi + (velocity)
                    }
                }
                
                if name == "rot-right" {
                    
                    let fadeIn = SKAction.fadeAlpha(to: 0.3, duration:TimeInterval(0.15))
                    let myDecay = SKAction.wait(forDuration: 0.15)
                    let fadeOut = SKAction.fadeAlpha(to: 0.6, duration:TimeInterval(0.15))
                    touchedNode.run(SKAction.sequence([fadeIn,myDecay,fadeOut]))
                    
                    let velocity = CGFloat(fidget.physicsBody?.angularVelocity ?? 0.0)
                    if CGFloat(-force) < velocity {
                        fidget.physicsBody?.angularVelocity = -1 * .pi + (velocity)
                    }

                }
                
                if name == "spin" {
                    let fadeIn = SKAction.fadeAlpha(to: 0.8, duration:TimeInterval(0.15))
                    let myDecay = SKAction.wait(forDuration: 0.15)
                    let fadeOut = SKAction.fadeAlpha(to: 1.0, duration:TimeInterval(0.15))
                    touchedNode.run(SKAction.sequence([fadeIn,myDecay,fadeOut]))
                    
                    if cspin <= maxspin {
                        cspin = cspin + 1
                    } else {
                        cspin = 1
                    }
                    
                    if cspin <= cspin  {
                        currentSprite = spinarray[ cspin ]
                        
                        let texture = SKTexture(imageNamed: currentSprite )
                        let action =  SKAction.setTexture(texture)
                        touchedNode.run(action)
                    } else {
                        cspin = minspin
                        currentSprite = spinarray[ cspin ]
                        
                        let texture = SKTexture(imageNamed: currentSprite )
                        let action =  SKAction.setTexture(texture)
                        touchedNode.run(action)
                    }
                    
                    if cspin == 1 {
                        fidget.physicsBody?.angularDamping = 0.3
                    } else if cspin == 2 {
                        fidget.physicsBody?.angularDamping = 0.2
                    } else if cspin == 3  {
                        fidget.physicsBody?.angularDamping = 0.1
                    } else if cspin == 4  {
                    fidget.physicsBody?.angularDamping = 0.005
                    } else if cspin == 5  {
                    fidget.physicsBody?.angularDamping = 0.00
                    }
                }
                
                
                
                if name == "demo" && demo == false {
                    
                    let fadeIn = SKAction.fadeAlpha(to: 0.8, duration:TimeInterval(0.15))
                    let myDecay = SKAction.wait(forDuration: 0.15)
                    let fadeOut = SKAction.fadeAlpha(to: 1.0, duration:TimeInterval(0.15))
                    touchedNode.run(SKAction.sequence([fadeIn,myDecay,fadeOut]))
                    
                    let texture = SKTexture(imageNamed: "thumb" )
                    let thumb =  SKAction.setTexture(texture)
                    let texture2 = SKTexture(imageNamed: "index" )
                    let index =  SKAction.setTexture(texture2)
                    let turn = SKAction.rotate(byAngle: 2, duration: 1)
                    let turn3 = SKAction.rotate(byAngle: 2, duration: 0.25)
                    //let turn4 = SKAction.rotate(byAngle: 1.1, duration: 0.5)
                    let turn2 = SKAction.rotate(byAngle: -2, duration: 1)
                    let wait = SKAction.wait(forDuration: 1.4)
                    let wait2 = SKAction.wait(forDuration: 2.5)
                    let wait3 = SKAction.wait(forDuration: 0.6)

                    let texture3 = SKTexture(imageNamed: "logo2" )
                    let logo2 =  SKAction.setTexture(texture3)
                    let runner = SKAction.run {
                        fidget.physicsBody?.angularVelocity = 22
                    }
                    let stop = SKAction.run {
                        fidget.physicsBody?.angularVelocity = 0
                         fidget.zRotation = 0
                        demo = false
                        self.spinLabel.text = "Try It"

                    }
                    
                    let classicFidgetMove = SKAction.run {
                        self.spinLabel.text = "Classic Fidget Move"
                    }
                    
                    let thumbInCenter = SKAction.run {
                        self.spinLabel.text = "Place Thumb in Center"
                    }
                    
                    let IndexFingerHere = SKAction.run {
                        self.spinLabel.text = "Index Finger Here"
                    }
                    
                    let windUpandSpin = SKAction.run {
                        self.spinLabel.text = "Wind Up & Spin"
                    }
                    
                    
                    let start = SKAction.run {
                        fidget.zRotation = 0
                        fidget.physicsBody?.angularVelocity = 0
                        demo = true
                    }
                    fidget.run(SKAction.sequence([classicFidgetMove, start,wait,thumbInCenter,thumb,wait,wait,IndexFingerHere,index,wait,windUpandSpin,turn,wait3,turn2,wait3,turn3,logo2,runner,wait2,stop,wait,logo2]))
                }
 
                
                if name == "force" {
                    let fadeIn = SKAction.fadeAlpha(to: 0.8, duration:TimeInterval(0.15))
                    let myDecay = SKAction.wait(forDuration: 0.15)
                    let fadeOut = SKAction.fadeAlpha(to: 1.0, duration:TimeInterval(0.15))
                    touchedNode.run(SKAction.sequence([fadeIn,myDecay,fadeOut]))
                    
                    if cforce <= maxforce {
                        cforce = cforce + 1
                    } else {
                        cforce = 1
                    }
                    
                    if cforce <= cforce  {
                        currentSprite = forcearray[ cforce ]
                        
                        let texture = SKTexture(imageNamed: currentSprite )
                        let action =  SKAction.setTexture(texture)
                        touchedNode.run(action)
                    } else {
                        cforce = minforce
                        currentSprite =  forcearray[ cforce ]
                        
                        let texture = SKTexture(imageNamed: currentSprite )
                        let action =  SKAction.setTexture(texture)
                        touchedNode.run(action)
                    }
                    
                    if cforce == 1 {

                        force = 12
                        
                    } else if cforce == 2 {
                        
                        force = 24
                        
                    } else if cforce == 3 {
                        
                        force = 36
                        
                    }  else if cforce == 4 {
                        
                        force = 48
                        
                    }  else if cforce == 5 {
                    
                    force = 60
                        
                    }
                    
                    let v = fidget.physicsBody?.angularVelocity
                    if v! > CGFloat(force) {
                        fidget.physicsBody?.angularVelocity = CGFloat(force)
                    }
                    
                    let e = fidget.physicsBody?.angularVelocity
                    if -e! < CGFloat(-force) {
                        fidget.physicsBody?.angularVelocity = -(CGFloat)(force)
                    }
                }
                
                if name == "reset" {
                    let runcode = SKAction.run {
                        
                        if let scene = GameScene( fileNamed:"ParentalScene" ) {
                            
                            scene.run(forever)
                            
                            // Configure the view.
                            let skView = self.view! as SKView
                            skView.showsFPS = false
                            skView.showsNodeCount = false
                            skView.showsPhysics = false
                            skView.showsFields = false
                            skView.preferredFramesPerSecond = 60
                            skView.clearsContextBeforeDrawing = true
                            skView.isAsynchronous = true
                            
                            /* Sprite Kit applies additional optimizations to improve rendering performance */
                            skView.ignoresSiblingOrder = true
                            
                            skView.clipsToBounds = true
                            /* Set the scale mode to scale to fit the window */
                            scene.scaleMode = .aspectFit
                            scene.backgroundColor = SKColor.black
                            skView.presentScene(scene, transition: SKTransition.fade(withDuration: 2))
                        }
                    }
                    
                    let fade1 = SKAction.fadeAlpha(to: 0.7, duration:TimeInterval(0.15))
                    let myDecay = SKAction.wait(forDuration: 0.15)
                    let fade2 = SKAction.fadeAlpha(to: 1.0, duration:TimeInterval(0.15))
                    touchedNode.run(SKAction.sequence([fade1,myDecay,fade2,runcode]))
                }
            }
        }
    }
    
    
    override func didMove(to view: SKView) {
        let fidgetTexture = SKTexture(imageNamed: "logo2")
        fidget = SKSpriteNode(texture: fidgetTexture)
        fidget.physicsBody = SKPhysicsBody(texture: fidgetTexture, alphaThreshold: 0.9, size: fidgetTexture.size())
        fidget.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        fidget.position = CGPoint(x: 0, y: 0)
        fidget.physicsBody?.affectedByGravity = false
        fidget.physicsBody?.allowsRotation = true
        fidget.physicsBody?.pinned = true
        fidget.physicsBody?.categoryBitMask = 0
        fidget.physicsBody?.collisionBitMask = 0
        fidget.physicsBody?.contactTestBitMask = 0
        fidget.physicsBody?.isDynamic = true
        fidget.physicsBody?.restitution = 0.025
        fidget.physicsBody?.friction = 0
        fidget.physicsBody?.mass = 1
        fidget.physicsBody?.charge = 1
        fidget.physicsBody?.angularDamping = 0.3
        
        fidget.name = "fidget"
        scene?.addChild(fidget)
        
        scene?.physicsWorld.speed = 1.0
        scene?.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        mySensitiveArea = CGRect(x: 0, y:  UIScreen.main.bounds.size.height / 2 - UIScreen.main.bounds.size.width / 2, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width)
        
        gestureView.bounds = mySensitiveArea
        gestureView.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height / 2)
        
        gestureView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        view.addSubview(gestureView)
        view.bringSubview(toFront: gestureView)
        
        let twoFingerRotate = UIRotationGestureRecognizer(target: self, action: #selector(handleRotateGesture(gestureRec:)))
        gestureView.addGestureRecognizer(twoFingerRotate)
        
        let left = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.handleGesture(gesture:)))
        left.direction = .left
        gestureView.addGestureRecognizer(left)
        
        let right = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.handleGesture(gesture:)))
        right.direction = .right
        gestureView.addGestureRecognizer(right)
        
        let up = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.handleGesture(gesture:)))
        up.direction = .up
        gestureView.addGestureRecognizer(up)
        
        let down = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.handleGesture(gesture:)))
        down.direction = .down
        gestureView.addGestureRecognizer(down)
        
        let tap = UILongPressGestureRecognizer(target:self, action: #selector(handleTapGesture(gesture:)))
        tap.numberOfTouchesRequired = 3
        tap.minimumPressDuration = 0
        gestureView.addGestureRecognizer(tap)
        
        spinLabel = SKLabelNode(fontNamed:"HelveticaNeue-Bold")
        spinLabel.position = (scene?.childNode(withName: "spins")?.position)!
        spinLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        spinLabel.alpha = 1.0
        spinLabel.text = "0"
        spinLabel.fontSize = 64
        spinLabel.fontColor = UIColor.orange
        scene?.addChild(spinLabel)
        
        resetLabel = SKLabelNode(fontNamed:"HelveticaNeue-Bold")
        resetLabel.position = (scene?.childNode(withName: "reset")?.position)!
        resetLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        resetLabel.alpha = 1.0
        resetLabel.name = "reset"
        resetLabel.text = "Reset Fidget"
        resetLabel.fontSize = 48
        resetLabel.fontColor = UIColor.orange
        scene?.addChild(resetLabel)
    
        //fgt Button
        //Left
        defineSprite (
            texture: "switchleft",
            scene: self,
            name: "fgt-left",
            category: 0,
            collision: 0,
            contact: 0,
            field: 0,
            dynamic: false,
            allowRotation: false,
            affectedGravity: false,
            zPosition: 10,
            alpha: 1.0,
            speed: 0,
            alphaThreshold: 0
            ).drawHud()
        
        //fgt Button
        //Right
        defineSprite (
            texture: "switchright",
            scene: self,
            name: "fgt-right",
            category: 0,
            collision: 0,
            contact: 0,
            field: 0,
            dynamic: false,
            allowRotation: false,
            affectedGravity: false,
            zPosition: 10,
            alpha: 1.0,
            speed: 0,
            alphaThreshold: 0
            ).drawHud()
        
        defineSprite (
            texture: "southwind",
            scene: self,
            name: "rot-left",
            category: 0,
            collision: 0,
            contact: 0,
            field: 0,
            dynamic: false,
            allowRotation: false,
            affectedGravity: false,
            zPosition: 10,
            alpha: 0.6,
            speed: 0,
            alphaThreshold: 0
            ).drawHud()
        
        //fgt Button
        //Right
        defineSprite (
            texture: "northwind",
            scene: self,
            name: "rot-right",
            category: 0,
            collision: 0,
            contact: 0,
            field: 0,
            dynamic: false,
            allowRotation: false,
            affectedGravity: false,
            zPosition: 10,
            alpha: 0.6,
            speed: 0,
            alphaThreshold: 0
            ).drawHud()
        
        //Force
        defineSprite (
            texture: "50",
            scene: self,
            name: "force",
            category: 0,
            collision: 0,
            contact: 0,
            field: 0,
            dynamic: false,
            allowRotation: false,
            affectedGravity: false,
            zPosition: 10,
            alpha: 1.0,
            speed: 0,
            alphaThreshold: 0
            ).drawHud()
        
        //Spin
        defineSprite (
            texture: "g50",
            scene: self,
            name: "spin",
            category: 0,
            collision: 0,
            contact: 0,
            field: 0,
            dynamic: false,
            allowRotation: false,
            affectedGravity: false,
            zPosition: 10,
            alpha: 1.0,
            speed: 0,
            alphaThreshold: 0
            ).drawHud()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        //Spinner Counter
        let rot = Int(fidget.zRotation * CGFloat(180.0 / .pi ))
       
        let isFidgety = CGFloat(fidget.physicsBody?.angularVelocity ?? 0)
    
        if isFidgety == 0 {
            resetCheckpoint()
        }
        
        if(isFidgety > 0 && !demo ) {
            checkpoint4 = false
            checkpoint5 = false
            checkpoint6 = false
            if (rot > 0 && checkpoint1 && checkpoint2 && checkpoint3) {
                resetCheckpoint()
                counter = counter + 1
                spinLabel.text = String(counter)
            }
        
            
            if (rot < 0 && !checkpoint1) {
                checkpoint1 = true
            }
            
            //checkpoint
            if (rot > -120 && !checkpoint2) {
                checkpoint2 = true
            }
            
            //checkpoint
            if (rot > 120 && !checkpoint3 ) {
                checkpoint3 = true
            }
        }
        
        
    
        if(isFidgety < 0) {
            checkpoint1 = false
            checkpoint2 = false
            checkpoint3 = false
            
            if (rot < 0 && checkpoint4 && checkpoint5 && checkpoint6 && !demo) {
                resetCheckpoint()
                counter = counter + 1
                spinLabel.text = String(counter)
            }
            
            
            if (rot < 0 && !checkpoint4) {
                checkpoint4 = true
            }
            
            //checkpoint
            if (rot > -120 && !checkpoint5) {
                checkpoint5 = true
            }
            
            //checkpoint
            if (rot > 120 && !checkpoint6 ) {
                checkpoint6 = true
            }
            
        }
        
        //print(isFidgety)
        
        let isFidgetio = CGFloat(fidget.physicsBody?.angularVelocity ?? 0)
        
        if isFidgetio == 0 && globalDistance == 0 {
            view?.preferredFramesPerSecond = 30
            //scene?.physicsWorld.speed = 0.8
        } else {
            //scene?.physicsWorld.speed = 1
            view?.preferredFramesPerSecond = 60
        }
    }
    
    
    @objc func handleTapGesture(gesture: UITapGestureRecognizer) -> Void {
        fidget.physicsBody?.angularVelocity = 0
    }
    
    func resetCheckpoint() {
        checkpoint1 = false
        checkpoint2 = false
        checkpoint3 = false
        checkpoint4 = false
        checkpoint5 = false
        checkpoint6 = false
    }
    
    @objc func handleRotateGesture(gestureRec: UIRotationGestureRecognizer) -> Void {
        
        let max = CGFloat(force)
        let min = CGFloat(-force)
        
        var velocity = CGFloat(fidget.physicsBody?.angularVelocity ?? 0.0)
        
        var gestureVelocity = gestureRec.velocity
        if gestureVelocity > max {
            gestureVelocity = max
        } else if gestureVelocity < min {
            gestureVelocity = min
        }
        
        if velocity > max {
            fidget.physicsBody?.angularVelocity = max
        } else if velocity < min {
            velocity = min
            fidget.physicsBody?.angularVelocity = min
        } else {
            fidget.physicsBody?.angularVelocity = gestureVelocity * -0.375 * .pi
            if (fidget.physicsBody?.angularVelocity)! > max {
                fidget.physicsBody?.angularVelocity = max
            } else if (fidget.physicsBody?.angularVelocity)! < min {
                fidget.physicsBody?.angularVelocity = min
            }
        }
        
    }
    
    
    //we make condense this down later
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        
        var velocity = CGFloat(fidget.physicsBody?.angularVelocity ?? 0.0)
        let loc = (gesture.location(in: gestureView))
        let centerX = loc.x - gestureView.center.x
        let centerY = loc.y - gestureView.center.y
        
        let max = CGFloat(force)
        let min = CGFloat(-force)
        
        if velocity > max {
            velocity = max
        }
        
        if velocity < min {
            velocity = min
        }
        
        var pi = CGFloat.pi
        if velocity == max || velocity == min {
            pi = 0.0
        } else {
            pi = CGFloat.pi
            
        }
        
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            
            if centerY > 0 {
                fidget.physicsBody?.angularVelocity = 1 * pi + (velocity)
            } else {
                fidget.physicsBody?.angularVelocity = -1 * pi + (velocity)
            }
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.left {
            
            if centerY < 0 {
                fidget.physicsBody?.angularVelocity = 1 * pi + (velocity)
            } else {
                fidget.physicsBody?.angularVelocity = -1 * pi + (velocity)
            }
            
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.up {
            if centerX > 0 {
                fidget.physicsBody?.angularVelocity = 1 * pi + (velocity)
            } else {
                fidget.physicsBody?.angularVelocity = -1 * pi + (velocity)
            }
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.down {
            if centerX < 0 {
                fidget.physicsBody?.angularVelocity = 1 * pi + (velocity)
            } else {
                fidget.physicsBody?.angularVelocity = -1 * pi + (velocity)
            }
        }
    }
    
    
    //MARK: Sprites
    struct defineSprite {
        let texture: String
        let scene: SKScene
        let name: String
        let category:UInt32
        let collision:UInt32
        let contact:UInt32
        let field:UInt32
        let dynamic:Bool
        let allowRotation:Bool
        let affectedGravity:Bool
        let zPosition:CGFloat
        let alpha:CGFloat
        let speed:CGFloat
        let alphaThreshold: Float
        
        func drawHud()  {
            let sprite = SKSpriteNode(imageNamed: texture)
            let spc = CGFloat(96)
            
            if name == "spin" {
                sprite.position =  (scene.childNode(withName: "spn")?.position)!
                
            }
            
            if name == "force" {
                sprite.position =  (scene.childNode(withName: "force")?.position)!
                
            }
            
            if name == "fgt-left" {
                sprite.position =  (scene.childNode(withName: "fgt")?.position)!
                sprite.position.x = sprite.position.x - spc
                
            }
            
            if name == "fgt-right" {
                sprite.position =  (scene.childNode(withName: "fgt")?.position)!
                sprite.position.x = sprite.position.x + spc
            }
            
            
            if name == "rot-left" {
                sprite.position =  (scene.childNode(withName: "fgt")?.position)!
                sprite.position.x = sprite.position.x - spc - 180
                
            }
            
            if name == "rot-right" {
                sprite.position =  (scene.childNode(withName: "fgt")?.position)!
                sprite.position.x = sprite.position.x + spc + 180
            }
            
            sprite.alpha = alpha
            sprite.name = name
            
            scene.addChild(sprite)
        }
    }
}

