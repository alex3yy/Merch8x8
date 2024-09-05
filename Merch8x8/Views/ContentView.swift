//
//  ContentView.swift
//  Merch8x8
//
//  Created by Alex Zaharia on 04.09.2024.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var productListViewModel: ProductsListViewModel
    let cartViewModel: CartViewModel
    let productDetailViewModel: ProductDetailViewModel

    @State private var isCartPresented: Bool = false

    var body: some View {
        NavigationView {
            Group {
                switch productListViewModel.contentState {
                case .loading:
                    ProgressView()
                case .error:
                    Text("An error occurred. Please try again.")
                case .empty:
                    Text("There are no products yet.")
                case .products(let products):
                    ProductsListView(products: products, productDetailViewModel: productDetailViewModel)
                }
            }
            .navigationTitle("Shop")
            .sheet(isPresented: $isCartPresented) {
                CartView(cartViewModel: cartViewModel)
            }
            .toolbar {
                ToolbarItem {
                    Button("Cart") {
                        isCartPresented = true
                    }
                }
            }
        }
        .task {
            await productListViewModel.handleOnAppearAction()
        }
    }
}

#Preview {
    let productsService = ProductsService(urlSession: .shared)
    let storageService = StorageService.shared
    let cartStore = CartStore(storageService: storageService, productsService: productsService)
    let productListViewModel = ProductsListViewModel(productsService: productsService)
    let cartViewModel = CartViewModel(cartStore: cartStore)
    let productDetailViewModel = ProductDetailViewModel(cartStore: cartStore)

    return ContentView(
        productListViewModel: productListViewModel,
        cartViewModel: cartViewModel,
        productDetailViewModel: productDetailViewModel
    )
}
