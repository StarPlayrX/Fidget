//
//  ParentalScene.swift
//  Fidget
//
//  Created by StarPlayr on 5/28/17.
//  Copyright © 2017 Todd Bruss. All rights reserved.
//

import SpriteKit
import AudioToolbox
import AVFoundation


//var animalsArray: Array = ["🐶","🐶","🐱","🐭","🐰","🦊","🐻","🐼","🐨","🐯","🦁","🐮","🐷","🐸","🐵","🐔","🐧","🦉","🐺","🐗","🐴","🐴"]

var animalsArray: Array = ["🦊","🦊","🐼","🐨","🐯","🦁","🐮","🐵","🐰","🐰"]

var animalsTextArray: Array = ["fox","fox","panda","koala","tiger","lion","cow","monkey","rabbit","rabbit"]

var insArray: Array = ["🐝","🐝","🐛","🦋","🐞","🦎","🐙","🐟","🐬","🐬"]
var insTextArray: Array = ["bee","bee","caterpillar","butterfly","lady bug","gecko","squid","fish","dolphin","dolphin"]

var frtArray: Array = ["🍎","🍎","🍐","🍊","🍋","🍉","🥝","🥑","🍅","🍅"]
var frtTextArray: Array = ["apple","apple","pear","tangerine","lemon","watermelon","kiwi","avocado", "tomato","tomato"]

//var foodArray: Array = ["🥐","🥐","🧀","🍳","🥓","🥞","🍕","🌭","🍔","🍟","🌮","🌮"]
//var foodTextArray: Array = ["croissant","croissant","cheese","fried egg","bacon","pancakes","pizza","hotdog","hamburger","fries","taco","taco"]

var animals = 1
var ins = 1
var frt = 1
var food = 1

var animalsSet = 1
var insSet = 1
var frtSet = 1
var foodSet = 1

class ParentalScene: SKScene, AVSpeechSynthesizerDelegate {
    
    var maxanimals = 8
    var minanimals = 1
    
    var maxins = 8
    var minins = 1
    
    var maxfrt = 8
    var minfrt = 1
    
    var emojifontsize = CGFloat(150)
    var animalsLabel: SKLabelNode = SKLabelNode(fontNamed: "Apple Color Emoji")
    var animalsTextLabel: SKLabelNode = SKLabelNode(fontNamed: "HelveticaNeue")
    
    var insLabel: SKLabelNode = SKLabelNode(fontNamed: "Apple Color Emoji")
    var insTextLabel: SKLabelNode = SKLabelNode(fontNamed: "HelveticaNeue")
    
    var frtLabel: SKLabelNode = SKLabelNode(fontNamed: "Apple Color Emoji")
    var frtTextLabel: SKLabelNode = SKLabelNode(fontNamed: "HelveticaNeue")
    
    var textLabel: SKLabelNode = SKLabelNode(fontNamed: "HelveticaNeue")
    var textLabel2: SKLabelNode = SKLabelNode(fontNamed: "HelveticaNeue")
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches as Set<UITouch>, with: event)
        for touch: AnyObject in touches {
            let location: CGPoint = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            if let name = touchedNode.name {
                //print(touchedNode as Any)
                
                
                
                //Animals
                if name == "animal-right" {
                    if animals <= maxanimals {
                        animals = animals + 1
                    }
                    
                    if animals  <= maxanimals  {
                        animalsLabel.text = animalsArray[ animals ]
                        //animalsTextLabel.text = animalsTextArray[ animals ]
                        
                    } else {
                        animals  = minanimals
                        animalsLabel.text = animalsArray[ animals ]
                        //animalsTextLabel.text = animalsTextArray[ animals ]
                        
                    }
                }
                
                if name == "animal-left" {
                    if animals >= minanimals {
                        animals = animals - 1
                    }
                    
                    if animals >= minanimals  {
                        animalsLabel.text = animalsArray[ animals ]
                        //animalsTextLabel.text = animalsTextArray[ animals ]
                    } else {
                        animals = maxanimals
                        animalsLabel.text = animalsArray[ animals ]
                        //animalsTextLabel.text = animalsTextArray[ animals ]
                        
                    }
                }
                
                //Insects / ins
                if name == "ins-left" {
                    if ins >= minins {
                        ins = ins - 1
                    }
                    
                    if ins >= minins  {
                        insLabel.text = insArray[ ins ]
                    } else {
                        ins = maxins
                        insLabel.text = insArray[ ins ]
                    }
                }
                
                
                if name == "ins-right" {
                    if ins <= maxins {
                        ins = ins + 1
                    }
                    
                    if ins  <= maxins  {
                        insLabel.text = insArray[ ins ]
                    } else {
                        ins  = minins
                        insLabel.text = insArray[ ins ]
                    }
                }
                
                //Fruit / frt
                if name == "frt-left" {
                    if frt >= minfrt {
                        frt = frt - 1
                    }
                    
                    if frt >= minfrt  {
                        frtLabel.text = frtArray[ frt ]
                    } else {
                        frt = maxfrt
                        frtLabel.text = frtArray[ frt ]
                    }
                }
                
                
                if name == "frt-right" {
                    if frt <= maxfrt {
                        frt = frt + 1
                    }
                    
                    if frt  <= maxfrt  {
                        frtLabel.text = frtArray[ frt ]
                    } else {
                        frt  = minfrt
                        frtLabel.text = frtArray[ frt ]
                    }
                }
                
                
                if name == "speaker" {
                    
                    let speakText = "Kids, Ask your parents to match the words with e-moe-gees. After completing the puzzle, press Enter."
                    
                    let utterance = AVSpeechUtterance(string:speakText)
                    utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                    let voice = AVSpeechSynthesizer()
                    voice.speak(utterance)
                }
                
            
                if name == "enter" {
            
                    var shouldContinue = false
                    
                    //If we have a match
                    if animalsSet == animals && insSet == ins && frtSet == frt {
                        shouldContinue = true
                    }
                    
                    if shouldContinue {
                        
                        let runcode = SKAction.run {
                            
                            if let scene = GameScene( fileNamed:"GameScene" ) {
                                
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
                        
                    } else {
                        
                        let runcode = SKAction.run {
                            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
                        }
                        
                        let fade1 = SKAction.fadeAlpha(to: 0.7, duration:TimeInterval(0.15))
                        let myDecay = SKAction.wait(forDuration: 0.15)
                        let fade2 = SKAction.fadeAlpha(to: 1.0, duration:TimeInterval(0.15))
                        touchedNode.run(SKAction.sequence([fade1,myDecay,fade2,runcode]))
                    
                    }
                }
                
                /*
                 AudioServicesPlaySystemSound(1519) // Actuate `Peek` feedback (weak boom)
                 AudioServicesPlaySystemSound(1520) // Actuate `Pop` feedback (strong boom)
                 AudioServicesPlaySystemSound(1521) // Actuate `Nope` feedback (series of three weak booms)
                 */
      
            }
        }
    }
    
    
    override func didMove(to view: SKView) {
        //animals Button
        //Left
        defineSprite (
            texture: "switchleft",
            scene: self,
            name: "animal-left",
            category: 0,
            collision: 0,
            contact: 0,
            field: 0,
            dynamic: false,
            allowRotation: false,
            affectedGravity: false,
            zPosition: 10,
            alpha: 0.75,
            speed: 0,
            alphaThreshold: 0,
            fontsize: Float(emojifontsize)
            ).drawHud( animalsLabel: animalsLabel, animalsTextLabel: animalsTextLabel,  insLabel: insLabel, insTextLabel: insTextLabel,  frtLabel: frtLabel, frtTextLabel: frtTextLabel, textLabel: textLabel, textLabel2: textLabel2   )
        
        
        //animals Button
        //Right
        defineSprite (
            texture: "switchright",
            scene: self,
            name: "animal-right",
            category: 0,
            collision: 0,
            contact: 0,
            field: 0,
            dynamic: false,
            allowRotation: false,
            affectedGravity: false,
            zPosition: 10,
            alpha: 0.75,
            speed: 0,
            alphaThreshold: 0,
            fontsize: Float(emojifontsize)
            ).drawHud( animalsLabel: animalsLabel, animalsTextLabel: animalsTextLabel,  insLabel: insLabel, insTextLabel: insTextLabel,  frtLabel: frtLabel, frtTextLabel: frtTextLabel, textLabel: textLabel, textLabel2: textLabel2   )
        
        
        defineSprite (
            texture: "switchleft",
            scene: self,
            name: "ins-left",
            category: 0,
            collision: 0,
            contact: 0,
            field: 0,
            dynamic: false,
            allowRotation: false,
            affectedGravity: false,
            zPosition: 10,
            alpha: 0.75,
            speed: 0,
            alphaThreshold: 0,
            fontsize: Float(emojifontsize)
            ).drawHud( animalsLabel: animalsLabel, animalsTextLabel: animalsTextLabel,  insLabel: insLabel, insTextLabel: insTextLabel,  frtLabel: frtLabel, frtTextLabel: frtTextLabel, textLabel: textLabel, textLabel2: textLabel2   )
        
        //animals Button
        //Right
        defineSprite (
            texture: "switchright",
            scene: self,
            name: "ins-right",
            category: 0,
            collision: 0,
            contact: 0,
            field: 0,
            dynamic: false,
            allowRotation: false,
            affectedGravity: false,
            zPosition: 10,
            alpha: 0.75,
            speed: 0,
            alphaThreshold: 0,
            fontsize: Float(emojifontsize)
            ).drawHud( animalsLabel: animalsLabel, animalsTextLabel: animalsTextLabel,  insLabel: insLabel, insTextLabel: insTextLabel,  frtLabel: frtLabel, frtTextLabel: frtTextLabel, textLabel: textLabel, textLabel2: textLabel2   )
        
        
        
        defineSprite (
            texture: "switchleft",
            scene: self,
            name: "frt-left",
            category: 0,
            collision: 0,
            contact: 0,
            field: 0,
            dynamic: false,
            allowRotation: false,
            affectedGravity: false,
            zPosition: 10,
            alpha: 0.75,
            speed: 0,
            alphaThreshold: 0,
            fontsize: Float(emojifontsize)
            ).drawHud( animalsLabel: animalsLabel, animalsTextLabel: animalsTextLabel,  insLabel: insLabel, insTextLabel: insTextLabel,  frtLabel: frtLabel, frtTextLabel: frtTextLabel, textLabel: textLabel, textLabel2: textLabel2   )
        
        
        //animals Button
        //Right
        defineSprite (
            texture: "switchright",
            scene: self,
            name: "frt-right",
            category: 0,
            collision: 0,
            contact: 0,
            field: 0,
            dynamic: false,
            allowRotation: false,
            affectedGravity: false,
            zPosition: 10,
            alpha: 0.75,
            speed: 0,
            alphaThreshold: 0,
            fontsize: Float(emojifontsize)
            ).drawHud( animalsLabel: animalsLabel, animalsTextLabel: animalsTextLabel,  insLabel: insLabel, insTextLabel: insTextLabel,  frtLabel: frtLabel, frtTextLabel: frtTextLabel, textLabel: textLabel, textLabel2: textLabel2   )
        
        
        //animals Button
        //Right
        defineSprite (
            texture: "speaker",
            scene: self,
            name: "speaker",
            category: 0,
            collision: 0,
            contact: 0,
            field: 0,
            dynamic: false,
            allowRotation: false,
            affectedGravity: false,
            zPosition: 10,
            alpha: 0.75,
            speed: 0,
            alphaThreshold: 0,
            fontsize: Float(emojifontsize)
            ).drawHud( animalsLabel: animalsLabel, animalsTextLabel: animalsTextLabel,  insLabel: insLabel, insTextLabel: insTextLabel,  frtLabel: frtLabel, frtTextLabel: frtTextLabel, textLabel: textLabel, textLabel2: textLabel2  )
        
        
    }
    
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
        let fontsize: Float
        
        func drawHud( animalsLabel: SKLabelNode, animalsTextLabel: SKLabelNode, insLabel: SKLabelNode, insTextLabel: SKLabelNode, frtLabel: SKLabelNode, frtTextLabel: SKLabelNode, textLabel: SKLabelNode, textLabel2: SKLabelNode )  {
            let sprite = SKSpriteNode(imageNamed: texture)
            let spc = CGFloat(220)
            let vspc = CGFloat(55)
            let vshift = CGFloat(20)
            //let lalpha = CGFloat(0.75)
            
            if name == "animal-left" {
                
                sprite.position =  (scene.childNode(withName: "animals")?.position)!
                sprite.position.x = sprite.position.x - spc
                
                animalsLabel.fontSize = CGFloat(fontsize)
                animalsLabel.name = "animalsLabel"
                animalsLabel.horizontalAlignmentMode = .center
                animalsLabel.verticalAlignmentMode = .center
                animalsLabel.position = (scene.childNode(withName: "animals")?.position)!
                animalsLabel.position.y = sprite.position.y + vspc - vshift
                scene.addChild(animalsLabel)
                
                animalsTextLabel.fontSize = CGFloat(37)
                animalsTextLabel.fontColor = UIColor.white
                animalsTextLabel.name = "animalsTextLabel"
                animalsTextLabel.horizontalAlignmentMode = .center
                animalsTextLabel.verticalAlignmentMode = .center
                animalsTextLabel.position = (scene.childNode(withName: "animals")?.position)!
                animalsTextLabel.position.y = sprite.position.y - vspc - vshift
                
                scene.addChild(animalsTextLabel)
            }
            
            if name == "animal-right" {
                
                sprite.position =  (scene.childNode(withName: "animals")?.position)!
                sprite.position.x = sprite.position.x + spc
            }
            
            if name == "ins-left" {
                
                sprite.position =  (scene.childNode(withName: "ins")?.position)!
                sprite.position.x = sprite.position.x - spc
                
                insLabel.fontSize = CGFloat(fontsize)
                insLabel.name = "insLabel"
                insLabel.horizontalAlignmentMode = .center
                insLabel.verticalAlignmentMode = .center
                insLabel.position = (scene.childNode(withName: "ins")?.position)!
                insLabel.position.y = sprite.position.y + vspc - vshift
                scene.addChild(insLabel)
                
                
                insTextLabel.fontSize = CGFloat(37)
                insTextLabel.fontColor = UIColor.white
                insTextLabel.name = "insTextLabel"
                insTextLabel.horizontalAlignmentMode = .center
                insTextLabel.verticalAlignmentMode = .center
                insTextLabel.position = (scene.childNode(withName: "ins")?.position)!
                insTextLabel.position.y = sprite.position.y - vspc - vshift
                
                scene.addChild(insTextLabel)
            }
            
            if name == "ins-right" {
                
                sprite.position =  (scene.childNode(withName: "ins")?.position)!
                sprite.position.x = sprite.position.x + spc
            }
            
            
            if name == "frt-left" {
                
                sprite.position =  (scene.childNode(withName: "fruit")?.position)!
                sprite.position.x = sprite.position.x - spc
                
                frtLabel.fontSize = CGFloat(fontsize)
                frtLabel.name = "frtLabel"
                frtLabel.horizontalAlignmentMode = .center
                frtLabel.verticalAlignmentMode = .center
                frtLabel.position = (scene.childNode(withName: "fruit")?.position)!
                frtLabel.position.y = sprite.position.y + vspc - vshift
                scene.addChild(frtLabel)
                
                
                frtTextLabel.fontSize = CGFloat(37)
                frtTextLabel.fontColor = UIColor.white
                frtTextLabel.name = "frtTextLabel"
                frtTextLabel.horizontalAlignmentMode = .center
                frtTextLabel.verticalAlignmentMode = .center
                frtTextLabel.position = (scene.childNode(withName: "fruit")?.position)!
                frtTextLabel.position.y = sprite.position.y - vspc - vshift
                
                scene.addChild(frtTextLabel)
            }
            
            if name == "frt-right" {
                
                sprite.position =  (scene.childNode(withName: "fruit")?.position)!
                sprite.position.x = sprite.position.x + spc
            }
            
            
            
            
            if name == "speaker" {
                
                sprite.position =  (scene.childNode(withName: "speaker")?.position)!
                
                textLabel.fontSize = CGFloat(37)
                textLabel.fontColor = UIColor.white
                textLabel.name = "speaker"
                textLabel.horizontalAlignmentMode = .left
                textLabel.verticalAlignmentMode = .center
                textLabel.position = (scene.childNode(withName: "text")?.position)!
                //textLabel.position.y = sprite.position.y + vspc - vshift

                textLabel.text = "Kids, Ask your parents to"
                scene.addChild(textLabel)
                
                textLabel2.fontSize = CGFloat(37)
                textLabel2.fontColor = UIColor.white
                textLabel2.name = "speaker"
                textLabel2.horizontalAlignmentMode = .left
                textLabel2.verticalAlignmentMode = .center
                textLabel2.position = (scene.childNode(withName: "text2")?.position)!
                textLabel2.text = "match the words with emojis."
                scene.addChild(textLabel2)
            }
            
            animalsSet = 0
            var animals2 = 0
            
            while animalsSet == animals2 {
                animalsSet = Int(arc4random_uniform(8) + 1)
                animals2 = Int(arc4random_uniform(8) + 1)
                animals = animals2
            }
            
            
            insSet = 0
            var ins2 = 0
            
            while insSet == ins2 {
                insSet = Int(arc4random_uniform(8) + 1)
                ins2 = Int(arc4random_uniform(8) + 1)
                ins = ins2
            }
      
            
            frtSet = 0
            var frt2 = 0
            
            while frtSet == frt2 {
                frtSet = Int(arc4random_uniform(8) + 1)
                frt2 = Int(arc4random_uniform(8) + 1)
                frt = frt2
            }
         
        
            //sprite.zPosition = 200
            sprite.alpha = alpha
            sprite.name = name
            
            scene.addChild(sprite)
            
            animalsLabel.text = animalsArray[animals2]
            animalsTextLabel.text = animalsTextArray[animalsSet]
            
            insLabel.text = insArray[ins2]
            insTextLabel.text = insTextArray[insSet]
            
            frtLabel.text = frtArray[frt2]
            frtTextLabel.text = frtTextArray[frtSet]
            
        }
    }
}
