//
//  ProductsListViewModelUnitTests.swift
//  Merch8x8UnitTests
//
//  Created by Alex Zaharia on 04.09.2024.
//

import XCTest

@testable import Merch8x8

@MainActor
final class ProductsListViewModelUnitTests: XCTestCase {

    private var sut: ProductsListViewModel!
    private var productsService: MockProductsService!

    override func setUp() {
        super.setUp()
        productsService = MockProductsService()
        sut = ProductsListViewModel(productsService: productsService)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    // MARK: - loadContent()
    func test_loadContent_requestFails_setsErrorState() async {
        productsService.mockFailure()
        await sut.loadContent()

        XCTAssertEqual(sut.contentState, .error)
    }

    func test_loadContent_requestSucceedsWithEmptyArray_setsEmptyState() async {
        productsService.mockSuccess(products: [])
        await sut.loadContent()

        XCTAssertEqual(sut.contentState, .empty)
    }

    func test_loadContent_requestSucceedsWithOneItemInArray_setsProductsStateWithArray() async {
        let mockProduct = Product(id: 1, title: "", price: .init(value: 10, currencyCode: "EUR"), category: "", description: "", imageUrlString: "")
        productsService.mockSuccess(products: [mockProduct])
        await sut.loadContent()

        XCTAssertEqual(sut.contentState.productsPresentations?.count, 1)
    }

    func test_loadContent_retryRequestAfterFailure_setsLoadingState() async {
        let collector = PublisherValueCollector(publisher: sut.$contentState)
        productsService.mockFailure()
        await sut.loadContent()

        await sut.loadContent()

        XCTAssertEqual(collector.values.suffix(3), [.error, .loading, .error])
    }

    // MARK: - contentState
    func test_contentState_initialized_setsLoadingState() {
        XCTAssertEqual(sut.contentState, .loading)
    }
}

extension ProductsListViewModel.ContentState {
    var productsPresentations: [ProductsListViewModel.ProductPresentation]? {
        if case let .products(products) = self {
            return products
        }
        return nil
    }
}
