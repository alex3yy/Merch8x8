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
            let products = try await productsService.products()
            let presentations = products.map(ProductPresentation.init)
            contentState = presentations.isEmpty ? .empty : .products(presentations)
        } catch {
            contentState = .error
        }
    }
}

extension ProductsListViewModel {
    enum ContentState: Equatable {
        case loading
        case error
        case empty
        case products(_ products: [ProductPresentation])
    }
}

extension ProductsListViewModel {
    struct ProductPresentation: Equatable {
    }
}

extension ProductsListViewModel.ProductPresentation {
    init(product: Product) {
    }
}
