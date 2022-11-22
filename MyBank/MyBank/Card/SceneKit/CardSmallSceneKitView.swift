//
//  CardSmallSceneKitView.swift
//  MyBank
//
//  Created by Nicolas RIVIERE on 31/05/2021.
//

import SwiftUI
import SceneKit

struct CardSmallSceneKitView: View {
    let cardType: Card.Rank

    @Environment(\.presentationMode) var presentationMode

    @StateObject var coordinator = SceneCoordinator()
    @State var isAnimating = false
    @State var presentSceneView = false

    var body: some View {
        ZStack(alignment: .bottom) {
            SceneView(
                scene: coordinator.scene(from: cardType, isAnimating: isAnimating),
                options: [],
                delegate: coordinator
            )
            .ignoresSafeArea()
            .shadow(radius: 2)

            HStack(spacing: 0) {
                Spacer()

                Button(action: {
                    isAnimating = !isAnimating
                }, label: {
                    Image(systemName: isAnimating ? "pause.fill" : "play.fill")
                        .padding()
                        .foregroundColor(.black)
                })

                Button(action: {
                    presentSceneView = true
                }, label: {
                    Image(systemName: "view.3d")
                        .padding()
                        .foregroundColor(.black)
                })
            }
        }
        .fullScreenCover(isPresented: $presentSceneView) {
            CardSceneKitView(
                cardType: cardType,
                hasOrderPhysicalCard: .constant(false)
            )
        }
    }
}

extension CardSmallSceneKitView {
    class SceneCoordinator: NSObject, SCNSceneRendererDelegate, ObservableObject {

        var showsStatistics: Bool = false
        var debugOptions: SCNDebugOptions = [
//        .renderAsWireframe,
//        .showBoundingBoxes,
//        .showCameras
//        .showConstraints,
//        .showCreases,
//        .showLightExtents,
//        .showPhysicsFields,
//        .showLightInfluences,
//        .showPhysicsShapes,
//        .showSkeletons,
//        .showWireframe
        ]

        func scene(from cardType: Card.Rank, isAnimating: Bool) -> SCNScene {
            let scene = SCNScene(named: "art.scnassets/CardAnimatedScene.scn")!

            let cardNode: SCNNode

            switch cardType {
            case .visa:
                cardNode = SCNScene(named: "art.scnassets/CreditCard/CreditCard_1.0.1.scn")!.rootNode.childNode(withName: "Card", recursively: true)!

            case .gold:
                cardNode = SCNScene(named: "art.scnassets/CreditCardGold/CreditCardGold_1.0.1.scn")!.rootNode.childNode(withName: "Card", recursively: true)!

            case .cocoa:
                cardNode = SCNScene(named: "art.scnassets/CreditCardCocoaHeads/CreditCard_cocoa_1.0.1.scn")!.rootNode.childNode(withName: "Card", recursively: true)!
            }

            scene.rootNode.addChildNode(cardNode)

            if isAnimating {
                cardNode.runAction(
                    SCNAction.repeatForever(
                        SCNAction.rotateBy(
                            x: 0, y: 2 * CGFloat.pi, z: 0,
                            duration: 8.0
                        )
                    )
                )
            } else {
                cardNode.removeAllActions()
            }

            return scene
        }

        func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
            renderer.showsStatistics = self.showsStatistics
            renderer.debugOptions = self.debugOptions
        }
    }
}

struct CardSmallSceneKitView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardSmallSceneKitView(cardType: .visa)
                .previewLayout(.fixed(width: 375, height: 220))
        }
    }
}
