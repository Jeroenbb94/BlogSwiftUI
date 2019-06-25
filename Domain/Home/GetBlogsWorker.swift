//
//  GetBlogsWorker.swift
//  Jeroenscode
//
//  Created by Jeroen Bakker on 24/06/2019.
//  Copyright © 2019 Bakker. All rights reserved.
//

import Foundation

public protocol GetBlogsWorker {
    func fetchBlogs(completionHandler: @escaping (Result<[BlogPost], GetBlogsWorkerError>) -> Void)
}

public enum GetBlogsWorkerError: Error {
    case noResponse
    case network(Error)
    case decoding(Error)
}

public struct BlogPost: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id, date, title, content, categories
        case featuredMedia = "featured_media"
    }
    
    public let id: Int
    public let date: String
    public let title: Content
    public let content: Content
    public let featuredMedia: Int
    public let categories: [Int]
}

public extension BlogPost {
    
    struct Content: Decodable {
        public let rendered: String
    }
}
