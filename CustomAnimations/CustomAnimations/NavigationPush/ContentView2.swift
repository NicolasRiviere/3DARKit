//
//  ContentView2.swift
//  CustomAnimations
//
//  Created by Nicolas RIVIERE on 26/03/2021.
//

import SwiftUI

struct ContentView2: View {
    let data = ["Adam", "Paul", "Jean", "Albert"]

    @Namespace var first

    var body: some View {
        FirstView2(data: data, nameSpace: first)
            .navigationBarHidden(true)
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}
