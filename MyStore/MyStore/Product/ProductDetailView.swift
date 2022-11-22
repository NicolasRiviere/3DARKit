//
//  ProductDetailView.swift
//  MyStore
//
//  Created by Nicolas RIVIERE on 30/06/2021.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @State var presentSceneView: ProductSceneView.Mode? = nil
    @State var presentQLPreview = false

    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                Image(product.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 250)
                    .clipped()
                    .onLongPressGesture {
                        presentQLPreview = true
                    }

                if product.has3DModel {
                    HStack {
                        Button(action: { presentSceneView = .threeD }, label: {
                            Image(systemName: "view.3d")
                                .padding(.vertical)
                                .foregroundColor(.black)
                        })

                        Button(action: { presentSceneView = .ar }, label: {
                            Image(systemName: "arkit")
                                .padding()
                                .foregroundColor(.black)
                        })
                    }
                }
            }

            Text(product.description)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.body)
                .lineLimit(6)
                .padding()

            Spacer()

            ZStack(alignment: .center) {
                HStack(alignment: .top, spacing: 0) {
                    Text("\(Int(product.price))")
                        .font(.title3)
                    Text("\(Int((product.price * 100).truncatingRemainder(dividingBy: 100)))")
                        .font(.caption)
                    Text(" €")
                        .font(.title3)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(hex: 0xFAF2EF))

                HStack {
                    Spacer()
                    Button(action: {}, label: {
                        Image(systemName: "cart.badge.plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 25)
                            .foregroundColor(.black)
                    })
                    .padding(.trailing, 15)
                }
            }
        }
        .navigationTitle(product.title)
        .fullScreenCover(item: $presentSceneView) { mode in
            ProductSceneView(product: product, selectedMode: mode)
        }
        .fullScreenCover(isPresented: $presentQLPreview) {
            EmbededQLPreview()
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProductDetailView(product: .sample)
        }
    }
}
