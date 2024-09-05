//
//  CartView.swift
//  Merch8x8
//
//  Created by Alex Zaharia on 05.09.2024.
//

import SwiftUI

struct CartView: View {

    let cartViewModel: CartViewModel

    @FetchRequest(sortDescriptors: []) private var cartProducts: FetchedResults<Cart>

    var body: some View {
        if cartProducts.isEmpty {
            Text("No items in the cart yet.")
        } else {
            List(cartProducts) { cartProduct in
                HStack {
                    Text("Product ID: \(cartProduct.productId)")
                    Stepper {
                        Text("Unit(s): \(cartProduct.units)")
                    } onIncrement: {
                        addUnit(productId: Int(cartProduct.productId))
                    } onDecrement: {
                        removeUnit(productId: Int(cartProduct.productId))
                    }
                }
            }
        }
    }

    private func removeUnit(productId: Int) {
        cartViewModel.handleDecrementUnitAction(productId: productId)
    }

    private func addUnit(productId: Int) {
        cartViewModel.handleIncrementUnitAction(productId: productId)
    }
}

#Preview {
    let productsService = ProductsService(urlSession: .shared)
    let storageService = StorageService.shared
    let cartStore = CartStore(storageService: storageService, productsService: productsService)
    let cartViewModel = CartViewModel(cartStore: cartStore)

    return CartView(cartViewModel: cartViewModel)
}
