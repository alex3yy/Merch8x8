//
//  ProductsServiceProtocol.swift
//  Merch8x8
//
//  Created by Alex Zaharia on 04.09.2024.
//

import Foundation

protocol ProductsServiceProtocol {
    func products() async throws -> [Product]
}
