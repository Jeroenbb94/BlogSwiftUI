//
//  HomePresenter.swift
//  Jeroenscode
//
//  Created by Jeroen Bakker on 24/06/2019.
//  Copyright © 2019 Bakker. All rights reserved.
//

import UIKit

public protocol HomePresenterProtocol {
    var view: HomeViewDisplayProtocol? { get set }
    func attach(view: HomeViewDisplayProtocol)
    
    func presentBlogPost(response: Int)
    func presentError()
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
