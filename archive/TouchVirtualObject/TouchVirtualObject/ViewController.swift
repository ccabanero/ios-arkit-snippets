//
//  ViewController.swift
//  TouchVirtualObject
//
//  Created by Clint Cabanero on 8/8/17.
//  Copyright © 2017 Big Leaf Mobile LLC. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    // MARK: - View lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.showsStatistics = true
        sceneView.scene = SCNScene()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingSessionConfiguration()
        sceneView.session.run(configuration)
        
        addShipToSceneView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
    // MARK: - Instance Methods
    
    func addShipToSceneView() {
        
        // Create a ship scene node
        let ship = Ship()
        ship.createShipNode()
        
        // Position the ship
        let xPos = randomPosition(lowerBound: -1.5, upperBound: 1.5)
        let yPos = randomPosition(lowerBound: -1.5, upperBound: 1.5)
        let shipVector = SCNVector3(xPos, yPos, -1)
        ship.position = shipVector
        
        // Add ship node to the scene
        sceneView.scene.rootNode.addChildNode(ship)
    }
    
    func randomPosition (lowerBound lower: Float, upperBound upper: Float) -> Float {
        return Float(arc4random()) / Float(UInt32.max) * (lower - upper) + upper
    }
    
    // MARK: - UIKit Gesture
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: sceneView)
        
        let hitList = sceneView.hitTest(location, options: nil)
        
        guard let hitObject = hitList.first else {
            return
        }
        
        let node = hitObject.node
        if node.name == "shipMesh" { // See art.scnassets
            node.removeFromParentNode()
            addShipToSceneView()
        }
    }
    
    // MARK: - ARSCNViewDelegate
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        print("file: \(#file), line: \(#line), function: \(#function)")
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        print("file: \(#file), line: \(#line), function: \(#function)")
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        print("file: \(#file), line: \(#line), function: \(#function)")
    }
}

