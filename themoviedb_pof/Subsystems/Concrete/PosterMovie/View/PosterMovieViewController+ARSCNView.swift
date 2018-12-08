//
//  PosterMovieViewController+ARSCNView.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 25.05.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import ARKit

extension PosterMovieViewController: ARSCNViewDelegate {
    
    func initScenViewAndARSession() {
        initSceneView()
        initARSession()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        drawPlaneNode(on: node, for: planeAnchor)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        guard anchor is ARPlaneAnchor else { return }
        node.enumerateChildNodes { (childNode, _) in
            childNode.removeFromParentNode()
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        node.enumerateChildNodes { (childNode, _) in
            childNode.removeFromParentNode()
        }
        drawPlaneNode(on: node, for: planeAnchor)
    }
    
    // MARK: Private
    
    private func initSceneView() {
        sceneView.delegate = self
        sceneView.automaticallyUpdatesLighting = true
        sceneView.preferredFramesPerSecond = 60
        sceneView.antialiasingMode = .multisampling2X
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
    }
    
    private func initARSession() {
        guard ARWorldTrackingConfiguration.isSupported else {
            print(PosterMovieConstants.ARSessionError)
            return
        }
        
        let config = createARConfiguration()
        sceneView.session.run(config)
    }
    
    private func createARConfiguration() -> ARConfiguration {
        let config = ARWorldTrackingConfiguration()
        config.worldAlignment = .gravity
        config.planeDetection = .vertical
        config.isLightEstimationEnabled = true
        return config
    }
    
    private func drawPlaneNode(on node: SCNNode, for planeAnchor: ARPlaneAnchor) {
        let planeNode = SCNNode(geometry: SCNPlane(
            width: CGFloat(planeAnchor.extent.x),
            height: CGFloat(planeAnchor.extent.z)
        ))
        planeNode.position = SCNVector3(planeAnchor.center.x,
                                        planeAnchor.center.y,
                                        planeAnchor.center.z)
        planeNode.geometry?.firstMaterial?.isDoubleSided = true
        planeNode.eulerAngles = SCNVector3(-Double.pi / 2, 0, 0)
        planeNode.geometry?.firstMaterial?.diffuse.contents = listener?.setImage()
        node.addChildNode(planeNode)
    }
}
