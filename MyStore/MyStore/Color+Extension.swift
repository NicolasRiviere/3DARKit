//
//  Color+Extension.swift
//  MyStore
//
//  Created by Nicolas RIVIERE on 16/07/2021.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        self.init(
            UIColor(hex: hex, alpha: opacity)
        )
    }
}

extension UIColor {
    convenience init(hex: Int, alpha: Double = 1) {
        self.init(
            red: CGFloat((hex >> 16) & 0xff) / 255,
            green: CGFloat((hex >> 8) & 0xff) / 255,
            blue: CGFloat(hex & 0xff) / 255,
            alpha: CGFloat(alpha)
        )
    }
}
