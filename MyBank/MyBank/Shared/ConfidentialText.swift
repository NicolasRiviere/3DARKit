//
//  ConfidentialText.swift
//  MyBank
//
//  Created by Nicolas RIVIERE on 22/02/2021.
//

import SwiftUI

struct ConfidentialText: View {
    let title: String
    let kerning: CGFloat
    @Binding var isShown: Bool

    init(_ title: String, kerning: CGFloat = 2, isShown: Binding<Bool>) {
        self.title = title
        self.kerning = kerning
        self._isShown = isShown
    }

    var body: some View {
        if isShown {
            Text(title)
                .kerning(kerning)
        } else {
            Text(title)
                .kerning(kerning)
                .foregroundColor(.clear)
                .background(Color(hex: 0xe9e9e9))
                .cornerRadius(6)
        }
    }
}

struct ConfidentialText_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ConfidentialText("Hello World !", isShown: .constant(true))
            ConfidentialText("Hello World !", isShown: .constant(false))
        }
        .previewLayout(.fixed(width: 200, height: 55))
    }
}
