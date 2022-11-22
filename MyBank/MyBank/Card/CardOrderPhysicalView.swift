//
//  CardOrderPhysicalView.swift
//  MyBank
//
//  Created by Nicolas RIVIERE on 30/04/2021.
//

import SwiftUI

struct CardOrderPhysicalView: View {
    @Environment(\.presentationMode) var presentationMode

    @State var deliveryAddress: String = "80 Quai Voltaire"
    @State var city: String = "95870 Bezons"
    @State var country: String = "France"

    @State var isLoading = false

    @Binding var hasOrderedPhysicalCard: Bool
    @Binding var hasUpgradedCard: Bool

    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                    .scaleEffect(0.6)
                    .frame(maxWidth: .leastNonzeroMagnitude)
                    .zIndex(0)
                    .padding(.leading, -360)

                VStack(spacing: 0) {
                    HStack(alignment: .center) {
                        Text("Order your physical card")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .padding(.leading)

                        Button("Cancel", action: {
                            presentationMode.wrappedValue.dismiss()
                        })
                        .padding(.trailing)

                    }
                    .padding(.bottom, 8)

                    VStack(alignment: .leading) {
                        CardSmallSceneKitView(cardType: hasUpgradedCard ? .gold: .cocoa)
                            .frame(height: 180)
                            .background(Color.white)
                            .padding(.vertical)

                        Text("Address")
                            .padding(.horizontal)
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                            .foregroundColor(Color(hex: 0x37454a))

                        TextField("Street, number, building", text: $deliveryAddress)
                            .padding(.horizontal)
                            .font(.system(size: 15, weight: .semibold, design: .default))
                            .foregroundColor(Color(hex: 0x181818))

                        Text("City")
                            .padding(.horizontal)
                            .padding(.top, 8)
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                            .foregroundColor(Color(hex: 0x37454a))

                        TextField("Postal code, city", text: $city)
                            .padding(.horizontal)
                            .font(.system(size: 15, weight: .semibold, design: .default))
                            .foregroundColor(Color(hex: 0x181818))

                        Text("Country")
                            .padding(.horizontal)
                            .padding(.top, 8)
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                            .foregroundColor(Color(hex: 0x37454a))

                        TextField("Country", text: $country)
                            .padding(.horizontal)
                            .font(.system(size: 15, weight: .semibold, design: .default))
                            .foregroundColor(Color(hex: 0x181818))

                        Text("Shipping within 7 working days. Shipping costs are offered.")
                            .font(.system(size: 13, weight: .regular, design: .rounded))
                            .foregroundColor(Color(hex: 0x37454a))
                            .padding(.horizontal)
                            .padding(.vertical, 16)

                        HStack {
                            Spacer()

                            Button(action: { orderCardAndDismiss() }, label: {
                                Image(systemName: "paperplane")
                                    .foregroundColor(Color(hex: 0x38454a, opacity: isLoading ? 0.2 : 1))
                                Text("Order")
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
                            .disabled(isLoading)
                            .animation(.default, value: isLoading)

                            Spacer()
                        }
                    }
                    .padding(.vertical)

                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
    }

    private func orderCardAndDismiss() {
        isLoading = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            isLoading = false
            hasOrderedPhysicalCard = true
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct CardOrderPhysicalView_Previews: PreviewProvider {
    static var previews: some View {
        CardOrderPhysicalView(hasOrderedPhysicalCard: .constant(false), hasUpgradedCard: .constant(false))
    }
}
