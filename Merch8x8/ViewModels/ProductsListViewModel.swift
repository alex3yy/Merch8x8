//
//  ProductsListViewModel.swift
//  Merch8x8
//
//  Created by Alex Zaharia on 04.09.2024.
//

import Foundation

final class ProductsListViewModel {
    private(set) var contentState: ContentState = .loading

    func handleOnAppearAction() {
        contentState = .error
    }
}

extension ProductsListViewModel {
    enum ContentState {
        case loading
        case error
    }
}
