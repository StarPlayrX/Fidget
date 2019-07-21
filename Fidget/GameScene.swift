//
//  GameScene.swift
//  Fidget
//
//  Created by StarPlayr on 5/3/17.
//  Copyright © 2017 StarPlayr. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {
    
    var fidget = SKSpriteNode()
    var globalDistance = CGFloat(0.0)
    var mySensitiveArea = CGRect()
    var gestureView = UIView()

    override func didMove(to view: SKView) {
 
       let fidgetTexture = SKTexture(imageNamed: "beachspin")
    
       fidget = SKSpriteNode(texture: fidgetTexture)
        fidget.physicsBody = SKPhysicsBody(texture: fidgetTexture, alphaThreshold: 0.9, size: fidgetTexture.size())
        fidget.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        fidget.position = CGPoint(x: 0, y: 0)
        fidget.physicsBody?.affectedByGravity = true;
        fidget.physicsBody?.allowsRotation = true
        fidget.physicsBody?.pinned = true
        fidget.physicsBody?.categoryBitMask = 0
        fidget.physicsBody?.collisionBitMask = 0
        fidget.physicsBody?.contactTestBitMask = 0
        fidget.physicsBody?.isDynamic = true;
        fidget.physicsBody?.restitution = 3;
        fidget.physicsBody?.friction = 0
        fidget.physicsBody?.mass = 1
        fidget.name = "fidget"
        scene?.addChild(fidget)
        
        scene?.physicsWorld.speed = 1.0
        scene?.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        
        mySensitiveArea = CGRect(x: 0, y:  UIScreen.main.bounds.size.height / 2 - UIScreen.main.bounds.size.width / 2, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width)
        
        

         gestureView.bounds = mySensitiveArea
         gestureView.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height / 2)


        //gestureView.backgroundColor = UIColor.red
        //gestureView.alpha = 0.5
        gestureView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
         view.addSubview(gestureView)
         view.bringSubview(toFront: gestureView)


         //gestureRecognizer.cancelsTouchesInView = false

        
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
        
        let tap = UITapGestureRecognizer(target:self, action: #selector(handleTapGesture(gesture:)))
        tap.numberOfTouchesRequired = 2
        gestureView.addGestureRecognizer(tap)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        let isFidgety = Int(fidget.physicsBody?.angularVelocity ?? 0)

        if isFidgety == 0 && globalDistance == 0 {
            view?.preferredFramesPerSecond = 30
            scene?.physicsWorld.speed = 0.5
        } else {
            scene?.physicsWorld.speed = 1
            view?.preferredFramesPerSecond = 60
        }
    }

    
    func handleTapGesture(gesture: UITapGestureRecognizer) -> Void {
            fidget.physicsBody?.angularVelocity = 0
    }
    
    func handleRotateGesture(gestureRec: UIRotationGestureRecognizer) -> Void {
        var velocity = CGFloat(fidget.physicsBody?.angularVelocity ?? 0.0)

        let max = CGFloat(500)
        let min = CGFloat(-500)
        if velocity > max {
            fidget.physicsBody?.angularVelocity = max
        } else if velocity < min {
            velocity = min
            fidget.physicsBody?.angularVelocity = min
        } else {
            fidget.physicsBody?.angularVelocity = gestureRec.velocity * -0.5 * .pi
        }
    }
    
    
    //we make condense this down latera
    func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        var velocity = CGFloat(fidget.physicsBody?.angularVelocity ?? 0.0)
        let loc = (gesture.location(in: gestureView))
        let centerX = loc.x - gestureView.center.x
        let centerY = loc.y - gestureView.center.y
        
        let max = CGFloat(500)
        let min = CGFloat(-500)
      
        if velocity > max {
            velocity = max
        }
        
        if velocity < min {
            velocity = min
        }
        //print("x: " + String(describing: centerX) + " y:" + String(describing: centerY))
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
         
            if centerY > 0 {
                fidget.physicsBody?.angularVelocity = 1 * .pi + (velocity)
            } else {
                fidget.physicsBody?.angularVelocity = -1 * .pi + (velocity)
            }
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.left {
            
            if centerY < 0 {
                fidget.physicsBody?.angularVelocity = 1 * .pi + (velocity)
            } else {
                fidget.physicsBody?.angularVelocity = -1 * .pi + (velocity)
            }


         
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.up {
            if centerX > 0 {
                fidget.physicsBody?.angularVelocity = 1 * .pi + (velocity)
            } else {
                fidget.physicsBody?.angularVelocity = -1 * .pi + (velocity)
            }
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.down {
            if centerX < 0 {
                fidget.physicsBody?.angularVelocity = 1 * .pi + (velocity)
            } else {
                fidget.physicsBody?.angularVelocity = -1 * .pi + (velocity)
            }
        }
    }
    
    
    
    


}

