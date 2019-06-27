//
//  ARVideoViewController.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 27/06/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ARVideoViewController: UIViewController, ARSCNViewDelegate {
    //Variables
    var videoURL:URL?
    
    //ARKit Variables
    private var hitTestResult: ARHitTestResult!
    var configuration = ARWorldTrackingConfiguration()
    var sceneView:ARSCNView = ARSCNView()
    
    //MARK: UIKit Stuff
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // AR and 3D View
        sceneView.delegate = self
        sceneView.showsStatistics = true
        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.fixInView(self.view)
        presentARVideo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Create a session configuration
        configuration = ARWorldTrackingConfiguration()
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    //MARK: ARView Stuff
    private func presentARVideo(){
        let node = SCNNode()
        /* Retrieve the video element */
        let videoNode = SKVideoNode(url: videoURL!)
        videoNode.play()
        /* Add the video to the scene when image is retrieved */
        let videoScene = SKScene(size: CGSize(width: 1280, height: 720))
        videoNode.position = CGPoint(x: videoScene.size.width / 2 ,y: videoScene.size.height / 2)
        videoNode.yScale = 1.0
        videoScene.addChild(videoNode) //Ready to display in 2D
        /* Add the video scene to the ARSCN */
        let planet = SCNPlane(width: 1.9,height: 1)
        planet.firstMaterial?.diffuse.contents = videoScene
        let planeNode = SCNNode(geometry: planet)
        planeNode.eulerAngles.x = -.pi
        planeNode.eulerAngles.y = .pi
        planeNode.position = SCNVector3(
            0,
            0,
            -1.5
        )
        node.addChildNode(planeNode)
        self.sceneView.scene.rootNode.addChildNode(node)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
