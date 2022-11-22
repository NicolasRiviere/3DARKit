//
//  ARKitSceneView.swift
//  MyStore
//
//  Created by Nicolas RIVIERE on 16/07/2021.
//

import ARKit
import SwiftUI
import Foundation

struct ARKitSceneView: UIViewControllerRepresentable {
    let product: Product

    init(product: Product) {
        self.product = product
    }

    func makeUIViewController(context: Context) -> ARKitSceneVC {
        let vc = UIStoryboard(name: "Storyboard", bundle: .main).instantiateInitialViewController() as! ARKitSceneVC
        vc.virtualObject = VirtualObject(url: Bundle.main.url(forResource: product.pathTo3DModel, withExtension: "scn")!)!

        return vc
    }

    func updateUIViewController(_ uiViewController: ARKitSceneVC, context: Context) {

    }
}

class ARKitSceneVC: UIViewController {

    @IBOutlet weak var sceneView: VirtualObjectARView!
    @IBOutlet weak var actionButtonBackground: UIView!
    @IBOutlet weak var clearButtonBackground: UIView!

    let coachingOverlay = ARCoachingOverlayView()
    let focusSquare = FocusSquare()

    var virtualObject: VirtualObject!
    var isObjectPlaced: Bool { virtualObject.parent != nil }

    lazy var virtualObjectInteraction = VirtualObjectInteraction(sceneView: sceneView, viewController: self)

    /// A serial queue used to coordinate adding or removing nodes from the scene.
    let updateQueue = DispatchQueue(label: "com.example.apple-samplecode.arkitexample.serialSceneKitQueue")

    enum State {
        case initial
        case noPlaneDetected
        case planeDetected
    }

    var state: State = .initial {
        didSet {
            switch (state, coachingOverlay.isActive, isObjectPlaced) {
            case (.initial, _, _):
                clearButtonBackground.isHidden = true
                actionButtonBackground.isHidden = true

            case (_, true, _):
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.2, delay: 0.2, animations: {
                        self.actionButtonBackground.alpha = 0
                        self.clearButtonBackground.alpha = 0
                    })
                }

            case (.noPlaneDetected, false, false):
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.2, delay: 0.2, animations: {
                        self.actionButtonBackground.alpha = 0
                    })
                    self.clearButtonBackground.isHidden = true
                }

            case (.planeDetected, false, false):
                DispatchQueue.main.async {
                    self.actionButtonBackground.isHidden = false
                    UIView.animate(withDuration: 0.2, delay: 0.15, animations: {
                        self.actionButtonBackground.alpha = 1
                    })
                    self.clearButtonBackground.isHidden = true
                }

            case (_, false, true):
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.2, delay: 0.2, animations: {
                        self.actionButtonBackground.alpha = 0
                    })
                    self.clearButtonBackground.isHidden = false
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.delegate = self
        sceneView.session.delegate = self

        setupCoachingOverlay()
        setupFocusSquare()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        let options: ARSession.RunOptions = [.resetTracking, .removeExistingAnchors]
        configuration.planeDetection = .horizontal
        configuration.environmentTexturing = .automatic

//        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]

        // Run the view's session
        sceneView.session.run(configuration, options: options)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        UIApplication.shared.isIdleTimerDisabled = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Pause the view's session
        sceneView.session.pause()
    }

    var screenCenter: CGPoint {
        let bounds = sceneView.bounds
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }

    @IBAction func actionButtonTapped(_ sender: UIButton) {
        guard virtualObjectInteraction.selectedObject == nil,
              let query = sceneView.getRaycastQuery(for: virtualObject.allowedAlignment),
              let result = sceneView.castRay(for: query).first
        else { return }

        virtualObject.mostRecentInitialPlacementResult = result
        virtualObject.raycastQuery = query
        DispatchQueue.global(qos: .userInitiated).async {
            self.virtualObject.load()

            do {
                let scene = try SCNScene(url: self.virtualObject.referenceURL, options: nil)

                self.sceneView.prepare([scene], completionHandler: { _ in
                    DispatchQueue.main.async {
                        self.placeVirtualObject(self.virtualObject)
                    }
                })
            } catch {
                fatalError("Failed to load SCNScene from virtualObject")
            }
        }
    }

    @IBAction func clearButtonTapped(_ sender: UIButton) {
        guard virtualObjectInteraction.selectedObject != nil else { return }

        virtualObjectInteraction.selectedObject?.stopTrackedRaycast()
        virtualObjectInteraction.selectedObject?.removeFromParentNode()
        virtualObjectInteraction.selectedObject?.unload()
        if let anchor = virtualObjectInteraction.selectedObject?.anchor {
            sceneView.session.remove(anchor: anchor)
        }

        virtualObjectInteraction.selectedObject = nil
    }
}

extension ARKitSceneVC: ARSCNViewDelegate {
    func sessionWasInterrupted(_ session: ARSession) {

    }

    func sessionInterruptionEnded(_ session: ARSession) {
        guard let sessionConfiguration = session.configuration else { return }

        sceneView.session.run(sessionConfiguration, options: [.resetTracking, .removeExistingAnchors])
    }

    func session(_ session: ARSession, didFailWithError error: Error) {

    }

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        updateQueue.async {
            if self.virtualObject.anchor == anchor {
                self.virtualObject.simdPosition = anchor.transform.translation
                self.virtualObject.anchor = anchor
            }
        }
    }

    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        DispatchQueue.main.async {
            self.updateFocusSquare(isObjectVisible: self.isObjectPlaced)
        }
    }
}

extension ARKitSceneVC: ARSessionDelegate {

}
