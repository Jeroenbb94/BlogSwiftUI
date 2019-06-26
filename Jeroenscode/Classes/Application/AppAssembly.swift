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
        // App Assembly
        container.register(TabbarView.self) { resolver in
            TabbarView(homeView: resolver.resolve(HomeView.self)!)
        }.inObjectScope(.container)
        
        // Service Assembly
        container.register(GetBlogsWorker.self) { resolver in
            GetBlogsService(manager: SessionManager.default)
        }

        // Home Assembly
        container.register(HomeView.self) { resolver in
            HomeView(controller: resolver.resolve(HomeController.self)!)
        }
        
        container.register(HomeController.self) { resolver in
            HomeController(
                interactor: resolver.resolve(HomeInteractorProtocol.self)!,
                presenter: resolver.resolve(HomePresenterProtocol.self)!
            )
        }
        
        container.register(HomeInteractorProtocol.self) { resolver in
            HomeInteractor(
                getBlogsWorker: resolver.resolve(GetBlogsWorker.self)!
            )
        }.initCompleted { (resolver, interactor) in
            interactor.attach(presenter: resolver.resolve(HomePresenterProtocol.self)!)
        }
        
        container.register(HomePresenterProtocol.self) { resolver in
            HomePresenter(
                displayThreadQueue: .main
            )
        }.initCompleted { (resolver, presenter) in
            presenter.attach(view: resolver.resolve(HomeController.self)!)
        }
    }
}
