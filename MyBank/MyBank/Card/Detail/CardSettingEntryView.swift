//
//  CardSettingEntryView.swift
//  MyBank
//
//  Created by Nicolas RIVIERE on 22/02/2021.
//

import SwiftUI

struct CardSettingEntryView: View {
    let title: String
    let subTitle: String
    let handler: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 15, weight: .medium, design: .default))
                    .foregroundColor(Color(hex: 0x37454a))
                Text(subTitle)
                    .font(.system(size: 10, weight: .regular, design: .default))
                    .foregroundColor(Color(hex: 0x37454a))
                    .lineLimit(1)
            }

            Spacer()

            Image(systemName: "chevron.right")
        }
        .padding(EdgeInsets(top: 8, leading: 24, bottom: 8, trailing: 16))
        .onTapGesture {
            handler()
        }
    }
}

struct CardSettingEntryView_Previews: PreviewProvider {
    static var previews: some View {
        CardSettingEntryView(title: "EntryTitle", subTitle: "Entry subtitle\ne", handler: {})
            .previewLayout(.fixed(width: 375, height: 52))
    }
}
