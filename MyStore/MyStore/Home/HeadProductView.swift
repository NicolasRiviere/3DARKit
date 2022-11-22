//
//  HeadProductView.swift
//  MyStore
//
//  Created by Nicolas RIVIERE on 16/07/2021.
//

import SwiftUI

struct HeadProductView: View {
    let product: Product
    @State var pushDetail = false

    var body: some View {
        ZStack(alignment: .topLeading) {
            Image(product.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(idealHeight: 230, maxHeight: 230)

            Text(product.title)
                .font(.subheadline)
                .lineLimit(2)
                .padding(4)
                .padding(.horizontal, 2)
                .background(Color(hex: 0xFFFFFF))
                .cornerRadius(4)
                .padding(.leading, 11)
                .padding(.top, 8)

            NavigationLink(
                destination: ProductDetailView(product: product),
                isActive: $pushDetail,
                label: { EmptyView() }
            )
        }
        .frame(height: 230)
        .onTapGesture {
            pushDetail = true
        }
    }
}

struct HeadProductView_Previews: PreviewProvider {
    static var previews: some View {
        HeadProductView(product: .sample)
            .previewLayout(.fixed(width: 375, height: 230))
    }
}
