//
//  CardUpgradeView.swift
//  MyBank
//
//  Created by Nicolas RIVIERE on 07/06/2021.
//

import SwiftUI

struct CardUpgradeView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var isLoading = false
    @Binding var hasOrderedPhysicalCard: Bool
    @Binding var hasUpgradedCard: Bool
    @EnvironmentObject var cardModel: CardModel

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                BackgroundView()
                    .scaleEffect(0.6)
                    .frame(maxWidth: .leastNonzeroMagnitude)
                    .zIndex(0)
                    .padding(.leading, -360)

                VStack(spacing: 0) {
                    HStack(alignment: .center) {
                        Text("Upgrade your card")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .padding(.leading)

                        Button("Cancel", action: {
                            presentationMode.wrappedValue.dismiss()
                        })
                        .padding(.trailing)

                    }
                    .padding(.bottom, 24)

                    CardSmallSceneKitView(cardType: .gold)
                        .frame(height: 180)
                        .background(Color.white)
                        .padding(.vertical)

                    Text("Gold Card")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 22, weight: .regular))
                        .padding(.leading)
                        .padding(.bottom, 24)

                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 32) {
                            HStack(alignment: .center) {
                                Image(systemName: "creditcard")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 20)
                                    .padding(.trailing, 8)

                                Text("Gold card with immediate debit, deferred debit or credit")
                                    .font(.system(size: 15, weight: .medium, design: .default))

                                Spacer()
                            }

                            HStack(alignment: .center) {
                                Image(systemName: "giftcard")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 20)
                                    .padding(.trailing, 8)

                                Text("Tous les paiements par carte en France et à l'étranger sont gratuits")
                                    .font(.system(size: 15, weight: .medium, design: .default))

                                Spacer()
                            }

                            HStack(alignment: .center) {
                                Image(systemName: "cross.case")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 20)
                                    .padding(.trailing, 8)

                                Text("Assistance médicale et remboursement des frais médicaux à l'étranger")
                                    .font(.system(size: 15, weight: .medium, design: .default))

                                Spacer()
                            }

                            HStack(alignment: .center) {
                                Image(systemName: "car")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 20)
                                    .padding(.trailing, 8)

                                Text("Assurances voyage, garantie pour votre véhicule de location")
                                    .font(.system(size: 15, weight: .medium, design: .default))

                                Spacer()
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding([.bottom, .horizontal], 32)
                    }
                    .disabled(true)
                }

                Button(action: { upgradeCardAndDismiss() }, label: {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(Color(hex: 0x38454a, opacity: isLoading ? 0.2 : 1))
                    Text("Upgrade")
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundColor(Color(hex: 0x38454a, opacity: isLoading ? 0.2 : 1))
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding(.leading, 2)
                    }
                })
                .padding(.all, 12)
                .background(Color(hex: 0xEBECEC))
                .cornerRadius(10)
                .animation(.default, value: isLoading)
            }
            .navigationBarHidden(true)
        }
    }

    private func upgradeCardAndDismiss() {
        isLoading = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            isLoading = false
            hasUpgradedCard = true
            hasOrderedPhysicalCard = false
            cardModel.upgrade()
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct CardUpgradeView_Previews: PreviewProvider {
    static var previews: some View {
        CardUpgradeView(hasOrderedPhysicalCard: .constant(false), hasUpgradedCard: .constant(false))
    }
}
