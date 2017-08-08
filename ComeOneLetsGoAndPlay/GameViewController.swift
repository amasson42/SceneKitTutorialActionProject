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
    
    /* se creer des raccourcis vers la scene et ses nodes */
    var gameScene: SCNScene!
    
    var heroNode: SCNNode!
    var followCameraNode: SCNNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* creation de la scene et initialisation des valeurs du jeu */
        self.gameScene = SCNScene(named: "art.scnassets/GameScene.scn")
        
        if let scnView = self.view as? SCNView {
            scnView.scene = self.gameScene
            scnView.delegate = self
            
            scnView.allowsCameraControl = false
            scnView.showsStatistics = true
        }
        
        self.setupNodes()
        
        /* gestion des evenements selon la plateforme */
        #if os(iOS)
            self.setupGestureReconizers()
        #endif
        #if os(macOS)
            self.gameView.keyDelegate = self
        #endif
    }
    
    func setupNodes() {
        /* initialisation de valeurs que nous ne pouvons pas faire dans l'editeur de scene */
        
        self.heroNode = self.gameScene.rootNode.childNode(withName: "hero", recursively: true)
        self.followCameraNode = self.gameScene.rootNode.childNode(withName: "camera_follow", recursively: true)
    }
    
    /* fonctions de receptions d'evenements du jeu */
    func eventTouch(at p: CGPoint) {
        Swift.print(#function, p)
    }
    
    func eventUp() {
        Swift.print(#function)
    }
    
    func eventDown() {
        Swift.print(#function)
    }
    
    func eventLeft() {
        Swift.print(#function)
    }
    
    func eventRight() {
        Swift.print(#function)
    }
    
}

extension GameViewController: SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        /* Camera following */
        
        let x = self.heroNode.position.x - self.followCameraNode.position.x
        let z = self.heroNode.position.z - self.followCameraNode.position.z
        self.followCameraNode.position.x += x * 0.05
        self.followCameraNode.position.z += z * 0.05
    }
}
