//
//  ShareView.swift
//  CaptureSample
//
//  Created by Nicolas RIVIERE on 18/05/2022.
//  Copyright © 2022 Apple. All rights reserved.
//

import SwiftUI

struct ShareView: UIViewControllerRepresentable {
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> some UIViewController {
        return UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

    }
}
