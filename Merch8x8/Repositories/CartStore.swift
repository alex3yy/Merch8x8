//
//  CartStore.swift
//  Merch8x8
//
//  Created by Alex Zaharia on 05.09.2024.
//

import Foundation

struct CartStore {

    private let storageService: StorageServiceProtocol
    private let productsService: ProductsServiceProtocol

    init(storageService: StorageServiceProtocol, productsService: ProductsServiceProtocol) {
        self.storageService = storageService
        self.productsService = productsService
    }

    func addProductUnit(productId: Int) {
        if let cartItem = cartItem(id: productId) {
            cartItem.units += 1
        } else {
            storageService.add { context in
                let cart = Cart(context: context)
                cart.productId = Int64(productId)
                cart.units += 1
            }
        }
        storageService.save()
    }

    func deleteProduct(productId: Int) {
        if let cartItem = cartItem(id: productId) {
            storageService.delete(item: cartItem)
        }
    }

    func deleteProductUnit(productId: Int) {
        if let cartItem = cartItem(id: productId) {
            if cartItem.units > 1 {
                cartItem.units -= 1
                storageService.save()
            } else {
                storageService.delete(item: cartItem)
            }
        }
    }

    // MARK: - Private methods
    private func cartItem(id: Int) -> Cart? {
        let predicate = NSPredicate(format: "productId = \(id)")
        let cartItem = storageService.item(ofType: Cart.self, predicate: predicate)
        return cartItem
    }
}
