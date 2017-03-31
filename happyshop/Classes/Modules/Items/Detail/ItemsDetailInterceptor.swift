//
//  ItemsDetailInterceptor.swift
//  happyshop
//
//  Created by Bherly Novrandy on 3/1/17.
//  Copyright © 2017 Bherly Novrandy. All rights reserved.
//

import Foundation
import FirebaseStorage

protocol IItemsDetailInterceptor: class {
    func saveItem(item: Item)
    func uploadImage(image: Any)
    var delegate: IItemsDetailInterceptorDelegate? { get set }
}

protocol IItemsDetailInterceptorDelegate: class {
    func storageUploadImage(storageUploadImage: IItemsDetailInterceptor, didSuccess: Bool, downloadUrl: String)
    func storageUploadImage(storageUploadImage: IItemsDetailInterceptor, didFailure: Bool, error: Error?)
    func saveItem(saveItem: IItemsDetailInterceptor, didSuccess: Bool)
}

class ItemsDetailInterceptor: IItemsDetailInterceptor {
    let service: IShopService
    let dataManager: IShopDataManager
    let storage: IShopStorage
    var delegate: IItemsDetailInterceptorDelegate?
    
    init(service: IShopService, dataManager: IShopDataManager, storage: IShopStorage) {
        self.service = service
        self.dataManager = dataManager
        self.storage = storage
        self.storage.delegate = self
        self.dataManager.delegate = self
    }
    
    func saveItem(item: Item) {
        dataManager.saveItem(item: item)
    }
    
    func uploadImage(image: Any) {
        storage.uploadImage(image: image)
    }
}


extension ItemsDetailInterceptor: IShopStorageDelegate {
    func shopStorage(shopStorage: IShopStorage, progressUploadImage: Progress) {
        
    }
    func shopStorage(shopStorage: IShopStorage, didFailureUploadImage: Bool, error: Error?) {
        
    }
    func shopStorage(shopStorage: IShopStorage, didSuccessUploadImage: Bool, metaData: FIRStorageMetadata?) {
        if let metaData = metaData, let downloadURL = metaData.downloadURL() {
            delegate?.storageUploadImage(storageUploadImage: self, didSuccess: didSuccessUploadImage, downloadUrl: downloadURL.absoluteString)
        }
        else {
            print("Error")
        }
    }
    func saveItem(saveItem: IItemsDetailInterceptor, didSuccess: Bool) {
        
    }
}

extension ItemsDetailInterceptor: IShopDataManagerDelegate {
    func shopDataManager(shodDataManager: IShopDataManager, didSuccessSaveItem: Bool) {
        delegate?.saveItem(saveItem: self, didSuccess: didSuccessSaveItem)
    }
}
