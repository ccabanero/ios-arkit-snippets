//
//  ViewController.swift
//  TouchSpawn
//
//  Created by Clint Cabanero on 8/16/17.
//  Copyright © 2017 Clint Cabanero. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var ponyNode: SCNNode!
    var nodes = [SCNNode]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        guard let scene = SCNScene(named: "art.scnassets/main.scn") else {
            return
        }
        
        // Set the scene to the view
        sceneView.scene = scene
        
        loadPony()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    func loadPony() {
        guard let fidgetSpinnerScene = SCNScene(named: "art.scnassets/pony.dae") else {
            return
        }
        
        ponyNode = fidgetSpinnerScene.rootNode.childNode(withName: "pony", recursively: true)
        ponyNode.scale = SCNVector3Make(0.01, 0.01, 0.01)
    }
    
    // MARK: - Gesture
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: sceneView)
        
        if let hit = sceneView.hitTest(location, types: .featurePoint).first {
            sceneView.session.add(anchor: ARAnchor(transform: hit.worldTransform))
        }
    }
    
    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
    
        // clear previous
        for node in nodes {
            node.removeFromParentNode()
        }
        
        // Clone a new fidget spinner
        let ponyNodeClone = ponyNode.clone()
        nodes.append(ponyNodeClone)
        ponyNodeClone.position = SCNVector3Make(0, 0, 0)
        
        // Add ship as a child of node
        node.addChildNode(ponyNodeClone)
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        print("File: \(#file), Method: \(#function), Line: \(#line)")
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        print("File: \(#file), Method: \(#function), Line: \(#line)")
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        print("File: \(#file), Method: \(#function), Line: \(#line)")
    }
}
