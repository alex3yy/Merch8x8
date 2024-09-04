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
        sut = ProductsService()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    // MARK: - products()
    func test_products_hasProductsServiceError_throwsError() {
        assertError(try sut.products(), throws: ProductsServiceError.self)
    }
}
