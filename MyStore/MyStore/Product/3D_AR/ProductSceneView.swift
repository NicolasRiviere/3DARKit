//
//  ProductSceneView.swift
//  MyStore
//
//  Created by Nicolas RIVIERE on 02/07/2021.
//

import SwiftUI

struct ProductSceneView: View {
    let product: Product
    @State var selectedMode: Mode
    @Environment(\.presentationMode) var mode

    @StateObject var coordinator = SceneCoordinator()

    var body: some View {
        VStack {
            ZStack {
                Picker(selection: $selectedMode, label: Text("SceneSelector")) {
                    Text("3D").tag(Mode.threeD)
                    Text("AR").tag(Mode.ar)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 100)
                .padding(.top)

                HStack {
                    Spacer()

                    Button(action: { mode.wrappedValue.dismiss() }, label: {
                        Text("Close")
                    })
                    .padding([.top, .trailing])
                }
            }

            if selectedMode == .threeD {
                SceneView(
                    scene: coordinator.scene(product: product),
                    options: [.allowsCameraControl],
                    delegate: coordinator
                )
                .ignoresSafeArea(.all, edges: .bottom)
            } else {
                ARKitSceneView(product: product)
            }
        }
    }
}

extension ProductSceneView {
    enum Mode: Int, Identifiable {
        case threeD
        case ar

        var id: Int {
            self.rawValue
        }
    }
}

import SceneKit

extension ProductSceneView {
    class SceneCoordinator: NSObject, SCNSceneRendererDelegate, ObservableObject {

        var showsStatistics: Bool = false
        var debugOptions: SCNDebugOptions = []

        func scene(product: Product) -> SCNScene {
            SCNScene(named: "\(product.pathTo3DModel).scn")!
        }

        func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
            renderer.showsStatistics = self.showsStatistics
            renderer.debugOptions = self.debugOptions
        }
    }
}

struct ProductSceneView_Previews: PreviewProvider {
    static var previews: some View {
        ProductSceneView(
            product: .sample,
            selectedMode: .threeD
        )
    }
}
