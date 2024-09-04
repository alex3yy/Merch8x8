//
//  MockURLProtocol.swift
//  Merch8x8UnitTests
//
//  Created by Alex Zaharia on 04.09.2024.
//

import Foundation

final class MockURLProtocol: URLProtocol {

    private(set) static var urlRequest: URLRequest?

    private typealias Success = MockURLResponse
    private typealias Failure = URLError

    private static var response: Result<Success, Failure>? = nil

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        urlRequest = request
        return request
    }

    override func startLoading() {
        guard let response = MockURLProtocol.response else {
            fatalError("No value found! Assign a value to the response by using static mock() method")
        }

        switch response {
        case .success(let response):
            client?.urlProtocol(self, didReceive: response.urlResponse, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: response.data)
            client?.urlProtocolDidFinishLoading(self)
        case .failure(let error):
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() {
        return
    }

    // MARK: - Mock
    class func mock(error: URLError) {
        validateMock()

        self.response = .failure(error)
    }

    class func mock(httpStatusCode: Int) {
        validateMock()

        let httpUrlResponse = HTTPURLResponse(
            url: URL(string: "a_url")!,
            statusCode: httpStatusCode,
            httpVersion: nil,
            headerFields: nil
        )!
        self.response = .success(MockURLResponse(urlResponse: httpUrlResponse, data: Data()))
    }

    class func mockSuccessWithCustomHttpUrlResponse() {
        validateMock()

        let customUrlResponse = CustomURLResponse(
            url: URL(string: "a_url")!,
            mimeType: nil,
            expectedContentLength: 0,
            textEncodingName: nil
        )
        self.response = .success(MockURLResponse(urlResponse: customUrlResponse, data: Data()))
    }

    class func reset() {
        urlRequest = nil
        response = nil
    }

    private class func validateMock() {
        guard response == nil,
              urlRequest == nil
        else {
            fatalError("Please reset values using reset() method after each rest.")
        }
    }
}

fileprivate struct MockURLResponse {
    let urlResponse: URLResponse
    let data: Data
}

fileprivate class CustomURLResponse: URLResponse {
    override init(url URL: URL, mimeType MIMEType: String?, expectedContentLength length: Int, textEncodingName name: String?) {
        super.init(url: URL, mimeType: MIMEType, expectedContentLength: length, textEncodingName: name)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
