//
//  Product.swift
//  Merch8x8
//
//  Created by Alex Zaharia on 04.09.2024.
//

import Foundation

struct Product: Equatable {
    let id: Int
    let title: String
    let price: Price
    let category: String
    let description: String
    let imageUrlString: String
}

extension Product {
    struct Price: Equatable {
        let value: Double
        let currencyCode: String
    }
}
