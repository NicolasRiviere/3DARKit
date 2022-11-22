//
//  ContentView.swift
//  CustomAnimations
//
//  Created by Nicolas RIVIERE on 26/03/2021.
//

import SwiftUI

struct ContentView: View {
    let data = ["Adam", "Paul", "Jean", "Albert"]

    @State var showDetail = false
    @State var selectedProfile: String? = nil

    @Namespace var first

    var body: some View {
        ZStack {
            if showDetail, let selectedName = selectedProfile  {
                SecondView(
                    selectedName: selectedName,
                    nameSpace: first,
                    showDetail: $showDetail
                )
                .zIndex(2)
                .transition(
                    .asymmetric(
                        insertion: .move(edge: .trailing),
                        removal: .move(edge: .leading)
                    )
                )
            } else {
                FirstView(
                    data: data,
                    nameSpace: first,
                    selectedName: $selectedProfile,
                    showDetail: $showDetail
                )
                .zIndex(1)
//                    .matchedGeometryEffect(id: "ID", in: first)
                .transition(
                    .asymmetric(
                        insertion: .move(edge: .leading),
                        removal: .move(edge: .trailing))
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
