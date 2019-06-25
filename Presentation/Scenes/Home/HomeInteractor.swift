//
//  HomeInteractor.swift
//  Jeroenscode
//
//  Created by Jeroen Bakker on 24/06/2019.
//  Copyright © 2019 Bakker. All rights reserved.
//

import Domain

public protocol HomeInteractorProtocol {
    var presenter: HomePresenterProtocol? { get set }
    
    func fetchBlogs()
    func attach(presenter: HomePresenterProtocol)
}

public final class HomeInteractor {
    
    private let getBlogsWorker: GetBlogsWorker
    private var blogPosts: [BlogPost] = []
    
    public var presenter: HomePresenterProtocol?
    public init(getBlogsWorker: GetBlogsWorker) {
        self.getBlogsWorker = getBlogsWorker
    }
    
    public func attach(presenter: HomePresenterProtocol) {
        self.presenter = presenter
    }
}

// MARK: - HomeInteractorProtocol
extension HomeInteractor: HomeInteractorProtocol {
    
    public func fetchBlogs() {
        getBlogsWorker.fetchBlogs { [weak self] (result) in
            switch result {
            case .success(let blogPosts):
                self?.blogPosts = blogPosts
                self?.presenter?.presentBlogPost(response: 0)
            case .failure:
                self?.presenter?.presentError()
            }
        }
    }
}
