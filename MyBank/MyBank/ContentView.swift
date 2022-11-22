//
//  ContentView.swift
//  MyBank
//
//  Created by Nicolas RIVIERE on 15/02/2021.
//

import SwiftUI

// https://mattermost.worldline.tech/fpl-db/pl/o6ojns1pi3nxjfiu3aicrmy4hr
struct ContentView: View {
    @State var showCardDetail = false
    @Namespace var cardNameSpace
    @State var hasOrderedPhysicalCard = false
    @State var hasUpgradedCard = false

    var body: some View {
        ZStack {
            if showCardDetail {
                CardDetailView(
                    showCardDetail: $showCardDetail,
                    cardViewNameSpace: cardNameSpace,
                    hasOrderedPhysicalCard: $hasOrderedPhysicalCard,
                    hasUpgradedCard: $hasUpgradedCard
                )
                .transition(
                    AnyTransition
                        .asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)
                        )
                        .combined(with: .opacity)
                )
            } else {
                TransactionList(
                    showCardDetail: $showCardDetail,
                    cardViewNameSpace: cardNameSpace
                )
                .transition(
                    AnyTransition
                        .slide
                        .combined(with: .opacity)
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                TabView {
                    ContentView()
                        .environmentObject(CardModel())
                        .environmentObject(TransactionModel())
                }
            }
            
            NavigationView {
                TabView {
                    ContentView()
                        .environmentObject(CardModel())
                        .environmentObject(TransactionModel())
                }

            }.previewDevice(PreviewDevice(stringLiteral: "iPhone 8"))
        }
    }
}
