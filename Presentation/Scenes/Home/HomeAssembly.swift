//
//  HomeAssembly.swift
//  Presentation
//
//  Created by Jeroen Bakker on 25/06/2019.
//  Copyright © 2019 Bakker. All rights reserved.
//

import Domain
import Swinject

public struct HomeAssembly: Assembly {
    
    public init() { }
    
    public func assemble(container: Container) {
        container.register(HomeView.self) { resolver in
            return HomeView(
                interactor: resolver.resolve(HomeInteractorProtocol.self)!,
                presenter: resolver.resolve(HomePresenterProtocol.self)!,
                dataSource: DataSource()
            )
        }
        
        container.register(HomeInteractorProtocol.self) { resolver in
            return HomeInteractor(
                getBlogsWorker: resolver.resolve(GetBlogsWorker.self)!
            )
        }.initCompleted { (resolver, interactor) in
            interactor.attach(presenter: resolver.resolve(HomePresenterProtocol.self)!)
        }
        
        container.register(HomePresenterProtocol.self) { resolver in
            return HomePresenter(
                displayThreadQueue: .main
            )
        }.initCompleted { (resolver, presenter) in
            presenter.attach(view: resolver.resolve(HomeView.self)!)
        }
    }
}
