//
//  MyStoreApp.swift
//  MyStore
//
//  Created by Nicolas RIVIERE on 30/06/2021.
//

import SwiftUI

@main
struct MyStoreApp: App {

    @State var productStore = ProductStore()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            GeometryReader { geometry in
                ZStack(alignment: .bottomLeading) {
                    TabView {
                        NavigationView {
                            ContentView()
                                .environmentObject(productStore)
                        }
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                        }

                        ProfileView()
                            .tabItem {
                                Image(systemName: "person")
                                Text("Profile")
                            }

                        CartView()
                            .tabItem {
                                Image(systemName: "cart")
                                Text("Cart")
                            }
                    }

                    ZStack {
                        Circle()
                            .foregroundColor(.red)

                        Text("1")
                            .foregroundColor(.white)
                            .font(Font.system(size: 12))
                    }
                    .frame(width: 15, height: 15)
                    .offset(x: (( 2 * 3/*badge pos*/) - 0.95) * (geometry.size.width / (2 * 3/*badge count*/)) + 2, y: -28)
//                    .opacity(self.order.items.count == 0 ? 0 : 1.0)
                }
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        let coloredAppearance = UINavigationBarAppearance()
//        coloredAppearance.configureWithOpaqueBackground()
//        coloredAppearance.backgroundColor = UIColor(hex: 0xEACDC1)
//        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
//        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
//
//        UINavigationBar.appearance().standardAppearance = coloredAppearance
//        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance


        return true
    }
}
