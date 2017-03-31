//
//  HomeWireframe.swift
//  happyshop
//
//  Created by Bherly Novrandy on 2/8/17.
//  Copyright © 2017 Bherly Novrandy. All rights reserved.
//

import Foundation

protocol IHomeWireframe: class {
    func presentHomeView()
}

class HomeWireframe: IHomeWireframe {
    
    let router: IAppRouter
    
    init(router: IAppRouter) {
        self.router = router
    }
    
    func presentHomeView() {
        let view = router.resolver.resolve(HomeViewController.self, argument: router)!
        router.presentView(view: view)
    }
}
