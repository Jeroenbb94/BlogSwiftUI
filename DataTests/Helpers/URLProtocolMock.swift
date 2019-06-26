//
//  URLProtocolMock.swift
//  DataTests
//
//  Created by Jeroen Bakker on 26/06/2019.
//  Copyright © 2019 Bakker. All rights reserved.
//

import Foundation

final class URLProtocolMock: URLProtocol {
    
    enum ResponseType {
        case error(Error)
        case response(HTTPURLResponse)
        case data(Data)
    }
    static var responseType: ResponseType!
    
    private lazy var session: URLSession = {
        let configuration: URLSessionConfiguration = URLSessionConfiguration.ephemeral
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    private(set) var activeTask: URLSessionTask?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override class func requestIsCacheEquivalent(_ a: URLRequest, to b: URLRequest) -> Bool {
        return false
    }
    
    override func startLoading() {
        activeTask = session.dataTask(with: request.urlRequest!)
        activeTask?.cancel()
    }
    
    override func stopLoading() {
        activeTask?.cancel()
    }
}

// MARK: - URLSessionDataDelegate
extension URLProtocolMock: URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        client?.urlProtocol(self, didLoad: data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        switch URLProtocolMock.responseType {
        case .error(let error)?:
            client?.urlProtocol(self, didFailWithError: error)
        case .response(let response)?:
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        case .data(let data)?:
            client?.urlProtocol(self, didLoad: data)
        case .none:
            break
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }
}

// MARK: - Helper methods
extension URLProtocolMock {
    
    enum MockError: Error {
        case none
    }

    static func responseWithStatusCode(code: Int) {
        URLProtocolMock.responseType = .response(HTTPURLResponse(url: URL(string: "http://any.com")!, statusCode: code, httpVersion: nil, headerFields: nil)!)
    }
}
