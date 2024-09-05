//
//  ContentView.swift
//  Merch8x8
//
//  Created by Alex Zaharia on 04.09.2024.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var productListViewModel: ProductsListViewModel

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
                    ProductsListView(products: products)
                }
            }
            .navigationTitle("Shop")
        }
        .task {
            await productListViewModel.handleOnAppearAction()
        }
    }
}

#Preview {
    let productsService = ProductsService(urlSession: .shared)
    let productListViewModel = ProductsListViewModel(productsService: productsService)

    return ContentView(productListViewModel: productListViewModel)
}
