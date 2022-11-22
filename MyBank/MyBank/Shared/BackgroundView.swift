//
//  BackgroundView.swift
//  MyBank
//
//  Created by Nicolas RIVIERE on 18/02/2021.
//

import SwiftUI

struct BackgroundView: View {

    var body: some View {
        VStack(spacing: nil) {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                Rectangle()
                    .foregroundColor(Color(hex: 0x618DA1))
                    .cornerRadius(59)
                    .frame(width: 600, height: 200)
                    .padding(.leading, 80)
                    .padding(.top, -195)
                    .rotationEffect(.init(degrees: 20), anchor: .top)
                    .zIndex(2)

                Rectangle()
                    .foregroundColor(Color(hex: 0x2bc1e8))
                    .cornerRadius(81)
                    .frame(width: 400, height: 200)
                    .padding(.leading, -230)
                    .padding(.top, -75)
                    .rotationEffect(.init(degrees: 20), anchor: .top)
                    .zIndex(1)

                Rectangle()
                    .foregroundColor(Color(hex: 0x4c5156))
                    .cornerRadius(11)
                    .frame(width: 65, height: 65)
                    .padding(.leading, 410)
                    .padding(.top, -30)
                    .rotationEffect(.init(degrees: 20), anchor: .top)
                    .zIndex(3)

                Rectangle()
                    .foregroundColor(Color(hex: 0x2bc1e8))
                    .cornerRadius(81)
                    .frame(width: 400, height: 350)
                    .padding(.leading, 730)
                    .padding(.top, 30)
                    .rotationEffect(.init(degrees: 20), anchor: .top)
                    .zIndex(0)

                Rectangle()
                    .foregroundColor(Color(hex: 0x56d9e9))
                    .cornerRadius(51)
                    .frame(width: 400, height: 180)
                    .padding(.leading, 520)
                    .padding(.top, 230)
                    .rotationEffect(.init(degrees: 20), anchor: .top)
                    .zIndex(1)
            }

            Spacer()
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BackgroundView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 12"))

            BackgroundView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        }
    }
}
