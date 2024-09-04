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

    func test_products_responseWithDifferentUrlResponseType_throwsError() async {
        MockURLProtocol.mockSuccessWithCustomHttpUrlResponse()

        await assertAsyncError(try await sut.products(), throws: ProductsServiceError.self)
    }

    func test_products_responseWithBadStatusCode_throwsError() async {
        MockURLProtocol.mock(httpStatusCode: 400)

        await assertAsyncError(try await sut.products(), throws: ProductsServiceError.self)
    }

    func test_products_dataDecodingFails_throwsError() async {
        MockURLProtocol.mock(httpStatusCode: 200)

        await assertAsyncError(try await sut.products(), throws: ProductsServiceError.self)
    }

    func test_products_decodesEmptyArrayOfDtos_returnsEmptyArrayOfProducts() async throws {
        let dtos: [ProductDTO] = []
        let data = try JSONEncoder().encode(dtos)
        MockURLProtocol.mock(httpStatusCode: 200, data: data)

        let products = try await sut.products()

        XCTAssertTrue(products.isEmpty)
    }

    func test_products_decodesArrayOfDtos_returnsArrayOfProducts() async throws {
        let dtos: [ProductDTO] = [
            ProductDTO(id: 1, title: "Product title", price: 10.99, category: "Some category", description: "A brief description.", image: "https://example.com/image.jpg")
        ]
        let data = try JSONEncoder().encode(dtos)
        MockURLProtocol.mock(httpStatusCode: 200, data: data)

        let products = try await sut.products()

        XCTAssertEqual(1, products.count)
    }
}
