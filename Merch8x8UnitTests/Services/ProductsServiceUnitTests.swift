//
//  ProductsServiceUnitTests.swift
//  Merch8x8UnitTests
//
//  Created by Alex Zaharia on 04.09.2024.
//

import XCTest

@testable import Merch8x8

final class ProductsServiceUnitTests: XCTestCase {

    private var sut: ProductsService!

    override func setUp() {
        super.setUp()
        sut = ProductsService(urlSession: .mocked)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        MockURLProtocol.reset()
    }

    // MARK: - products()
    func test_products_hasProductsServiceError_throwsError() async {
        MockURLProtocol.mock(error: .init(.badURL))

        await assertAsyncError(try await sut.products(), throws: ProductsServiceError.self)
    }

    func test_products_requestWithUrl_checkUrlEquality() async {
        MockURLProtocol.mock(error: .init(.badURL))

        _ = try? await sut.products()

        let expectedURL = URL(string: "https://fakestoreapi.com/products")
        XCTAssertEqual(expectedURL, MockURLProtocol.urlRequest?.url)
    }
}
