//
//  ItemsAssembly.swift
//  happyshop
//
//  Created by Bherly Novrandy on 2/13/17.
//  Copyright © 2017 Bherly Novrandy. All rights reserved.
//

import Foundation
import Swinject

class ItemsAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ItemsModule.self){(r, appRouter: IAppRouter)  in
            return ItemsModule(router: appRouter)
        }
        
        container.register(IItemsListWireframe.self){(r, appRouter: IAppRouter) -> IItemsListWireframe in
            return ItemsListWireframe(router: appRouter)
        }
        
        container.register(IItemsDetailWireframe.self){(r, appRouter: IAppRouter) -> IItemsDetailWireframe in
            return ItemsDetailWireframe(router: appRouter)
        }
        
        container.register(ItemsNavigation.self) { r in
            return ItemsNavigation()
        }
        
        setupAssembleItemsList(container: container)
        setupAssembleItemsDetail(container: container)
    }
    
    func setupAssembleItemsList(container: Container) {
        
        container.register(IItemsListInterceptor.self) { r in
            let service = r.resolve(IShopService.self)!
            let dataManager = r.resolve(IShopDataManager.self)!
            let interceptor = ItemsListInterceptor(service: service, dataManager: dataManager)
            
            return interceptor
        }
        
        container.register(IItemsListPresenter.self) { (r, appRouter: IAppRouter, view: IItemsListView) in
            let wireframe = r.resolve(IItemsListWireframe.self, argument: appRouter)!
            let interceptor = r.resolve(IItemsListInterceptor.self)!
            let presenter = ItemsListPresenter(view: view, wireframe: wireframe, interceptor: interceptor)
            
            return presenter
        }
        
        container.register(ItemsListViewController.self) { (r, appRouter: IAppRouter) in
            let view = ItemsListViewController()
            let presenter = r.resolve(IItemsListPresenter.self, arguments: appRouter, view as IItemsListView)!
            view.presenter = presenter
            return view
        }
    }
    
    func setupAssembleItemsDetail(container: Container) {
        
        container.register(IItemsDetailInterceptor.self) { r in
            let service = r.resolve(IShopService.self)!
            let dataManager = r.resolve(IShopDataManager.self)!
            let storage = r.resolve(IShopStorage.self)!
            let interceptor = ItemsDetailInterceptor(service: service, dataManager: dataManager, storage: storage)
            
            return interceptor
        }
        
        container.register(IItemsDetailPresenter.self) { (r, appRouter: IAppRouter, view: IItemsDetailView) in
            let wireframe = r.resolve(IItemsDetailWireframe.self, argument: appRouter)!
            let interceptor = r.resolve(IItemsDetailInterceptor.self)!
            let presenter = ItemsDetailPresenter(view: view, wireframe: wireframe, interceptor: interceptor)
            
            interceptor.delegate = presenter
            
            return presenter
        }
        
        container.register(ItemsDetailViewController.self) { (r, appRouter: IAppRouter) in
            let view = ItemsDetailViewController()
            let presenter = r.resolve(IItemsDetailPresenter.self, arguments: appRouter, view as IItemsDetailView)!
            view.presenter = presenter
            return view
        }
    }
}
