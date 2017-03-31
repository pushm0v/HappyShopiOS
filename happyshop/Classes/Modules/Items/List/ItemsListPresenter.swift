//
//  ItemsListPresenter.swift
//  happyshop
//
//  Created by Bherly Novrandy on 2/13/17.
//  Copyright © 2017 Bherly Novrandy. All rights reserved.
//

import Foundation

protocol IItemsListPresenter : class {
    var items: [Item] { get }
    func start()
}

class ItemsListPresenter: IItemsListPresenter {
    
    var items: [Item] = []
    
    let wireframe: IItemsListWireframe
    let interceptor: IItemsListInterceptor
    weak var view: IItemsListView?
    
    init(view: IItemsListView, wireframe: IItemsListWireframe, interceptor: IItemsListInterceptor) {
        self.wireframe = wireframe
        self.interceptor = interceptor
        self.view = view
    }
    
    func start() {
        view?.setLoading(loading: true)
        interceptor.fetchItems(success: { items in
            self.items = items
            self.view?.setLoading(loading: false)
            self.view?.reload()
        })
    }
}
