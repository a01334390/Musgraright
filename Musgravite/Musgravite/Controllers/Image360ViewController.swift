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
import Vision

class Image360ViewController: UIViewController, ARSCNViewDelegate {
    
    // Variables
    var image360:UIImage?
    
    //ARKit Variables
    private var hitTestResult: ARHitTestResult!
    private var resnetModel = Resnet50()
    private var visionRequests = [VNRequest]()
    var configuration = ARWorldTrackingConfiguration()
    var sceneView:ARSCNView = ARSCNView()
    
    //Touch Variables
    let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapGes))
    
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
    
    //MARK: Vision Stuff
    @IBAction func tapGestureRecognized(_ sender: UITapGestureRecognizer) {
        let vista = sender.view as! ARSCNView
        let ubicacionToque = self.sceneView.center
        guard let currentFrame = vista.session.currentFrame else {return}
        let hitTestResults = vista.hitTest(ubicacionToque, types: .featurePoint)
        if (hitTestResults .isEmpty){
            return}
        guard let hitTestResult = hitTestResults.first else{
            return
        }
        let imagenPixeles = currentFrame.capturedImage
        self.hitTestResult = hitTestResult
        performVisionRequest(pixelBuffer: imagenPixeles)
    }
    
    private func performVisionRequest(pixelBuffer: CVPixelBuffer){
        //inicializar el modelo de ML al modelo usado, en este caso resnet
        let visionModel = try! VNCoreMLModel(for: resnetModel.model)
        let request = VNCoreMLRequest(model: visionModel) { request, error in
            
            if error != nil {
                //hubo un error
                return}
            guard let observations = request.results else {
                //no hubo resultados por parte del modelo
                return
                
            }
            //obtener el mejor resultado
            let observation = observations.first as! VNClassificationObservation
            
            print("Nombre \(observation.identifier) confianza \(observation.confidence)")
//            self.desplegarTexto(entrada: observation.identifier)
            
        }
        //la imagen que se pasará al modelo sera recortada para quedarse con el centro
        request.imageCropAndScaleOption = .centerCrop
        self.visionRequests = [request]
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .upMirrored, options: [:])
        DispatchQueue.global().async {
            try! imageRequestHandler.perform(self.visionRequests)
            
        }
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
