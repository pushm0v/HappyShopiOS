//
//  ItemsModule.swift
//  happyshop
//
//  Created by Bherly Novrandy on 2/12/17.
//  Copyright © 2017 Bherly Novrandy. All rights reserved.
//

import Foundation

class ItemsModule: IModule {
    
    let router: IAppRouter
    
    init(router: IAppRouter) {
        self.router = router
    }
    
    func presentView(parameters: [String : AnyObject]) {
        routeView(parameters: parameters)
    }
    
    func routeView(parameters: [String : AnyObject]) {
        if let routePath = parameters["routePath"] as? String {
            switch routePath {
                case Products.Shop.ItemsModule.routePath + "/add":
                    let wireframe = router.resolver.resolve(IItemsDetailWireframe.self, argument: router)!
                    wireframe.presentDetailView()
                break
                default:
                    let wireframe = router.resolver.resolve(IItemsListWireframe.self, argument: router)!
                    wireframe.presentItemsListView()
                break
            }
        }
    }
}
