//
//  SecondView.swift
//  CustomAnimations
//
//  Created by Nicolas RIVIERE on 26/03/2021.
//

import SwiftUI

struct SecondView: View {
    let selectedName: String
    let nameSpace: Namespace.ID

    @Binding var showDetail: Bool

    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Button("Back") {
                        withAnimation(.easeInOut) { showDetail = false }
                    }
                    .padding()

                    Spacer()
                }

                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 80, height: 80, alignment: .center)
            }

            Text(selectedName)
                .padding()
                .matchedGeometryEffect(id: selectedName, in: nameSpace)

            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                .padding()

            Spacer()
        }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView(
            selectedName: "Preview",
            nameSpace: Namespace().wrappedValue,
            showDetail: .constant(true)
        )
    }
}
