//
//  SetupGestureReconizers.swift
//  ComeOneLetsGoAndPlay
//
//  Created by Arthur Masson on 07/08/2017.
//  Copyright © 2017 Giantwow. All rights reserved.
//

import UIKit

extension GameViewController {
    
    func setupGestureReconizers() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.view.addGestureRecognizer(tap)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeft(_:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRight(_:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeUp(_:)))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeDown(_:)))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        let p = gestureRecognize.location(in: self.view)
        self.eventTouch(at: p)
    }
    
    func handleSwipeLeft(_ gestureRecognize: UISwipeGestureRecognizer) {
        self.eventLeft()
    }
    
    func handleSwipeRight(_ gestureRecognize: UISwipeGestureRecognizer) {
        self.eventRight()
    }
    
    func handleSwipeUp(_ gestureRecognize: UISwipeGestureRecognizer) {
        self.eventUp()
    }
    
    func handleSwipeDown(_ gestureRecognize: UISwipeGestureRecognizer) {
        self.eventDown()
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
}
