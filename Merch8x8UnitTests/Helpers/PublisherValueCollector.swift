//
//  PublisherValueCollector.swift
//  Merch8x8UnitTests
//
//  Created by Alex Zaharia on 04.09.2024.
//

import Foundation
import Combine

final class PublisherValueCollector<Output, Failure> {

    private(set) var values: [Output] = []
    private var cancellables: [AnyCancellable] = []

    init(publisher: some Publisher<Output, Failure>) {
        publisher.sink(
            receiveCompletion: { _ in },
            receiveValue: { [weak self] newValue in
                self?.values.append(newValue)
            }
        )
        .store(in: &cancellables)
    }
}
