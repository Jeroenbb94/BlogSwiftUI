//
//  HomeControllerSpy.swift
//  PresentationTests
//
//  Created by Jeroen Bakker on 26/06/2019.
//  Copyright © 2019 Bakker. All rights reserved.
//

@testable import Presentation

final class HomeControllerSpy: HomeControllerProtocol {
    private(set) var invokedDisplayBlogPostsCount = 0
    private(set) var invokedDisplayErrorCount = 0
    
    func displayBlogPosts(blogPosts: [BlogPostRowViewModel]) {
        invokedDisplayBlogPostsCount += 1
    }
    
    func displayError(message: String) {
        invokedDisplayErrorCount += 1
    }
}
