//
//  GameViewController.swift
//  Fidget
//
//  Created by StarPlayr on 5/3/17.
//  Copyright © 2017 StarPlayr. All rights reserved.
//

import SpriteKit
import GoogleMobileAds

let view = SKView()

class GameViewController: UIViewController, GADBannerViewDelegate {
    

    lazy var adBannerView: GADBannerView = {
        var adSize = GADAdSizeFullWidthPortraitWithHeight(100.0)
        let adBannerView = GADBannerView(adSize: adSize)
        adBannerView.adUnitID = "ca-app-pub-9099198421656829/2376072871"
        adBannerView.delegate = self
        adBannerView.rootViewController = self
        return adBannerView
    }()
    
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("Banner loaded successfully")
        self.view.addSubview(bannerView)
        //wwself.view = bannerView
        bannerView.clipsToBounds = true
        
        

    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("Fail to receive ads")
        print(error)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = GADRequest()
        request.testDevices = ["cfb53dbb9abd778c59d7b06b03a700ec"]
        
        adBannerView.load(request)
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                // Present the scene
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = false
            view.showsPhysics = false
            view.showsFPS = false
            view.showsNodeCount = false
            view.isAsynchronous = false
            view.isUserInteractionEnabled = true
            view.isOpaque = true
            view.allowsTransparency = false
        }
        
        
        

        
        
    }
    
    @IBAction func Vibrate(_ sender: Any) {
        //fidget.physicsBody?.angularVelocity = 0.0
    }
    
    
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            return .portrait
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
