//
//  ProductsService.swift
//  Merch8x8
//
//  Created by Alex Zaharia on 04.09.2024.
//

import Foundation

struct ProductsService {
    
    private let urlSession: URLSession

    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    func products() async throws {
        let url = URL(string: "https://fakestoreapi.com")!
            .appendingPathComponent("products")

        do {
            _ = try await urlSession.data(from: url)
        } catch {
            throw ProductsServiceError()
        }
    }
}
