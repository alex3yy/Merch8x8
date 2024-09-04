//
//  ProductDTO.swift
//  Merch8x8
//
//  Created by Alex Zaharia on 04.09.2024.
//

import Foundation

struct ProductDTO: Decodable {
    let id: Int
    let title: String
    let price: Double
    let category: String
    let description: String
    let image: String
}
