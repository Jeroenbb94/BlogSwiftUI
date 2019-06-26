//
//  HomeInteractorTest.swift
//  Jeroenscode
//
//  Created by Jeroen Bakker on 26/06/2019.
//  Copyright (c) 2019 Bakker. All rights reserved.
//

import XCTest
@testable import Presentation

final class HomeInteractorTest: XCTestCase {

    private var sut: HomeInteractor!
    private var getBlogsServiceSpy: GetBlogsServiceSpy!
    private var presenterSpy: HomePresenterSpy!
    
    override func setUp() {
        super.setUp()
        
        // Get the model for thetest
        getBlogsServiceSpy = GetBlogsServiceSpy()
        presenterSpy = HomePresenterSpy()
        
        sut = HomeInteractor(getBlogsWorker: getBlogsServiceSpy)
        sut.attach(presenter: presenterSpy)
    }
    
    override func tearDown() {
        super.tearDown()
        
        getBlogsServiceSpy = nil
        presenterSpy = nil
        sut = nil
    }
}

// MARK: - Tests
extension HomeInteractorTest {

    func test_fetchBlogs_onBlogsServiceSuccess_shouldInvokePresentBlogPosts() {
        // given
        getBlogsServiceSpy.stubbedFetchBlogsResult = .success([])
        
        // when
        sut.fetchBlogs()
        
        // then
        XCTAssertEqual(1, presenterSpy.invokedPresentBlogPostCount, "fetchBlogs() should invoke presentBlogPost")
    }
    
    func test_fetchBlogs_onBlogsServiceFailure_shouldInvokePresentBlogPosts() {
        // given
        getBlogsServiceSpy.stubbedFetchBlogsResult = .failure(.noResponse)
        
        // when
        sut.fetchBlogs()
        
        // then
        XCTAssertEqual(1, presenterSpy.invokedPresentBlogPostCount, "fetchBlogs() should invoke presentBlogPost")
    }
}
