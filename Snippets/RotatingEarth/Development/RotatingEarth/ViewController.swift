//
//  ViewController.swift
//  RotatingEarth
//
//  Created by Clint Cabanero on 8/10/17.
//  Copyright © 2017 Clint Cabanero. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    // MARK: - ViewController lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = false
        
        // Create a new scene
        guard let scene = SCNScene(named: "art.scnassets/earth_at_night.dae") else {
            return
        }
        
        // Set the scene to the view
        sceneView.scene = scene
        
        // Initialize Nodes in scene
        self.initializeEarthNode()
        self.initializeStars()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
        
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

    // MARK: - Scene Node configuration
    
    func initializeEarthNode() {
        
        // Get the earth ndoe in the scene
        guard let earthNode = sceneView.scene.rootNode.childNode(withName: "Sphere", recursively: true) else {
            return
        }
        
        // Reposition the earth node
        earthNode.position = SCNVector3Make(0, -0.5, -4)
        
        // Rotate the earth node
        let rotateAction = SCNAction.rotate(by: 90, around: SCNVector3Make(0, 1, 0), duration: 700)
        guard let rotationLoop = SCNAction.repeatForever(rotateAction) else {
            return
        }
        earthNode.runAction(rotationLoop)
    }
    
    func initializeStars(){
        
        // Get the stars particle system
        guard let stars = SCNParticleSystem(named: "stars", inDirectory: "art.scnassets") else {
            return
        }
        
        // Add particle system to scene
        let starsNode = SCNNode()
        starsNode.addParticleSystem(stars)
        starsNode.position = SCNVector3Make(0, 0, -4)
        sceneView.scene.rootNode.addChildNode(starsNode)
    }
    
    // MARK: - ARSCNViewDelegate
    
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
