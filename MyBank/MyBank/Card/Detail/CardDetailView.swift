//
//  CardDetailView.swift
//  MyBank
//
//  Created by Nicolas RIVIERE on 18/02/2021.
//

import SwiftUI

struct CardDetailView: View {
    enum Modal: Int, Identifiable {
        case currentCard
        case higherCard

        var id: Int {
            self.rawValue
        }
    }

    @EnvironmentObject var transactionModel: TransactionModel
    @EnvironmentObject var cardModel: CardModel
    @State var presentCardView: Modal? = nil
    @Binding var showCardDetail: Bool
    let cardViewNameSpace: Namespace.ID
    @Binding var hasOrderedPhysicalCard: Bool
    @Binding var hasUpgradedCard: Bool

    var header: some View {
        HStack {
            Text("Card")
                .font(.system(size: 22, weight: .bold, design: .rounded))

            Spacer()
        }
        .padding(.horizontal)
    }

    var body: some View {
        ZStack {
            BackgroundView()
                .frame(maxWidth: .leastNonzeroMagnitude)
                .zIndex(0)
                .padding(.leading, -510)

            VStack {
                header

                HStack(spacing: 0) {
                    CardView(amount: transactionModel.balance)
                        .shadow(radius: 2)
                        .rotationEffect(.init(degrees: 90), anchor: .center)
                        .ignoresSafeArea(.all, edges: .leading)
                        .padding(.leading, -162)
                        .padding(.trailing, -50)
                        .onTapGesture {
                            withAnimation(.easeInOut) { showCardDetail = false }
                        }
                        .matchedGeometryEffect(
                            id: "CardView",
                            in: cardViewNameSpace,
                            properties: .frame,
                            anchor: .center,
                            isSource: true
                        )

                    CardDetailConfidentialView()
                        .environmentObject(cardModel)

                    Spacer()
                }
                .padding(.bottom, 50)
                .padding(.top, 35)

                settings
            }
            .fullScreenCover(item: $presentCardView) { modal in
                switch modal {
                case .currentCard:
                    CardOrderPhysicalView(
                        hasOrderedPhysicalCard: $hasOrderedPhysicalCard,
                        hasUpgradedCard: $hasUpgradedCard
                    )
                case .higherCard:
                    CardUpgradeView(
                        hasOrderedPhysicalCard: $hasOrderedPhysicalCard,
                        hasUpgradedCard: $hasUpgradedCard
                    )
                }
            }
            .navigationBarHidden(true)
        }
    }

    var settings: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                HStack {
                    Text("Settings")
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 24, bottom: 16, trailing: 0))

                CardSettingEntryView(title: "Apple Pay", subTitle: "Manage from the Apple Wallet", handler: {})
                SeparatorView()

                if !hasOrderedPhysicalCard {
                    CardSettingEntryView(title: "Get physical", subTitle: "Order a physical card", handler: { presentCardView = .currentCard })
                    SeparatorView()
                }

                if !hasUpgradedCard {
                    CardSettingEntryView(title: "Upgrade", subTitle: "Go to the higher level", handler: { presentCardView = .higherCard })
                    SeparatorView()
                }
            }
        }
    }
}

struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                CardDetailView(
                    showCardDetail: .constant(true),
                    cardViewNameSpace: Namespace().wrappedValue,
                    hasOrderedPhysicalCard: .constant(false),
                    hasUpgradedCard: .constant(false)
                )
                .environmentObject(TransactionModel())
                .environmentObject(CardModel())
            }

            NavigationView {
                CardDetailView(
                    showCardDetail: .constant(true),
                    cardViewNameSpace: Namespace().wrappedValue,
                    hasOrderedPhysicalCard: .constant(false),
                    hasUpgradedCard: .constant(false)
                )
                .environmentObject(TransactionModel())
                .environmentObject(CardModel())
            }
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        }
    }
}
