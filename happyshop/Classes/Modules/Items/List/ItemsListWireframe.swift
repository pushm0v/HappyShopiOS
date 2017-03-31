//
//  ItemsListWireframe.swift
//  happyshop
//
//  Created by Bherly Novrandy on 2/12/17.
//  Copyright © 2017 Bherly Novrandy. All rights reserved.
//

import Foundation

protocol IItemsListWireframe: class {
    func presentItemsListView()
}

class ItemsListWireframe: IItemsListWireframe {
    
    let router: IAppRouter
    
    init(router: IAppRouter) {
        self.router = router
    }
    
    func presentItemsListView() {
        let view = router.resolver.resolve(ItemsListViewController.self, argument: router)!
        router.presentView(view: view)
    }
}
