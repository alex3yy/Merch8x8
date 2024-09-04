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
            let (_, response) = try await urlSession.data(from: url)
            guard let _ = response as? HTTPURLResponse else {
                throw ProductsServiceError()
            }
        } catch {
            throw ProductsServiceError()
        }
    }
}
