//
//  URLSession+Mocked.swift
//  Merch8x8UnitTests
//
//  Created by Alex Zaharia on 04.09.2024.
//

import Foundation

extension URLSession {
    static var mocked: URLSession {
        let configuration: URLSessionConfiguration = .ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]

        let urlSession = URLSession(configuration: configuration)
        return urlSession
    }
}
