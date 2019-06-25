//
//  HomeInteractor.swift
//  Jeroenscode
//
//  Created by Jeroen Bakker on 24/06/2019.
//  Copyright © 2019 Bakker. All rights reserved.
//

import Domain

public protocol HomeInteractorProtocol {
    func fetchBlogs()
}

public final class HomeInteractor {
    
    private let presenter: HomePresenterProtocol
    private let getBlogsWorker: GetBlogsWorker
    
    private var blogPosts: [BlogPost] = []
    
    public init(
        presenter: HomePresenterProtocol,
        getBlogsWorker: GetBlogsWorker
    ) {
        self.presenter = presenter
        self.getBlogsWorker = getBlogsWorker
    }
}

// MARK: - HomeInteractorProtocol
extension HomeInteractor: HomeInteractorProtocol {
    
    public func fetchBlogs() {
        getBlogsWorker.fetchBlogs { [weak self] (result) in
            switch result {
            case .success(let blogPosts):
                self?.blogPosts = blogPosts
                self?.presenter.presentBlogPost(response: 0)
            case .failure:
                self?.presenter.presentError()
            }
        }
    }
}
