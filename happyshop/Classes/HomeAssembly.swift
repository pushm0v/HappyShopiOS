//
//  ShopAssembly.swift
//  happyshop
//
//  Created by Bherly Novrandy on 2/8/17.
//  Copyright © 2017 Bherly Novrandy. All rights reserved.
//

import Foundation
import Swinject

class HomeAssembly: Assembly {
    func assemble(container: Container) {
        container.register(HomeModule.self){(r, appRouter: IAppRouter)  in
            return HomeModule(router: appRouter)
        }
        
        container.register(IHomeWireframe.self){(r, appRouter: IAppRouter) -> IHomeWireframe in
            return HomeWireframe(router: appRouter)
        }
        
        container.register(HomeNavigation.self) { r in
            return HomeNavigation()
        }
        
        setupAssembleHome(container: container)
    }
    
    func setupAssembleHome(container: Container) {
        
        container.register(IHomePresenter.self) { (r, appRouter: IAppRouter, view: IHomeView) in
            let wireframe = r.resolve(IHomeWireframe.self, argument: appRouter)!
            let service = r.resolve(IShopService.self)!
            let presenter = HomePresenter(view: view, wireframe: wireframe, service: service)
            
            return presenter
        }

        container.register(HomeViewController.self) { (r, appRouter: IAppRouter) in
            let view = HomeViewController()
            let presenter = r.resolve(IHomePresenter.self, arguments: appRouter, view as IHomeView)!
            view.presenter = presenter
            return view
        }
    }
}
