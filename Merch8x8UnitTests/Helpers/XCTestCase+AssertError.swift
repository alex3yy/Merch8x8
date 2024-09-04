//
//  XCTestCase+AssertError.swift
//  Merch8x8UnitTests
//
//  Created by Alex Zaharia on 04.09.2024.
//

import XCTest

extension XCTestCase {
    func assertError<T, E: Error>(
        _ expression: @autoclosure () throws -> T,
        throws error: E.Type,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        var thrownError: Error?

        XCTAssertThrowsError(try expression(), file: file, line: line) { error in
            thrownError = error
        }

        guard let thrownError else { return }

        XCTAssertTrue(
            thrownError is E,
            "Unexpected error type: \(type(of: thrownError))",
            file: file, line: line
        )
    }
}
