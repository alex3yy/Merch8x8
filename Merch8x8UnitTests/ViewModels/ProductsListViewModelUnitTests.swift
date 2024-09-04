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

    override func setUp() {
        super.setUp()
        sut = ProductsListViewModel()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    // MARK: - contentState
    func test_contentState_initialized_setsLoadingState() {
        XCTAssertEqual(sut.contentState, .loading)
    }
}
