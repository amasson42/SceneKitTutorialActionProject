//
//  GameView.swift
//  ComeOneLetsGoAndPlay
//
//  Created by Arthur Masson on 07/08/2017.
//  Copyright © 2017 Giantwow. All rights reserved.
//

import SceneKit
import Cocoa

class GameView: SCNView {
    weak var keyDelegate: GameViewController?
    
    override func becomeFirstResponder() -> Bool {
        return keyDelegate != nil
    }
    
    override func resignFirstResponder() -> Bool {
        return true
    }
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        self.keyDelegate?.touch(at: event.locationInWindow)
    }
    
    override func keyDown(with event: NSEvent) {
        if let keyDelegate = self.keyDelegate {
            switch event.keyCode {
            case 123, 0:
                keyDelegate.moveLeft()
            case 124, 2:
                keyDelegate.moveRight()
            case 125, 1:
                keyDelegate.moveDown()
            case 126, 13:
                keyDelegate.moveUp()
            default:
                Swift.print("Unknow use of key \(event.keyCode)")
            }
        }
    }
}
