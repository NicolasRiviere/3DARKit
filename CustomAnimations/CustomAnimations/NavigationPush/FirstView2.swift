//
//  FirstView2.swift
//  CustomAnimations
//
//  Created by Nicolas RIVIERE on 26/03/2021.
//

import SwiftUI

struct FirstView2: View {
    let data: [String]
    let nameSpace: Namespace.ID

    var body: some View {
        List {
            Text("Profils :")
                .padding()

            ForEach(data, id: \.hash) { name in
                NavigationLink(
                    destination: SecondView2(selectedName: name, nameSpace: nameSpace),
                    label: {
                        Text(name)
                            .padding()
                            .matchedGeometryEffect(
                                id: name,
                                in: nameSpace,
                                properties: .frame,
                                anchor: .center,
                                isSource: true
                            )
                    }
                )
            }
        }
    }
}

struct FirstView2_Previews: PreviewProvider {
    static var previews: some View {
        FirstView2(
            data: ["Adam", "Paul", "Jean", "Albert"],
            nameSpace: Namespace().wrappedValue
        )
    }
}
