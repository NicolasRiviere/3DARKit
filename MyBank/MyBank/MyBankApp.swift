//
//  MyBankApp.swift
//  MyBank
//
//  Created by Nicolas RIVIERE on 15/02/2021.
//

import SwiftUI

@main
struct MyBankApp: App {
    @StateObject var cardModel = CardModel()
    @StateObject var transactionModel = TransactionModel()

    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    ContentView()
                        .environmentObject(cardModel)
                        .environmentObject(transactionModel)
                }
                .tabItem {
                    Image(systemName: "creditcard.fill")
                }

                ContactView()
                    .tabItem {
                        Image(systemName: "phone")
                    }

                AccountView()
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                    }
            }
            .accentColor(Color(hex: 0x2bc1e8))
        }
    }
}
