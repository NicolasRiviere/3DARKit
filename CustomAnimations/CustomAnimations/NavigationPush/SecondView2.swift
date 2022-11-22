//
//  SecondView2.swift
//  CustomAnimations
//
//  Created by Nicolas RIVIERE on 26/03/2021.
//

import SwiftUI

struct SecondView2: View {
    let selectedName: String
    let nameSpace: Namespace.ID

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Button("Back") {
                        withAnimation(.easeInOut) { presentationMode.wrappedValue.dismiss() }
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
                .matchedGeometryEffect(
                    id: selectedName,
                    in: nameSpace,
                    properties: .frame,
                    anchor: .center,
                    isSource: true
                )

            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                .padding()

            Spacer()
        }
        .navigationBarHidden(true)
    }
}

struct SecondView2_Previews: PreviewProvider {
    static var previews: some View {
        SecondView2(
            selectedName: "Preview",
            nameSpace: Namespace().wrappedValue
        )
    }
}
