//
//  TransactionVIew.swift
//  MyBank
//
//  Created by Nicolas RIVIERE on 15/02/2021.
//

import SwiftUI

struct TransactionView: View {
    let transaction: Transaction

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(transaction.title)
                    .font(.system(size: 15, weight: .medium, design: .default))
                    .foregroundColor(Color(hex: 0x37454a))
                Text(transaction.date.textual)
                    .font(.system(size: 10, weight: .regular, design: .default))
                    .foregroundColor(Color(hex: 0x37454a))
            }

            Spacer()

            Text(transaction.amount.textual)
                .font(.system(size: 15, weight: .medium, design: .default))
                .foregroundColor(transaction.amount > 0 ? .green : Color(hex: 0x37454a))
        }
        .padding(EdgeInsets(top: 8, leading: 24, bottom: 8, trailing: 24))
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView(transaction: Transaction.samples().first!)
            .previewLayout(.fixed(width: 375, height: 52))
    }
}
