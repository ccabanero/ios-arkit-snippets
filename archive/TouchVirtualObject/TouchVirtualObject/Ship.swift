//
//  Ship.swift
//  TouchVirtualObject
//
//  Created by Clint Cabanero on 8/8/17.
//  Copyright © 2017 Big Leaf Mobile LLC. All rights reserved.
//

import ARKit

class Ship: SCNNode {
    func createShipNode() {
        guard let scene = SCNScene(named: "art.scnassets/ship.scn") else {
            return
        }
        
        let sceneNode = SCNNode()
        for child in scene.rootNode.childNodes {
            sceneNode.addChildNode(child)
        }
        
        self.addChildNode(sceneNode)
    }
}

