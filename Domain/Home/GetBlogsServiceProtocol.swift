//
//  GetBlogsServiceProtocol.swift
//  Jeroenscode
//
//  Created by Jeroen Bakker on 24/06/2019.
//  Copyright © 2019 Bakker. All rights reserved.
//

import Foundation

public protocol GetBlogsServiceProtocol {
    func fetchBlogs(completionHandler: @escaping (Result<[BlogPost], GetBlogsServiceError>) -> Void)
}

public enum GetBlogsServiceError: Error {
    case noResponse
    case network(Error)
    case decoding(Error)
}

public struct BlogPost {
    public let id: Int
    public let date: String
    public let title: String
    public let content: String
    public let excerpt: String
    
    public init(id: Int, date: String, title: String, content: String, excerpt: String) {
        self.id = id
        self.date = date
        self.title = title
        self.content = content
        self.excerpt = excerpt
    }
}
