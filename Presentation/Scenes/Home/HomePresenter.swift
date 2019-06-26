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
    var view: HomeViewDisplayProtocol? { get set }
    func attach(view: HomeViewDisplayProtocol)
    
    func presentBlogPost(response: Result<[BlogPost], GetBlogsWorkerError>)
}

public final class HomePresenter {
    
    private let displayThreadQueue: DispatchQueue
    public var view: HomeViewDisplayProtocol?
    
    public init(displayThreadQueue: DispatchQueue = .main) {
        self.displayThreadQueue = displayThreadQueue
    }
    
    public func attach(view: HomeViewDisplayProtocol) {
        self.view = view
    }
}

// MARK: - HomePresenterProtocol
extension HomePresenter: HomePresenterProtocol {
    
    public func presentBlogPost(response: Result<[BlogPost], GetBlogsWorkerError>) {
        switch response {
        case .success(let blogPosts):
            let viewModels = blogPosts.map { (blogPost) -> BlogPostRowViewModel in
                BlogPostRowViewModel(id: blogPost.id, title: blogPost.title, date: blogPost.date)
            }
            displayThreadQueue.async {
                self.view?.displayBlogPosts(blogPosts: viewModels)
            }
        case .failure(let error):
            displayThreadQueue.async {
                self.view?.displayError(message: error.localizedDescription)
            }
        }
    }
}
