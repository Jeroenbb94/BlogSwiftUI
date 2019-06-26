//
//  GetBlogsServiceTest.swift
//  Jeroenscode
//
//  Created by Jeroen Bakker on 26/06/2019.
//  Copyright (c) 2019 Bakker. All rights reserved.
//

import XCTest
@testable import Data
@testable import Alamofire

final class GetBlogsServiceTest: XCTestCase {

    private let manager: SessionManager = {
        let configuration: URLSessionConfiguration = {
            let configuration = URLSessionConfiguration.default
            configuration.protocolClasses = [URLProtocolMock.self]
            return configuration
        }()
        
        return SessionManager(configuration: configuration)
    }()
    private var sut: GetBlogsService!
    
    override func setUp() {
        super.setUp()
                
        sut = GetBlogsService(manager: manager)
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
    }
}

// MARK: - Tests
extension GetBlogsServiceTest {

    func test_getBlogs_onValidJSON_shouldReturnSuccess() {
        // given
        let validJSON = """
        [{
            "id": 226,
            "date": "2019-06-25T12:00:07",
            "title": {
                "rendered": "Title"
            },
            "content": {
                "rendered": "Content",
            },
            "excerpt": {
                "rendered": "Excerpt",
            },
            "featured_media": 224,
            "categories": [
                27
            ]
        }]
        """
        URLProtocolMock.responseType = .data(validJSON.data(using: .utf8)!)
        let expectation = XCTestExpectation(description: "Perform a request")
        
        // when
        sut.fetchBlogs { (result) in
            switch result {
            case .success:
                break
            case .failure:
                XCTFail("Expected request to fail")
            }
            
            expectation.fulfill()
        }
        
        // then
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_getBlogs_onInvalidJSON_shouldReturnDecodingError() {
        // given
        let invalidJSON = "[{}]"
        URLProtocolMock.responseType = .data(invalidJSON.data(using: .utf8)!)
        let expectation = XCTestExpectation(description: "Perform a request")
        
        // when
        sut.fetchBlogs { (result) in
            switch result {
            case .success:
                XCTFail("Expected request to succeed")
            case .failure(let error):
                if case .decoding = error { } else {
                    XCTFail("Expected error to be decoding")
                }
            }
            
            expectation.fulfill()
        }
        
        // then
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_getBlogs_onError_shouldReturnNetworkError() {
        // given
        URLProtocolMock.responseType = .error(URLProtocolMock.MockError.none)
        let expectation = XCTestExpectation(description: "Perform a request")
        
        // when
        sut.fetchBlogs { (result) in
            // then
            switch result {
            case .success:
                XCTFail("Expected request to succeed")
            case .failure(let error):
                if case .network = error { } else {
                    XCTFail("Expected error to be network")
                }
            }
            
            expectation.fulfill()
        }
        
        // then
        wait(for: [expectation], timeout: 0.1)
    }
}
