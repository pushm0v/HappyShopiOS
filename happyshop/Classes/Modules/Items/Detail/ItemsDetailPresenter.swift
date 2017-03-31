//
//  ItemsDetailPresenter.swift
//  happyshop
//
//  Created by Bherly Novrandy on 2/13/17.
//  Copyright © 2017 Bherly Novrandy. All rights reserved.
//

import Foundation

protocol IItemsDetailPresenter : class {
    func save(values: [String: Any])
}

class ItemsDetailPresenter: IItemsDetailPresenter {
    
    let wireframe: IItemsDetailWireframe
    let interceptor: IItemsDetailInterceptor
    weak var view: IItemsDetailView?
    var pendingItem: [String: Any]?
    
    init(view: IItemsDetailView, wireframe: IItemsDetailWireframe, interceptor: IItemsDetailInterceptor) {
        self.wireframe = wireframe
        self.interceptor = interceptor
        self.view = view
    }
    
    func save(values: [String: Any]) {
        view?.showLoading(show: true)
        pendingItem = values
        let a = values["image"]
        dump(a! != nil)
//        if values["image"] != nil {
//            if image != nil {
//                interceptor.uploadImage(image: image)
//            }
//            else {
//                if let item = formValuesToItem(values: values) {
//                    interceptor.saveItem(item: item)
//                    view?.showLoading(show: false)
//                }
//            }
//        }
    }
    
    internal func formValuesToItem(values: [String: Any]) -> Item? {
        var formValues = values
        do {
            formValues["id"] = UUID().uuidString
            let data = try JSONSerialization.data(withJSONObject:formValues, options:[])
            let dataString = String(data: data, encoding: String.Encoding.utf8)!
            
            return Item(JSONString: dataString)
            
        } catch {
            return nil
        }
    }
}

extension ItemsDetailPresenter: IItemsDetailInterceptorDelegate {
    func storageUploadImage(storageUploadImage: IItemsDetailInterceptor, didFailure: Bool, error: Error?) {
        print("EEEE")
    }
    
    func storageUploadImage(storageUploadImage: IItemsDetailInterceptor, didSuccess: Bool, downloadUrl: String) {
        guard let _ = pendingItem else { return }
        pendingItem?["image"] = downloadUrl
        if let valuesToSave = pendingItem {
            if let item = formValuesToItem(values: valuesToSave) {
                interceptor.saveItem(item: item)
                view?.showLoading(show: false)
            }
        }
    }
    
    func saveItem(saveItem: IItemsDetailInterceptor, didSuccess: Bool) {
        view?.showLoading(show: false)
    }
}
