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
    @StateObject private var storageService: StorageService
    private let cartViewModel: CartViewModel
    private let productDetailViewModel: ProductDetailViewModel

    init() {
        let productsService = ProductsService(urlSession: .shared)
        let storageService = StorageService.shared
        let cartStore = CartStore(storageService: storageService, productsService: productsService)
        let productListViewModel = ProductsListViewModel(productsService: productsService)

        _productListViewModel = StateObject(wrappedValue: productListViewModel)
        _storageService = StateObject(wrappedValue: storageService)
        cartViewModel = CartViewModel(cartStore: cartStore)
        productDetailViewModel = ProductDetailViewModel(cartStore: cartStore)
    }

    var body: some Scene {
        WindowGroup {
            ContentView(
                productListViewModel: productListViewModel,
                cartViewModel: cartViewModel,
                productDetailViewModel: productDetailViewModel
            )
            .environment(\.managedObjectContext,
                          storageService.persistentContainer.viewContext)
        }
    }
}
