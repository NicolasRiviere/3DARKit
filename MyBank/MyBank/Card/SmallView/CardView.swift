//
//  CardView.swift
//  MyBank
//
//  Created by Nicolas RIVIERE on 16/02/2021.
//

import SwiftUI

struct CardView: View {
    let amount: Amount
    @EnvironmentObject var cardModel: CardModel

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Balance")
                        .font(.system(size: 17, weight: .light, design: .default))

                    Text(amount.textual)
                        .font(.system(size: 28, weight: .semibold, design: .rounded))
                }

                Spacer()

//                    Image(systemName: "circle")
//                        .resizable()
//                        .frame(width: 66, height: 20)
            }

            Spacer()

            Text(cardModel.userCard?.firstFourDigits ?? "")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .kerning(2)
                + Text(" ●●●● ")
                .font(.system(size: 11, weight: .semibold, design: .rounded))
                .kerning(2)
                + Text(" ●●●● ")
                .font(.system(size: 11, weight: .semibold, design: .rounded))
                .kerning(2)
                + Text(cardModel.userCard?.lastFourDigits ?? "")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .kerning(2)
        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 32, trailing: 20))
        .frame(width: 295, height: 185)
        .background(BlurView(style: .extraLight))
        .cornerRadius(23)
        .shadow(radius: 4)
        .onAppear {
            cardModel.fetchCardData()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(amount: 1250.0)
            .environmentObject(CardModel())
            .previewLayout(.fixed(width: 310, height: 200))
    }
}
