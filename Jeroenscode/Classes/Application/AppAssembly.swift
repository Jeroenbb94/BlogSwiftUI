//
//  AppAssembly.swift
//  Jeroenscode
//
//  Created by Jeroen Bakker on 25/06/2019.
//  Copyright © 2019 Bakker. All rights reserved.
//

import Swinject
import Presentation
import Data
import Domain
import Alamofire

struct AppAssembly {
    
//    private let assemblies: [Assembly] = [
//        ServiceAssembly(),
//        Presentation.HomeAssembly()
//    ]
//    private lazy var assembler = Assembler(container: container)
    let container: Container = Container()
    
    init() {
//        assembler.apply(assemblies: assemblies)
        container.register(GetBlogsWorker.self) { resolver in
            return GetBlogsService(manager: SessionManager.default)
        }

        container.register(HomeView.self) { resolver in
            return HomeView(
                interactor: resolver.resolve(HomeInteractorProtocol.self)!,
                presenter: resolver.resolve(HomePresenterProtocol.self)!
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
