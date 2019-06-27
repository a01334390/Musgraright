//
//  Image360ViewController.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 27/06/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class Image360ViewController: UIViewController, ARSCNViewDelegate {
    
    // Variables
    var image360:UIImage?
    
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
        createPortal()
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
    
    private func createPortal() {
        let portalScene = SCNScene(named:"Art.scnassets/Portal.scn")
        let portalNode = portalScene?.rootNode.childNode(withName: "Portal", recursively: false)
        portalNode?.geometry?.firstMaterial?.diffuse.contents = UIColor.white
        portalNode?.geometry?.firstMaterial?.transparency = 0.00001
        let sphericalNode = portalNode?.childNode(withName: "sphere", recursively: false)
        sphericalNode?.geometry?.firstMaterial?.diffuse.contents = image360
        
        //convertir las coordenadas del rayo del tap a coordenadas del mundo real
        let planeXposition = 0
        let planeYposition = 0
        let planeZposition = 0
        portalNode?.position = SCNVector3(planeXposition,planeYposition,planeZposition)
        self.sceneView.scene.rootNode.addChildNode(portalNode!)
    }
}
