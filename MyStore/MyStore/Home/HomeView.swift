//
//  HomeView.swift
//  MyStore
//
//  Created by Nicolas RIVIERE on 30/06/2021.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var productStore: ProductStore

    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                if let headProduct = productStore.headProduct {
                    Text("Focus on")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 15)
                        .padding(.top, 12)
                        .padding(.bottom, 8)
                        .background(Color(hex: 0xFAF2EF))

                    HeadProductView(product: headProduct)
                        .frame(height: 230)
                        .clipped()
                }

                Text(productStore.headCategory?.title ?? "")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 15)
                    .padding(.top, 12)
                    .padding(.bottom, 8)
                    .background(Color(hex: 0xFAF2EF))

                LazyVGrid(columns: columns) {
                    ForEach(productStore.headCategory?.products ?? []) {
                        ProductView(product: $0)
                            .frame(height: 150)
                    }
                }
                .padding(.vertical)
                .background(Color(hex: 0xFFFFFF))

                if productStore.personalSuggestions?.products.isEmpty == false {
                    categoryView
                }
            }
        }
        .onAppear {
            productStore.fetch()
        }
        .navigationTitle("Today Offers")
    }

    var categoryView: some View {
        VStack(alignment: .leading) {
            Text(productStore.personalSuggestions?.title ?? "")
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(productStore.personalSuggestions?.products ?? []) {
                        ProductView(product: $0)
                            .padding(.horizontal, 8)
                    }
                }
            }
            .padding(.horizontal, 8)
        }
        .frame(height: 185)
    }

    var categoryItem: some View {
        VStack(alignment: .leading) {
            Image(systemName: "star")
                .resizable()
                .frame(width: 120, height: 120)
                .cornerRadius(5)
            Text("landmark.name")
                .font(.caption)
        }
        .padding(.horizontal, 8)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .environmentObject(ProductStore.preview())
        }
    }
}
