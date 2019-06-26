//
//  HomeController.swift
//  Presentation
//
//  Created by Jeroen Bakker on 26/06/2019.
//  Copyright © 2019 Bakker. All rights reserved.
//

import SwiftUI
import Combine

public protocol HomeViewDisplayProtocol {
    func displayBlogPosts(blogPosts: [BlogPostRowViewModel])
    func displayError(message: String)
}

public final class HomeController: BindableObject {
    
    private let presenter: HomePresenterProtocol
    
    public let interactor: HomeInteractorProtocol
    public let didChange = PassthroughSubject<Void, Never>()
    
    public private(set) var blogPosts: [BlogPostRowViewModel] = []
    public private(set) var errorMessage: String?
    
    public init(interactor: HomeInteractorProtocol, presenter: HomePresenterProtocol) {
        self.interactor = interactor
        self.presenter = presenter
    }
}

// MARK: - HomeViewDisplayProtocol
extension HomeController: HomeViewDisplayProtocol {
    
    public func displayBlogPosts(blogPosts: [BlogPostRowViewModel]) {
        self.blogPosts = blogPosts
        
        didChange.send()
    }
    
    public func displayError(message: String) {
        self.errorMessage = message
        
        didChange.send()
    }
}
