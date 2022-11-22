//
//  CardSceneKitView.swift
//  MyBank
//
//  Created by Nicolas RIVIERE on 24/03/2021.
//

import Foundation
import SwiftUI
import SceneKit

struct CardSceneKitView: View {
    let cardType: Card.Rank

    @Environment(\.presentationMode) var presentationMode
    @State var isLoading = false
    @Binding var hasOrderPhysicalCard: Bool
    
    @StateObject var coordinator = SceneCoordinator()

    var body: some View {
        ZStack(alignment: .top) {
            SceneView(
                scene: coordinator.scene(from: cardType),
                options: [.allowsCameraControl],
                delegate: coordinator
            )
            .ignoresSafeArea()

            HStack {
                Spacer()
                Button("Close") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding(.horizontal)
            }

            VStack {
                Spacer()

                ZStack {
                    Button(action: { orderCardAndDismiss() }, label: {
                        Image(systemName: cardType != .gold ? "paperplane" : "wand.and.stars.inverse")
                            .foregroundColor(Color(hex: 0x38454a, opacity: isLoading || cardType == .gold ? 0.2 : 1))
                        Text(cardType != .gold ? "Order" : "Upgrade")
                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                            .foregroundColor(Color(hex: 0x38454a, opacity: isLoading || cardType == .gold ? 0.2 : 1))
                    })
                    .padding(.all, 12)
                    .background(Color(hex: 0xEBECEC))
                    .cornerRadius(10)
                    .disabled(isLoading || cardType == .gold)

                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    }
                }
            }
        }
    }

    private func orderCardAndDismiss() {
        isLoading = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if cardType == .visa {
                hasOrderPhysicalCard = true
            }

            isLoading = false
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct CardSceneKitView_Previews: PreviewProvider {
    static var previews: some View {
        CardSceneKitView(cardType: .gold, hasOrderPhysicalCard: .constant(false))
    }
}

extension CardSceneKitView {
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

        func scene(from cardType: Card.Rank) -> SCNScene {
            let scene = SCNScene(named: "art.scnassets/CardScene.scn")!
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

            return scene
        }

        func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
            renderer.showsStatistics = self.showsStatistics
            renderer.debugOptions = self.debugOptions
        }
    }
}
