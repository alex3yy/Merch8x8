//
//  ProductsListViewModel.swift
//  Merch8x8
//
//  Created by Alex Zaharia on 04.09.2024.
//

import Foundation

final class ProductsListViewModel {
    private(set) var contentState: ContentState = .loading

    private let productsService: ProductsServiceProtocol

    init(productsService: ProductsServiceProtocol) {
        self.productsService = productsService
    }

    func handleOnAppearAction() async {
        do {
            _ = try await productsService.products()
            contentState = .empty
        } catch {
            contentState = .error
        }
    }
}

extension ProductsListViewModel {
    enum ContentState {
        case loading
        case error
        case empty
    }
}
