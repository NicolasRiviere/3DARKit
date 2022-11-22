//
//  ProductStore.swift
//  MyStore
//
//  Created by Nicolas RIVIERE on 02/07/2021.
//

import Foundation

final class ProductStore: ObservableObject {
    @Published var headProduct: Product?
    @Published var headCategory: (title: String, products: [Product])?
    @Published var personalSuggestions: (title: String, products: [Product])?

    func fetch() {
        headProduct = .init(title: "Sofa set", imageName: "bank_center_crop", description: "", alternativeImageName: ["bank_crop_portrait"], price: 150.6, has3DModel: false, pathTo3DModel: "")

        headCategory = (title: "Longing for a new chair ?", products: [
            .init(
                title: "Konsyap",
                imageName: "konsyap_crop",
                description: "A hand-crafted expression that is both comfy and sturdy to suit even the liveliest family members.\nIdeal for all the activities around the table like eating, playing games, drawing and homework.",
                alternativeImageName: [],
                price: 25.89,
                has3DModel: false,
                pathTo3DModel: ""
            ),
            .init(
                title: "CocoonOut",
                imageName: "jardin_crop",
                description: "Relax outdoors in your CocoonOut. Its airy and light design makes it easy to move around.",
                alternativeImageName: [],
                price: 45.50,
                has3DModel: false,
                pathTo3DModel: ""
            ),
            .init(
                title: "Sweet Red",
                imageName: "chair",
                description: "In this Sweet Red chair, you happily sit longer at the table. A great way to invite some red into your dining room.",
                alternativeImageName: [],
                price: 60.10,
                has3DModel: true,
                pathTo3DModel: "art.scnassets/chair/chair"),
            .init(
                title: "Eames",
                imageName: "eames-chair-3d-model",
                description: "The chair’s softly shaped seat shell in beige provides comfy support for back. For extra softness, you can complete with a matching cushion.",
                alternativeImageName: [],
                price: 37.99,
                has3DModel: true,
                pathTo3DModel: "art.scnassets/eames/EamesScene"
            )
        ])

        personalSuggestions = (title: "Based on your last purchases", products: [
        ])
    }
}

extension ProductStore {
    static func preview() -> ProductStore {
        let productStore = ProductStore()

        productStore.headProduct = .none
        productStore.headCategory = .none
        productStore.personalSuggestions = .none

        return productStore
    }
}
