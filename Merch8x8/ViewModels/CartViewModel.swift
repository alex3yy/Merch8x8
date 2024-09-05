//
//  CartViewModel.swift
//  Merch8x8
//
//  Created by Alex Zaharia on 05.09.2024.
//

import Foundation

struct CartViewModel {

    let cartStore: CartStore

    func handleDecrementUnitAction(productId: Int) {
        cartStore.deleteProductUnit(productId: productId)
    }

    func handleIncrementUnitAction(productId: Int) {
        cartStore.addProductUnit(productId: productId)
    }
}
