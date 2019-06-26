//
//  HomeInteractorSpy.swift
//  PresentationTests
//
//  Created by Jeroen Bakker on 26/06/2019.
//  Copyright © 2019 Bakker. All rights reserved.
//

@testable import Presentation

final class HomeInteractorSpy: HomeInteractorProtocol {
    private(set) var invokedFetchBlogsCount = 0
    
    func fetchBlogs() {
        invokedFetchBlogsCount += 1
    }
    
    // Unused
    var presenter: HomePresenterProtocol?
    func attach(presenter: HomePresenterProtocol) { }
}
