//
//  HomePresenter.swift
//  Jeroenscode
//
//  Created by Jeroen Bakker on 24/06/2019.
//  Copyright © 2019 Bakker. All rights reserved.
//

import UIKit

public protocol HomePresenterProtocol {
    func presentBlogPost(response: Int)
    func presentError()
}

public struct HomePresenter {
    
    private let displayThreadQueue: DispatchQueue
    private let view: HomeViewDisplayProtocol?
    
    public init(view: HomeViewDisplayProtocol, displayThreadQueue: DispatchQueue = .main) {
        self.view = view
        self.displayThreadQueue = displayThreadQueue
    }
}

// MARK: - HomePresenterProtocol
extension HomePresenter: HomePresenterProtocol {
    
    public func presentBlogPost(response: Int) {
        displayThreadQueue.async {
            self.view?.displayBlogPosts()
        }
    }
    
    public func presentError() {
        displayThreadQueue.async {
            self.view?.displayError()
        }
    }
}
