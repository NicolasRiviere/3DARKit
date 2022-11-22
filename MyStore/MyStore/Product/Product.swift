//
//  Product.swift
//  MyStore
//
//  Created by Nicolas RIVIERE on 30/06/2021.
//

import Foundation

struct Product: Identifiable {
    let id = UUID()

    let title: String
    let imageName: String
    let description: String
    let alternativeImageName: [String]
    let price: Double
    let has3DModel: Bool
    /// Relative path to SceneView without extension name
    let pathTo3DModel: String
}

extension Product {
    static var sample: Product {
        .init(
            title: "Konsyap",
            imageName: "konsyap_crop",
            description: "Ceci est un tabouret",
            alternativeImageName: [],
            price: 54.55,
            has3DModel: false,
            pathTo3DModel: "art.scnassets/chair/chair"
        )
    }
}
