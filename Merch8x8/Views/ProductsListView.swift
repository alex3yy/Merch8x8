//
//  ProductsListView.swift
//  Merch8x8
//
//  Created by Alex Zaharia on 04.09.2024.
//

import SwiftUI

struct ProductsListView: View {

    let products: [ProductsListViewModel.ProductPresentation]
    let productDetailViewModel: ProductDetailViewModel

    var body: some View {
        List(products) { product in
            NavigationLink {
                ProductDetailView(
                    product: product,
                    productSuggestions: Array(products.shuffled().prefix(5)),
                    productDetailViewModel: productDetailViewModel
                )
            } label: {
                ProductListRow(product: product)
                    .frame(height: 60)
            }
        }
    }
}

struct ProductListRow: View {

    let product: ProductsListViewModel.ProductPresentation

    var body: some View {
        HStack {
            AsyncImage(url: product.imageUrl) { image in
                image
                    .resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: 60, height: 60)
            VStack(alignment: .leading) {
                Text(product.title)
                    .fontWeight(.semibold)
                    .font(.callout)
                Spacer()
            }
            Spacer(minLength: 6)
            Text(product.price)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    let products: [ProductsListViewModel.ProductPresentation] = [
        .init(id: 1, title: "Adidas F10", price: "10.99$", category: "Shoes", description: "Some nice shoes.", imageUrl: nil)
    ]
    let productsService = ProductsService(urlSession: .shared)
    let storageService = StorageService.shared
    let cartStore = CartStore(storageService: storageService, productsService: productsService)
    let productDetailViewModel = ProductDetailViewModel(cartStore: cartStore)

    return ProductsListView(products: products, productDetailViewModel: productDetailViewModel)
}
