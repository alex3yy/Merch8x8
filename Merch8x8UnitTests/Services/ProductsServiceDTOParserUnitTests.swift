//
//  ProductsServiceDTOParserUnitTests.swift
//  Merch8x8UnitTests
//
//  Created by Alex Zaharia on 04.09.2024.
//

import XCTest

@testable import Merch8x8

final class ProductsServiceDTOParserUnitTests: XCTestCase {

    private var sut: ProductsServiceDTOParser!

    private let dto = ProductDTO(id: 1, title: "Product title", price: 10.99, category: "Some category", description: "A brief description.", image: "https://example.com/image.jpg")

    override func setUp() {
        super.setUp()
        sut = ProductsServiceDTOParser()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    // MARK: - parse(dto:)
    func test_parse_dtoId_setsProductWithId() {
        let product = sut.parse(dto: dto)

        XCTAssertEqual(1, product.id)
    }

    func test_parse_dtoTitle_setsProductWithTitle() {
        let product = sut.parse(dto: dto)

        XCTAssertEqual("Product title", product.title)
    }

    func test_parse_dtoPrice_setsProductWithPrice() {
        let product = sut.parse(dto: dto)

        XCTAssertEqual(10.99, product.price.value)
        XCTAssertEqual("EUR", product.price.currencyCode)
    }

    func test_parse_dtoCategory_setsProductWithCategory() {
        let product = sut.parse(dto: dto)

        XCTAssertEqual("Some category", product.category)
    }

    func test_parse_dtoDescription_setsProductWithDescription() {
        let product = sut.parse(dto: dto)

        XCTAssertEqual("A brief description.", product.description)
    }

    func test_parse_dtoImage_setsProductWithImageUrlString() {
        let product = sut.parse(dto: dto)

        XCTAssertEqual("https://example.com/image.jpg", product.imageUrlString)
    }

    // MARK: - parse(dtos:)
    func test_parse_emptyArrayOfDtos_setsEmptyArrayOfProducts() {
        let products = sut.parse(dtos: [])

        XCTAssertEqual([], products)
    }

    func test_parse_arrayOfDtos_setsArrayOfProducts() {
        let products = sut.parse(dtos: [dto])

        let expectedResult = [
            Product(id: 1, title: "Product title", price: .init(value: 10.99, currencyCode: "EUR"), category: "Some category", description: "A brief description.", imageUrlString: "https://example.com/image.jpg")
        ]
        XCTAssertEqual(expectedResult, products)
    }
}
