//
//  ServiceAssembly.swift
//  Data
//
//  Created by Jeroen Bakker on 25/06/2019.
//  Copyright © 2019 Bakker. All rights reserved.
//

import Domain
import Swinject
import Alamofire

public struct ServiceAssembly: Assembly {
    
    public init() { }
    
    public func assemble(container: Container) {
        container.register(GetBlogsWorker.self) { resolver in
            return GetBlogsService(manager: SessionManager.default)
        }
    }
}
