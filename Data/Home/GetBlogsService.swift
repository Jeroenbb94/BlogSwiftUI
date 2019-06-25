//
//  GetBlogsService.swift
//  Jeroenscode
//
//  Created by Jeroen Bakker on 24/06/2019.
//  Copyright © 2019 Bakker. All rights reserved.
//

import Domain
import Alamofire

public struct GetBlogsService: GetBlogsWorker {
    
    private let manager: SessionManager
    
    public init(manager: SessionManager = SessionManager.default) {
        self.manager = manager
    }
    
    public func fetchBlogs(completionHandler: @escaping (Swift.Result<[BlogPost], GetBlogsWorkerError>) -> Void) {
        manager.request("https://jeroenscode.com/wp-json/wp/v2/posts")
            .responseData { (dataResponse) in
                switch dataResponse.result {
                case .success(let data):
                    do {
                        let blogPosts = try JSONDecoder().decode([BlogPost].self, from: data)
                        completionHandler(.success(blogPosts))
                    } catch let error {
                        completionHandler(.failure(.decoding(error)))
                    }
                case .failure(let error):
                    completionHandler(.failure(.network(error)))
                }
            }
    }
}
