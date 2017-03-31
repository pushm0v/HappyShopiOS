//
//  Assembly.swift
//  happyshop
//
//  Created by Bherly Novrandy on 2/8/17.
//  Copyright © 2017 Bherly Novrandy. All rights reserved.
//

import Foundation
import Swinject

class CommonAssembly: Assembly {
    
    let APIUrl: String = "http://private-67c31-happyshop.apiary-mock.com/"
    
    func assemble(container: Container) {
        container.register(IAppRouter.self) {(r) in
            return AppRouter.sharedInstance
        }
        container.register(IShopService.self) {(r) in
            return ShopService(home: self.APIUrl)
        }
        container.register(IShopDataManager.self) {(r) in
            return ShopDataManager()
        }
        container.register(IShopStorage.self) {(r) in
            return ShopStorage()
        }
    }
}
