//
//  ProductsServiceDTOParser.swift
//  Merch8x8
//
//  Created by Alex Zaharia on 04.09.2024.
//

import Foundation

struct ProductsServiceDTOParser {
    func parse(dtos: [ProductDTO]) -> [Product] {
        dtos.map(parse(dto:))
    }

    func parse(dto: ProductDTO) -> Product {
        Product(
            id: dto.id,
            title: dto.title,
            price: .init(value: dto.price, currencyCode: "EUR"),
            category: dto.category,
            description: dto.description,
            imageUrlString: dto.image
        )
    }
}
