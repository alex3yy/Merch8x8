//
//  ProductsListViewModel.swift
//  Merch8x8
//
//  Created by Alex Zaharia on 04.09.2024.
//

import Foundation

@MainActor
final class ProductsListViewModel: ObservableObject {
    @Published private(set) var contentState: ContentState = .loading

    private let productsService: ProductsServiceProtocol

    init(productsService: ProductsServiceProtocol) {
        self.productsService = productsService
    }

    func handleOnAppearAction() async {
        contentState = .loading
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
    struct ProductPresentation: Identifiable, Equatable {
        let id: Int
        let title: String
        let price: String
        let category: String
        let description: String
        let imageUrl: URL?
    }
}

extension ProductsListViewModel.ProductPresentation {
    init(product: Product) {
        self.id = product.id
        self.title = product.title
        self.price = product.price.description
        self.category = product.category
        self.description = product.description
        self.imageUrl = URL(string: product.imageUrlString)
    }
}
