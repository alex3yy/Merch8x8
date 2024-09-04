//
//  ProductPresentationUnitTests.swift
//  Merch8x8UnitTests
//
//  Created by Alex Zaharia on 04.09.2024.
//

import XCTest

@testable import Merch8x8

final class ProductPresentationUnitTests: XCTestCase {

    private var sut: ProductsListViewModel.ProductPresentation!

    private let product = Product(
        id: 1,
        title: "Product title",
        price: .init(value: 10.99, currencyCode: "EUR", locale: Locale(identifier: "en_US")),
        category: "Some category",
        description: "A brief description.",
        imageUrlString: "https://example.com/image.jpg"
    )

    override func setUp() {
        super.setUp()
        sut = ProductsListViewModel.ProductPresentation(product: product)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    // MARK: - init(product:)
    func test_init_withProductId_setsId() {
        XCTAssertEqual(sut.id, 1)
    }

    func test_init_withProductTitle_setsTitle() {
        XCTAssertEqual(sut.title, "Product title")
    }

    func test_init_withProductPrice_setsPriceDescription() {
        XCTAssertEqual(sut.price, "€10.99")
    }

    func test_init_withProductCategory_setsCategory() {
        XCTAssertEqual(sut.category, "Some category")
    }

    func test_init_withProductDescription_setsDescription() {
        XCTAssertEqual(sut.description, "A brief description.")
    }

    func test_init_withProductImageUrlString_setsUrl() {
        XCTAssertEqual(sut.imageUrl, URL(string: "https://example.com/image.jpg"))
    }
}
