//
//  ProductDetailView.swift
//  Merch8x8
//
//  Created by Alex Zaharia on 05.09.2024.
//

import SwiftUI

struct ProductDetailView: View {

    let product: ProductsListViewModel.ProductPresentation
    let productSuggestions: [ProductsListViewModel.ProductPresentation]
    let productDetailViewModel: ProductDetailViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                AsyncImage(url: product.imageUrl) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Color.gray
                }
                .frame(maxWidth: .infinity)
                .frame(height: 250)

                Text(product.title)
                    .fontWeight(.semibold)
                    .font(.title2)

                Text(product.description)
                    .padding(.bottom, 20)

                if !productSuggestions.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Other suggestions")
                            .fontWeight(.semibold)
                            .font(.title3)
                        ForEach(productSuggestions) { product in
                            NavigationLink {
                                ProductDetailView(product: product, productSuggestions: [], productDetailViewModel: productDetailViewModel)
                            } label: {
                                ProductListRow(product: product)
                                    .contentShape(Rectangle())
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            Button {
                productDetailViewModel.handleAddToCartAction(productId: product.id)
            } label: {
                Text("Add to Cart")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(BorderedProminentButtonStyle())
            .padding(.horizontal)
        }
    }
}

#Preview {
    let product: ProductsListViewModel.ProductPresentation =
        .init(id: 1, title: "Adidas F10", price: "10.99$", category: "Shoes", description: "Some nice shoes.", imageUrl: nil)
    let productSugesstions: [ProductsListViewModel.ProductPresentation] =
        [
            .init(id: 1, title: "Adidas F11", price: "10.99$", category: "Shoes", description: "Some nice shoes.", imageUrl: nil),
            .init(id: 4, title: "Adidas F14", price: "14.99$", category: "Shoes", description: "Some nice shoes.", imageUrl: nil),
            .init(id: 10, title: "Adidas F100", price: "16.99$", category: "Shoes", description: "Some nice shoes.", imageUrl: nil),
            .init(id: 2, title: "Adidas F12", price: "20.99$", category: "Shoes", description: "Some nice shoes.", imageUrl: nil),
            .init(id: 8, title: "Adidas F18", price: "100.99$", category: "Shoes", description: "Some nice shoes.", imageUrl: nil),
        ]
    let productsService = ProductsService(urlSession: .shared)
    let storageService = StorageService.shared
    let cartStore = CartStore(storageService: storageService, productsService: productsService)
    let productDetailViewModel = ProductDetailViewModel(cartStore: cartStore)

    return NavigationView {
        ProductDetailView(
            product: product,
            productSuggestions: productSugesstions,
            productDetailViewModel: productDetailViewModel
        )
    }
}
