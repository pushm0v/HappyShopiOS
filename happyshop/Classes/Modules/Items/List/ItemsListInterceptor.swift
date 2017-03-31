//
//  ItemsListInterceptor.swift
//  happyshop
//
//  Created by Bherly Novrandy on 3/1/17.
//  Copyright © 2017 Bherly Novrandy. All rights reserved.
//

import Foundation

protocol IItemsListInterceptor: class {
    func fetchItems(success: @escaping (([Item]) -> Void))
}

class ItemsListInterceptor: IItemsListInterceptor {
    let service: IShopService
    let dataManager: IShopDataManager
    
    init(service: IShopService, dataManager: IShopDataManager) {
        self.service = service
        self.dataManager = dataManager
    }
    
    func fetchItems(success: @escaping (([Item]) -> Void)){
        return dataManager.fetchItems(success: success)
    }
}
