//
//  ProductView.swift
//  MyStore
//
//  Created by Nicolas RIVIERE on 30/06/2021.
//

import SwiftUI

struct ProductView: View {
    let product: Product
    @State var pushDetail = false

    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                Image(product.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(5)

                Text(product.title)
                    .font(.caption)
                    .lineLimit(2)
            }

            NavigationLink(
                destination: ProductDetailView(product: product),
                isActive: $pushDetail,
                label: { EmptyView() }
            )
        }
        .frame(width: 200, height: 150)
        .onTapGesture {
            pushDetail = true
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(product: .sample)
            .previewLayout(.fixed(width: 200, height: 200))
    }
}
