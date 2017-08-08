//
//  GameViewController.swift
//  ComeOneLetsGoAndPlay
//
//  Created by Arthur Masson on 07/08/2017.
//  Copyright © 2017 Giantwow. All rights reserved.
//

import QuartzCore
import SceneKit

/* importation du bon module selon la plateforme */
#if os(iOS)
    import UIKit
    typealias ViewController = UIViewController
#endif
#if os(macOS)
    import Cocoa
    typealias ViewController = NSViewController
#endif

class GameViewController: ViewController {
    
    /* permettre la reception des evenements clavier dans le cas de mac */
    #if os(macOS)
    @IBOutlet weak var gameView: GameView!
    #endif
    
    var gameScene: SCNScene!
    
    /* se creer des raccourcis vers les nodes de la scene */
    var heroNode: SCNNode?
    var followCameraNode: SCNNode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gameScene = SCNScene(named: "art.scnassets/GameScene.scn")
        
        self.setupNodes()
        
        if let scnView = self.view as? SCNView {
            scnView.scene = self.gameScene
            scnView.delegate = self
            
            scnView.allowsCameraControl = false
            scnView.showsStatistics = true
        }
        
        #if os(iOS)
            self.setupGestureReconizers()
        #endif
        #if os(macOS)
            self.gameView.keyDelegate = self
        #endif
    }
    
    func setupNodes() {
        self.heroNode = self.gameScene.rootNode.childNode(withName: "hero", recursively: true)
        self.followCameraNode = self.gameScene.rootNode.childNode(withName: "camera_follow", recursively: true)
    }
    
    func touch(at p: CGPoint) {
        Swift.print(#function, p)
    }
    
    func moveUp() {
        Swift.print(#function)
    }
    
    func moveDown() {
        Swift.print(#function)
    }
    
    func moveLeft() {
        Swift.print(#function)
    }
    
    func moveRight() {
        Swift.print(#function)
    }
}

extension GameViewController: SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        /* Camera following */
        if let heroNode = self.heroNode,
            let followCameraNode = self.followCameraNode {
            let x = heroNode.position.x - followCameraNode.position.x
            let z = heroNode.position.z - followCameraNode.position.z
            followCameraNode.position.x += x * 0.05
            followCameraNode.position.z += z * 0.05
        }
    }
}
