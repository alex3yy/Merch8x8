//
//  ProductsListViewModelUnitTests.swift
//  Merch8x8UnitTests
//
//  Created by Alex Zaharia on 04.09.2024.
//

import XCTest

@testable import Merch8x8

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

    // MARK: - handleOnAppearAction()
    func test_handleOnAppearAction_requestFails_setsErrorState() async {
        productsService.mockFailure()
        await sut.handleOnAppearAction()

        XCTAssertEqual(sut.contentState, .error)
    }

    func test_handleOnAppearAction_requestSucceedsWithEmptyArray_setsEmptyState() async {
        productsService.mockSuccess(products: [])
        await sut.handleOnAppearAction()

        XCTAssertEqual(sut.contentState, .empty)
    }

    // MARK: - contentState
    func test_contentState_initialized_setsLoadingState() {
        XCTAssertEqual(sut.contentState, .loading)
    }
}
