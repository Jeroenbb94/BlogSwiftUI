//
//  HomePresenter.swift
//  Jeroenscode
//
//  Created by Jeroen Bakker on 24/06/2019.
//  Copyright © 2019 Bakker. All rights reserved.
//

import UIKit
import Domain

public protocol HomePresenterProtocol {
    var controller: HomeControllerProtocol? { get set }
    func attach(controller: HomeControllerProtocol)
    
    func presentBlogPost(response: Result<[BlogPost], GetBlogsServiceError>)
}

public final class HomePresenter {
    
    public var controller: HomeControllerProtocol?
    
    public init() { }
    
    public func attach(controller: HomeControllerProtocol) {
        self.controller = controller
    }
}

// MARK: - HomePresenterProtocol
extension HomePresenter: HomePresenterProtocol {
    
    public func presentBlogPost(response: Result<[BlogPost], GetBlogsServiceError>) {
        switch response {
        case .success(let blogPosts):
            let viewModels = blogPosts.map { (blogPost) -> BlogPostRowViewModel in
                BlogPostRowViewModel(id: blogPost.id, title: blogPost.title, date: blogPost.date)
            }
            controller?.displayBlogPosts(blogPosts: viewModels)
        case .failure(let error):
            controller?.displayError(message: error.localizedDescription)
        }
    }
}
