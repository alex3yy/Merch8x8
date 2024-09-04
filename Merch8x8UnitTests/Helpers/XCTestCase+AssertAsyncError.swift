//
//  XCTestCase+AssertAsyncError.swift
//  Merch8x8UnitTests
//
//  Created by Alex Zaharia on 04.09.2024.
//

import XCTest

extension XCTestCase {
    func assertAsyncError<T, E: Error>(
        _ expression: @autoclosure () async throws -> T,
        throws error: E.Type,
        in file: StaticString = #filePath,
        line: UInt = #line
    ) async {
        do {
            _ = try await expression()
            XCTFail("No errors were thrown.",
                    file: file, line: line
            )
        } catch(let thrownError) {
            XCTAssertTrue(
                thrownError is E,
                "Unexpected error type: \(type(of: error))",
                file: file, line: line
            )
        }
    }
}
