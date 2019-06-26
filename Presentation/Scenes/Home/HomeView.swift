//
//  HomeView.swift
//  Jeroenscode
//
//  Created by Jeroen Bakker on 24/06/2019.
//  Copyright © 2019 Bakker. All rights reserved.
//

import SwiftUI
import Combine

public protocol HomeViewDisplayProtocol {
    func displayBlogPosts(blogPosts: [BlogPostRowViewModel])
    func displayError(message: String)
}

public final class DataSource: BindableObject {
    public let didChange = PassthroughSubject<DataSource, Never>()
    
    public init() { }
    
    public var blogPosts: [BlogPostRowViewModel] = [] {
        didSet {
            didChange.send(self)
        }
    }
}

public struct HomeView: View {
    
    private let interactor: HomeInteractorProtocol
    private let presenter: HomePresenterProtocol
    
    @ObjectBinding var dataSource: DataSource
    
    public init(interactor: HomeInteractorProtocol, presenter: HomePresenterProtocol, dataSource: DataSource) {
        self.interactor = interactor
        self.presenter = presenter
        self.dataSource = dataSource
    }
    
    public var body: some View {
        Group {
            if dataSource.blogPosts.isEmpty {
                Text("Loading.....")
            } else {
                NavigationView {
                    List(dataSource.blogPosts, rowContent: BlogPostRow.init)
                        .navigationBarTitle(Text("Blog posts"))
                }
            }
        }.onAppear {
            self.interactor.fetchBlogs()
        }
    }
}

// MARK: - HomeViewDisplayProtocol
extension HomeView: HomeViewDisplayProtocol {
    
    public func displayBlogPosts(blogPosts: [BlogPostRowViewModel]) {
        dataSource.blogPosts = blogPosts
    }
    
    public func displayError(message: String) {
        #warning("TODO - Add error view logic")
    }
}
