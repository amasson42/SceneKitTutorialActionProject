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
    var followLightNode: SCNNode?
    
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
        self.heroNode = self.gameScene.rootNode.childNode(withName: "fox", recursively: true)
        self.followCameraNode = self.gameScene.rootNode.childNode(withName: "camera_follow", recursively: true)
        self.followLightNode = self.gameScene.rootNode.childNode(withName: "light_follow", recursively: true)
    }
    
    func touch(at p: CGPoint) {
        Swift.print("touch at \(p)")
    }
    
    func moveUp() {
        let rotateAction = SCNAction.rotateTo(x: 0, y: 0, z: 0, duration: 0.2, usesShortestUnitArc: true)
        let moveAction = SCNAction.move(by: SCNVector3(0, 0, 1), duration: 0.4)
        let jumpAction = SCNAction.sequence([
            .move(by: SCNVector3(0, 0.5, 0), duration: 0.2),
            .move(by: SCNVector3(0, -0.5, 0), duration: 0.2)
            ])
        let groupAction = SCNAction.group([
            rotateAction,
            moveAction,
            jumpAction
            ])
        if let heroNode = self.heroNode {
            if heroNode.action(forKey: "move") == nil {
                heroNode.runAction(groupAction, forKey: "move")
            }
        }
    }
    
    func moveDown() {
        let rotateAction = SCNAction.rotateTo(x: 0, y: .pi, z: 0, duration: 0.2, usesShortestUnitArc: true)
        let moveAction = SCNAction.move(by: SCNVector3(0, 0, -1), duration: 0.4)
        let jumpAction = SCNAction.sequence([
            .move(by: SCNVector3(0, 0.5, 0), duration: 0.2),
            .move(by: SCNVector3(0, -0.5, 0), duration: 0.2)
            ])
        let groupAction = SCNAction.group([
            rotateAction,
            moveAction,
            jumpAction
            ])
        if let heroNode = self.heroNode {
            if heroNode.action(forKey: "move") == nil {
                heroNode.runAction(groupAction, forKey: "move")
            }
        }
    }
    
    func moveLeft() {
        let rotateAction = SCNAction.rotateTo(x: 0, y: .pi / 2.0, z: 0, duration: 0.2, usesShortestUnitArc: true)
        let moveAction = SCNAction.move(by: SCNVector3(1, 0, 0), duration: 0.4)
        let jumpAction = SCNAction.sequence([
            .move(by: SCNVector3(0, 0.5, 0), duration: 0.2),
            .move(by: SCNVector3(0, -0.5, 0), duration: 0.2)
            ])
        let groupAction = SCNAction.group([
            rotateAction,
            moveAction,
            jumpAction
            ])
        if let heroNode = self.heroNode {
            if heroNode.action(forKey: "move") == nil {
                heroNode.runAction(groupAction, forKey: "move")
            }
        }
    }
    
    func moveRight() {
        let rotateAction = SCNAction.rotateTo(x: 0, y: -.pi / 2.0, z: 0, duration: 0.2, usesShortestUnitArc: true)
        let moveAction = SCNAction.move(by: SCNVector3(-1, 0, 0), duration: 0.4)
        let jumpAction = SCNAction.sequence([
            .move(by: SCNVector3(0, 0.5, 0), duration: 0.2),
            .move(by: SCNVector3(0, -0.5, 0), duration: 0.2)
            ])
        let groupAction = SCNAction.group([
            rotateAction,
            moveAction,
            jumpAction
            ])
        if let heroNode = self.heroNode {
            if heroNode.action(forKey: "move") == nil {
                heroNode.runAction(groupAction, forKey: "move")
            }
        }
    }
}

extension GameViewController: SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if let heroNode = self.heroNode {
            self.followLightNode?.position = heroNode.position
            if let followCameraNode = self.followCameraNode {
                let x = heroNode.position.x - followCameraNode.position.x
                let z = heroNode.position.z - followCameraNode.position.z
                followCameraNode.position.x += x * 0.05
                followCameraNode.position.z += z * 0.05
            }
        }
    }
}
