//
//  ARKitSceneVC+FocusIndicator.swift
//  MyStore
//
//  Created by Nicolas RIVIERE on 30/07/2021.
//

import UIKit

extension ARKitSceneVC {
    func setupFocusSquare() {
        sceneView.scene.rootNode.addChildNode(focusSquare)
    }

    // MARK: - Focus Square

    func updateFocusSquare(isObjectVisible: Bool) {
        if isObjectVisible || coachingOverlay.isActive {
            focusSquare.hide()
            state = .noPlaneDetected

            return
        } else {
            focusSquare.unhide()
        }

        // Perform ray casting only when ARKit tracking is in a good state.
        if let camera = sceneView.session.currentFrame?.camera, case .normal = camera.trackingState,
            let query = sceneView.getRaycastQuery(),
            let result = sceneView.castRay(for: query).first {

            updateQueue.async {
                self.sceneView.scene.rootNode.addChildNode(self.focusSquare)
                self.focusSquare.state = .detecting(raycastResult: result, camera: camera)
                self.state = .planeDetected
            }
        } else {
            updateQueue.async {
                self.focusSquare.state = .initializing
                self.state = .noPlaneDetected
                self.sceneView.pointOfView?.addChildNode(self.focusSquare)
            }
        }
    }
}
