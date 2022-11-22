//
//  SeparatorView.swift
//  MyBank
//
//  Created by Nicolas RIVIERE on 18/02/2021.
//

import SwiftUI

struct SeparatorView: View {
    var body: some View {
        Rectangle()
            .frame(height: 0.5)
            .foregroundColor(Color(UIColor.gray.withAlphaComponent(0.2)))
            .padding(.leading, 24)
            .padding(.top, 2)
    }
}
