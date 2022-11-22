//
//  CardDetailConfidentialView.swift
//  MyBank
//
//  Created by Nicolas RIVIERE on 22/02/2021.
//

import SwiftUI

struct CardDetailConfidentialView: View {
    @State var showConfidentialData = false
    @EnvironmentObject var cardModel: CardModel

    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("Card number".uppercased())
                    .font(.system(size: 13, weight: .regular, design: .rounded))
                    .foregroundColor(Color(hex: 0x37454a))
                    .padding(.bottom, 4)
                HStack {
                    Text(cardModel.userCard?.firstFourDigits ?? "")
                        .kerning(2)
                    ConfidentialText(cardModel.userCard?.secondFourDigits ?? "", isShown: $showConfidentialData)
                    ConfidentialText(cardModel.userCard?.thirdFourDigits ?? "", isShown: $showConfidentialData)
                    Text(cardModel.userCard?.lastFourDigits ?? "")
                        .kerning(2)
                }
                .font(.system(size: 15, weight: .semibold, design: .rounded))
                .foregroundColor(Color(hex: 0x181818))
                .padding(.bottom, 16)

                Text("Card holder".uppercased())
                    .font(.system(size: 13, weight: .regular, design: .rounded))
                    .foregroundColor(Color(hex: 0x37454a))
                    .padding(.bottom, 4)
                Text(cardModel.userCard?.holderCompleteName ?? "")
                    .font(.system(size: 15, weight: .semibold, design: .default))
                    .foregroundColor(Color(hex: 0x181818))
                    .padding(.bottom, 16)
            }
            .padding(.leading, 8)

            HStack {
                VStack(alignment: .leading) {
                    Text("Expiry date".uppercased())
                        .font(.system(size: 13, weight: .regular, design: .rounded))
                        .foregroundColor(Color(hex: 0x37454a))
                        .padding(.bottom, 4)
                    Text(cardModel.userCard?.expirationDateFormattedString ?? "")
                        .font(.system(size: 15, weight: .semibold, design: .default))
                        .foregroundColor(Color(hex: 0x181818))
                }

                Spacer()

                VStack(alignment: .leading) {
                    Text("CVV")
                        .font(.system(size: 13, weight: .regular, design: .rounded))
                        .foregroundColor(Color(hex: 0x37454a))
                        .padding(.bottom, 4)

                    ConfidentialText(cardModel.userCard?.cardValidationValue ?? "", isShown: $showConfidentialData)
                        .font(.system(size: 15, weight: .semibold, design: .default))
                        .foregroundColor(Color(hex: 0x181818))
                }

                Spacer()
                Spacer()
            }
            .padding(.leading, 8)
            .padding(.bottom, 16)

            HStack {
                Button(action: { showConfidentialData = !showConfidentialData }, label: {
                    Image(systemName: showConfidentialData ? "eye.slash" : "eye")
                        .foregroundColor(Color(hex: 0x38454a))
                    Text("Card details")
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundColor(Color(hex: 0x38454a))
                })
                .padding(.all, 12)
                .background(Color(hex: 0xEBECEC))
                .cornerRadius(10)

                Button(action: {}, label: {
                    Image(systemName: "lock")
                        .foregroundColor(Color(hex: 0x38454a))
                    Text("Lock Card")
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundColor(Color(hex: 0x38454a))
                })
                .padding(.all, 12)
                .background(Color(hex: 0xEBECEC))
                .cornerRadius(10)
            }
        }
        .padding(.leading, 10)
        .onAppear {
            cardModel.fetchCardData()
        }
    }
}

struct CardDetailConfidentialView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardDetailConfidentialView()
                .environmentObject(CardModel())
            CardDetailConfidentialView(showConfidentialData: true)
                .environmentObject(CardModel())
        }
        .previewLayout(.fixed(width: 290, height: 290))
    }
}
