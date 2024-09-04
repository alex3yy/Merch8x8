//
//  MockProductsService.swift
//  Merch8x8UnitTests
//
//  Created by Alex Zaharia on 04.09.2024.
//

import Foundation

@testable import Merch8x8

final class MockProductsService: ProductsServiceProtocol {

    private var result: Result<[Product], Error>?

    func products() async throws -> [Product] {
        guard let result else {
            fatalError("No mock value provided.")
        }

        switch result {
        case .success(let products):
            return products
        case .failure(let error):
            throw error
        }
    }

    // MARK: - Mock
    func mockFailure() {
        result = .failure(ProductsServiceError())
    }

    func mockSuccess(products: [Product] = []) {
        result = .success(products)
    }
}
