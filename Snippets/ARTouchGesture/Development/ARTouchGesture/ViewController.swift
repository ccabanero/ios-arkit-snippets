//
//  ViewController.swift
//  ARTouchGesture
//
//  Created by Clint Cabanero on 8/11/17.
//  Copyright © 2017 Clint Cabanero. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import AVFoundation

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var player: AVAudioPlayer?
    
    // MARK: - ViewController lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        guard let scene = SCNScene(named: "art.scnassets/firewood.dae") else {
            return
        }
        
        // Set the scene to the view
        sceneView.scene = scene
        
        initializeFirewood()
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

    // MARK: - Scene Setup
    
    func initializeFirewood() {
        
        // Get the firewood node in the scene
        guard let fireWood = sceneView.scene.rootNode.childNode(withName: "Firewood", recursively: true) else {
            return
        }
        
        // Reposition the firewood node
        fireWood.position = SCNVector3Make(0, -4, -5)
    }
    
    // MARK: - Scene Gesture & Interaction
    
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
        
        // Evaluate if the touched node is the firewood node
        let node = hitObject.node
        if node.name == "Firewood" { // find name at /art.scnassets/firewood.dae - node inspector
            lightOnFire(targetNode: node)
            playSound(file: "sound_fire", fileExtension: "mp3")
        }
    }
    
    // Utility method for adding a fire particle system on the target node
    func lightOnFire(targetNode: SCNNode) {
        
        guard let fire = SCNParticleSystem(named: "fire", inDirectory: nil) else {
            return
        }
        
        let fireNode = SCNNode()
        fireNode.addParticleSystem(fire)
        fireNode.position = targetNode.position
        sceneView.scene.rootNode.addChildNode(fireNode)
    }
    
    // Utility method for playing a sound
    func playSound(file: String, fileExtension: String) {
        guard let url = Bundle.main.url(forResource: file, withExtension: fileExtension) else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            self.player = try AVAudioPlayer(contentsOf: url)
            guard let player = self.player else { return }
            player.play()
            player.numberOfLoops = -1 // play forever
        } catch let error {
            print(error.localizedDescription)
        }
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
