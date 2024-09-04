//
//  URLResponse+Validation.swift
//  Merch8x8
//
//  Created by Alex Zaharia on 04.09.2024.
//

import Foundation

extension URLResponse {
    func validateAsSuccessfulHTTPURLResponse() throws {
        guard let httpResponse = self as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode)
        else {
            throw URLError(.badServerResponse)
        }
    }
}
