//
//  QLPreviewView.swift
//  MyStore
//
//  Created by Nicolas RIVIERE on 23/07/2021.
//

import UIKit
import SwiftUI
import QuickLook
import ARKit

struct EmbededQLPreview: UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    #warning("not working since iOS 15 apparently https://developer.apple.com/forums/thread/691784")
    func makeUIViewController(context: Context) -> UINavigationController {
        let previewController = QLPreviewController()
        let navigationController = UINavigationController(rootViewController: previewController)

        previewController.delegate = context.coordinator
        previewController.dataSource = context.coordinator

        let doneButton = UIButton(primaryAction: UIAction(handler: { action in
            previewController.dismiss(animated: true, completion: nil)
        }))
        doneButton.setTitle("Close", for: .normal)
        doneButton.translatesAutoresizingMaskIntoConstraints = false

        previewController.view.addSubview(doneButton)
        doneButton.centerXAnchor.constraint(equalTo: previewController.view.centerXAnchor, constant: 0).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: previewController.view.bottomAnchor, constant: -8).isActive = true

        return navigationController
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        uiViewController
            .viewControllers
            .first(where: { $0 is QLPreviewController })
            .map({ $0 as? QLPreviewController })??
            .reloadData()
    }

    class Coordinator: NSObject, QLPreviewControllerDelegate, QLPreviewControllerDataSource {
        let previewView: EmbededQLPreview

        init(_ view: EmbededQLPreview) {
            self.previewView = view
        }

        func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
            1
        }

        func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
            guard let path = Bundle.main.path(forResource: "chair_swan", ofType: "usdz") else { fatalError("Couldn't find the supported input file.") }

            let url = URL(fileURLWithPath: path)

            return url as QLPreviewItem
        }
    }
}
