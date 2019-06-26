//
//  HomePresenterSpy.swift
//  PresentationTests
//
//  Created by Jeroen Bakker on 26/06/2019.
//  Copyright © 2019 Bakker. All rights reserved.
//

@testable import Presentation
@testable import Domain

final class HomePresenterSpy: HomePresenterProtocol {
    private(set) var invokedPresentBlogPostCount = 0
    
    func presentBlogPost(response: Result<[BlogPost], GetBlogsServiceError>) {
        invokedPresentBlogPostCount += 1
    }
    
    // Unused
    var controller: HomeControllerProtocol?
    func attach(controller: HomeControllerProtocol) { }
}
