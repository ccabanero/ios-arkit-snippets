//
//  ViewController.swift
//  TouchFire
//
//  Created by Clint Cabanero on 8/8/17.
//  Copyright © 2017 Big Leaf Mobile LLC. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.showsStatistics = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            
            let vector = SCNVector3(0, -5, -10)
            self.addFireParticle(position: vector)
            self.addBoke(position: vector)
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: sceneView)
    }
    
    func addFireParticle(position: SCNVector3){
        
        guard let fire = SCNParticleSystem(named: "reactor", inDirectory: nil) else {
            return
        }
        
        let fireNode = SCNNode()
        fireNode.addParticleSystem(fire)
        fireNode.position = position
        sceneView.scene.rootNode.addChildNode(fireNode)
    }
    
    func addBoke(position: SCNVector3){
        
        guard let fire = SCNParticleSystem(named: "bokeh", inDirectory: nil) else {
            return
        }
        
        let fireNode = SCNNode()
        fireNode.addParticleSystem(fire)
        fireNode.position = position
        sceneView.scene.rootNode.addChildNode(fireNode)
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

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
