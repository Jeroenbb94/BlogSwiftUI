//
//  WPPost.swift
//  Data
//
//  Created by Jeroen Bakker on 25/06/2019.
//  Copyright © 2019 Bakker. All rights reserved.
//

import Foundation

public struct WPPost: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id, date, title, content, categories, excerpt
        case featuredMedia = "featured_media"
    }
    
    public let id: Int
    public let date: String
    public let title: Content
    public let content: Content
    public let excerpt: Content
    public let featuredMedia: Int
    public let categories: [Int]
}

public extension WPPost {
    
    struct Content: Decodable {
        public let rendered: String
    }
}
