//
//  Merch8x8App.swift
//  Merch8x8
//
//  Created by Alex Zaharia on 04.09.2024.
//

import SwiftUI

@main
struct Merch8x8App: App {
    
    @StateObject private var productListViewModel: ProductsListViewModel

    init() {
        let productsService = ProductsService(urlSession: .shared)
        let productListViewModel = ProductsListViewModel(productsService: productsService)
        _productListViewModel = StateObject(wrappedValue: productListViewModel)
    }

    var body: some Scene {
        WindowGroup {
            ContentView(
                productListViewModel: productListViewModel
            )
        }
    }
}
