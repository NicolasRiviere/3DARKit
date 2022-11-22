//
//  CustomAnimationsApp.swift
//  CustomAnimations
//
//  Created by Nicolas RIVIERE on 26/03/2021.
//

import SwiftUI

@main
struct CustomAnimationsApp: App {
    @State var firstScene = false

    var body: some Scene {
        WindowGroup {
            if firstScene {
                ContentView()
            } else {
                NavigationView {
                    ContentView2()
                }
            }
        }
    }
}
