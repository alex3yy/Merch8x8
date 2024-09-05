//
//  ProductDetailViewModel.swift
//  Merch8x8
//
//  Created by Alex Zaharia on 05.09.2024.
//

import Foundation

struct ProductDetailViewModel {

    let cartStore: CartStore

    func handleAddToCartAction(productId: Int) {
        cartStore.addProductUnit(productId: productId)
    }
}
