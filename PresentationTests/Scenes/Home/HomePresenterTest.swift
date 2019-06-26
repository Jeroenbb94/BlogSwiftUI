//
//  HomePresenterTest.swift
//  Jeroenscode
//
//  Created by Jeroen Bakker on 26/06/2019.
//  Copyright (c) 2019 Bakker. All rights reserved.
//

import XCTest
@testable import Presentation
@testable import Domain

final class HomePresenterTest: XCTestCase {
    
    private var sut: HomePresenter!
    private var controllerSpy: HomeControllerSpy!
    
    override func setUp() {
        super.setUp()
        
        // Get the model for thetest
        controllerSpy = HomeControllerSpy()
        
        sut = HomePresenter()
        sut.attach(controller: controllerSpy)
    }
    
    override func tearDown() {
        super.tearDown()
        
        controllerSpy = nil
        sut = nil
    }
}

// MARK: - Tests
extension HomePresenterTest {
    
    func test_presentBlogPost_onSuccess_shouldInvokeDisplayBlogPosts() {
        // given
        let blogPost = BlogPost(id: 1, date: "date", title: "title", content: "content", excerpt: "excerpt")
        let input: Result<[BlogPost], GetBlogsServiceError> = .success([blogPost])
        
        // when
        sut.presentBlogPost(response: input)
        
        // then
        XCTAssertEqual(1, controllerSpy.invokedDisplayBlogPostsCount, "presentBlogPost(response:) should invoke displayBlogPosts")
    }
    
    func test_presentBlogPost_onFailure_shouldInvokeDisplayError() {
        // given
        let input: Result<[BlogPost], GetBlogsServiceError> = .failure(.noResponse)
        
        // when
        sut.presentBlogPost(response: input)
        
        // then
        XCTAssertEqual(1, controllerSpy.invokedDisplayErrorCount, "presentBlogPost(response:) should invoke displayBlogPosts")
    }
}

