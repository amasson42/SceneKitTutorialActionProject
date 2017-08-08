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
        self.keyDelegate?.eventTouch(at: event.locationInWindow)
    }
    
    override func keyDown(with event: NSEvent) {
        if let keyDelegate = self.keyDelegate {
            switch event.keyCode {
            case 123, 0:
                keyDelegate.eventLeft()
            case 124, 2:
                keyDelegate.eventRight()
            case 125, 1:
                keyDelegate.eventDown()
            case 126, 13:
                keyDelegate.eventUp()
            default:
                Swift.print("Unknow use of key \(event.keyCode)")
            }
        }
    }
}
