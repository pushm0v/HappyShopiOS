//
//  ItemsDetailWireframe.swift
//  happyshop
//
//  Created by Bherly Novrandy on 2/13/17.
//  Copyright © 2017 Bherly Novrandy. All rights reserved.
//

import Foundation

protocol IItemsDetailWireframe: class {
    func presentDetailView()
}

class ItemsDetailWireframe: IItemsDetailWireframe {
    let router: IAppRouter
    
    init(router: IAppRouter) {
        self.router = router
    }
    
    func presentDetailView() {
        let view = router.resolver.resolve(ItemsDetailViewController.self, argument: router)!
        router.presentView(view: view)
    }
}
