//
//  ShopDataManager.swift
//  happyshop
//
//  Created by Bherly Novrandy on 3/1/17.
//  Copyright © 2017 Bherly Novrandy. All rights reserved.
//

import Foundation
import FirebaseDatabase
import ObjectMapper

protocol IShopDataManager: class {
    var firebaseDBRef: FIRDatabaseReference { get }
    var delegate: IShopDataManagerDelegate? { get set }
    func saveItem(item: Item)
    func fetchItems(success: @escaping (([Item]) -> Void))
}

protocol IShopDataManagerDelegate: class {
    func shopDataManager(shodDataManager: IShopDataManager, didSuccessSaveItem: Bool)
}

class ShopDataManager: IShopDataManager {
    var firebaseDBRef: FIRDatabaseReference
    var delegate: IShopDataManagerDelegate?
    
    enum RoutePath: String {
        case Item = "item"
    }
    
    init() {
        firebaseDBRef = FIRDatabase.database().reference()
    }
    
    func saveItem(item: Item) {
        firebaseDBRef.child(RoutePath.Item.rawValue).childByAutoId().setValue(item.toJSON())
        delegate?.shopDataManager(shodDataManager: self, didSuccessSaveItem: true)
    }
    
    func fetchItems(success: @escaping (([Item]) -> Void)){
        var items: [Item] = []
        firebaseDBRef.child(RoutePath.Item.rawValue).observeSingleEvent(of: .value, with: { (snapshot) in
            if let values = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for data in values {
                    guard let restDict = data.value as? [String: AnyObject] else {
                        continue
                    }
                    if let item = Item(JSON: restDict) {
                        items.append(item)
                    }
                }
            }
            success(items)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
