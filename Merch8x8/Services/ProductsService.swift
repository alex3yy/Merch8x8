//
//  ProductsService.swift
//  Merch8x8
//
//  Created by Alex Zaharia on 04.09.2024.
//

import Foundation

struct ProductsService {
    
    private let urlSession: URLSession

    private let parser = ProductsServiceDTOParser()

    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    /// Fetches a list of products.
    func products() async throws -> [Product] {
        let url = URL(string: "https://fakestoreapi.com")!
            .appendingPathComponent("products")

        do {
            let (data, response) = try await urlSession.data(from: url)
            try response.validateAsSuccessfulHTTPURLResponse()
            let dtos = try JSONDecoder().decode([ProductDTO].self, from: data)
            let products = parser.parse(dtos: dtos)
            return products
        } catch {
            throw ProductsServiceError()
        }
    }
}
