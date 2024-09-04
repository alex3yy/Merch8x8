//
//  Product.swift
//  Merch8x8
//
//  Created by Alex Zaharia on 04.09.2024.
//

import Foundation

struct Product {
    let id: Int
    let title: String
    let price: Price
    let category: String
}

extension Product {
    struct Price {
        let value: Double
        let currencyCode: String
    }
}
