//
//  HomeControllerTest.swift
//  Jeroenscode
//
//  Created by Jeroen Bakker on 26/06/2019.
//  Copyright (c) 2019 Bakker. All rights reserved.
//

import XCTest
@testable import Presentation

final class HomeControllerTest: XCTestCase {

    private var sut: HomeController!
    private var interactorSpy: HomeInteractorSpy!
    private var presenterSpy: HomePresenterSpy!
    
    override func setUp() {
        super.setUp()
        
        // Get the model for thetest
        interactorSpy = HomeInteractorSpy()
        presenterSpy = HomePresenterSpy()
        sut = HomeController(interactor: interactorSpy, presenter: presenterSpy)
    }
    
    override func tearDown() {
        super.tearDown()
        
        interactorSpy = nil
        presenterSpy = nil
        sut = nil
    }
}

// MARK: - Tests
extension HomeControllerTest {

    func test_displayBlogPosts_onBlogPosts_shouldInvokeDidChange() {
        // given
        let input = BlogPostRowViewModel(id: 1, title: "title", date: "date")
        let expectation = XCTestExpectation(description: "Perform a didChange")
        _ = sut.didChange.sink { (invokedCount) in
            expectation.fulfill()
        }
        
        // when
        sut.displayBlogPosts(blogPosts: [input])
        
        // then
        wait(for: [expectation], timeout: 0.1)
        XCTAssertEqual([input], sut.blogPosts)
    }
    
    func test_displayError_onErrorMessage_shouldInvokeDidChange() {
        // given
        let input = "Error message"
        let expectation = XCTestExpectation(description: "Perform a didChange")
        _ = sut.didChange.sink { (invokedCount) in
            expectation.fulfill()
        }
        
        // when
        sut.displayError(message: input)
        
        // then
        wait(for: [expectation], timeout: 0.1)
        XCTAssertEqual(input, sut.errorMessage)
    }
}
