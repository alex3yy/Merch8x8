//
//  ProductsListViewModel.swift
//  Merch8x8
//
//  Created by Alex Zaharia on 04.09.2024.
//

import Foundation

struct ProductsListViewModel {
    let contentState: ContentState = .loading
}

extension ProductsListViewModel {
    enum ContentState {
        case loading
    }
}
