//
//  FirstView.swift
//  CustomAnimations
//
//  Created by Nicolas RIVIERE on 26/03/2021.
//

import SwiftUI

struct FirstView: View {
    let data: [String]
    let nameSpace: Namespace.ID

    @Binding var selectedName: String?
    @Binding var showDetail: Bool

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Text("Profils :")
                        .padding()
                    Spacer()
                }

                ForEach(data, id: \.hash) { name in
                    Text(name)
                        .matchedGeometryEffect(id: name, in: nameSpace)
                        .padding()
                        .onTapGesture {
                            selectedName = name
                            withAnimation(.easeInOut) { showDetail = true }
                        }
                }
            }
        }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView(
            data: ["Adam", "Paul", "Jean", "Albert"],
            nameSpace: Namespace().wrappedValue,
            selectedName: .constant(nil),
            showDetail: .constant(false)
        )
    }
}
