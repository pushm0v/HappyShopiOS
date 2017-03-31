//
//  ShopRouter.swift
//  happyshop
//
//  Created by Bherly Novrandy on 2/8/17.
//  Copyright © 2017 Bherly Novrandy. All rights reserved.
//

import Foundation

class ShopRouter: IProductRouter {
    
    let router: IAppRouter
    
    let modules: [String: (IAppRouter) -> IModule] = [
        Products.Shop.HomeModule.routePath: { HomeModule(router: $0) },
        Products.Shop.ItemsModule.routePath: { ItemsModule(router: $0) }
    ]
    
    init(router: IAppRouter) {
        self.router = router
    }
    
    func presentModule(module: Module, parameters: [String : AnyObject]) {
        if let moduleConstructor = modules[module.routePath] {
            let module = moduleConstructor(router)
            module.presentView(parameters: parameters)
        }
    }
}
