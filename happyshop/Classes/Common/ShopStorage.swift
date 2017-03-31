//
//  ShopStorage.swift
//  happyshop
//
//  Created by Bherly Novrandy on 3/3/17.
//  Copyright © 2017 Bherly Novrandy. All rights reserved.
//

import Foundation
import FirebaseStorage
import UIKit

protocol IShopStorage: class {
    var firebaseStorageRef: FIRStorageReference { get }
    var delegate: IShopStorageDelegate? { get set }
    func uploadImage(image: Any)
}

protocol IShopStorageDelegate: class {
    func shopStorage(shopStorage: IShopStorage, didSuccessUploadImage: Bool, metaData: FIRStorageMetadata?)
    func shopStorage(shopStorage: IShopStorage, didFailureUploadImage: Bool, error: Error?)
    func shopStorage(shopStorage: IShopStorage, progressUploadImage: Progress)
}

class ShopStorage: IShopStorage {
    var firebaseStorageRef: FIRStorageReference
    var delegate: IShopStorageDelegate?
    let filePath: String = "images/"
    
    init() {
        firebaseStorageRef = FIRStorage.storage().reference()
    }
    
    func uploadImage(image: Any) {
        guard let image = image as? UIImage, let data: Data = UIImageJPEGRepresentation(image, 0.8) else { return }
        
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpg"
        firebaseStorageRef.child(filePath).put(data, metadata: metaData){(metaData,error) in
            if let error = error {
                self.delegate?.shopStorage(shopStorage: self, didFailureUploadImage: true, error: error)
                return
            }else{
                self.delegate?.shopStorage(shopStorage: self, didSuccessUploadImage: true, metaData: metaData)
            }
            
        }
    }
}
