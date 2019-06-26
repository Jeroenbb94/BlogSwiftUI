//
//  GetBlogsService.swift
//  Jeroenscode
//
//  Created by Jeroen Bakker on 24/06/2019.
//  Copyright © 2019 Bakker. All rights reserved.
//

import Domain
import Alamofire

public struct GetBlogsService: GetBlogsServiceProtocol {
    
    private let manager: SessionManager
    
    public init(manager: SessionManager) {
        self.manager = manager
    }
    
    public func fetchBlogs(completionHandler: @escaping (Swift.Result<[BlogPost], GetBlogsServiceError>) -> Void) {
        manager.request("https://jeroenscode.com/wp-json/wp/v2/posts")
            .responseData { (dataResponse) in
                switch dataResponse.result {
                case .success(let data):
                    do {
                        let wpPosts = try JSONDecoder().decode([WPPost].self, from: data)
                        completionHandler(.success(self.mapDataToBlogPosts(data: wpPosts)))
                    } catch let error {
                        completionHandler(.failure(.decoding(error)))
                    }
                case .failure(let error):
                    completionHandler(.failure(.network(error)))
                }
            }
    }
    
    private func mapDataToBlogPosts(data: [WPPost]) -> [BlogPost] {
        return data.compactMap { (post) -> BlogPost? in
            return BlogPost(
                id: post.id,
                date: post.date,
                title: post.title.rendered,
                content: post.content.rendered,
                excerpt: post.excerpt.rendered
            )
        }
    }
}
