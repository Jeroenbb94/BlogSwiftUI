//
//  GetBlogsServiceSpy.swift
//  PresentationTests
//
//  Created by Jeroen Bakker on 26/06/2019.
//  Copyright © 2019 Bakker. All rights reserved.
//

@testable import Domain

final class GetBlogsServiceSpy: GetBlogsServiceProtocol {
    private(set) var invokedFetchBlogsCount: Int = 0
    var stubbedFetchBlogsResult: Result<[BlogPost], GetBlogsServiceError>!
    
    func fetchBlogs(completionHandler: @escaping (Result<[BlogPost], GetBlogsServiceError>) -> Void) {
        invokedFetchBlogsCount += 1
        completionHandler(stubbedFetchBlogsResult)
    }
}
