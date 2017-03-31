//
//  HomeModule.swift
//  happyshop
//
//  Created by Bherly Novrandy on 2/8/17.
//  Copyright © 2017 Bherly Novrandy. All rights reserved.
//

import Foundation

class HomeModule: IModule {
    
    let router: IAppRouter
    
    init(router: IAppRouter) {
        self.router = router
    }
    
    func presentView(parameters: [String : AnyObject]) {
        let wireframe = router.resolver.resolve(IHomeWireframe.self, argument: router)!
        wireframe.presentHomeView()
    }
}
