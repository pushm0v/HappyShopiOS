//
//  Items.swift
//  happyshop
//
//  Created by Bherly Novrandy on 2/13/17.
//  Copyright © 2017 Bherly Novrandy. All rights reserved.
//

import Foundation
import ObjectMapper

class Item: Mappable, Equatable {
    
    var name: String?
    var qty: Int?
    var id: String?
    var description: String?
    var image: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        qty <- map["qty"]
        id <- map["id"]
        description <- map["description"]
        image <- map["image"]
    }

    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
    
}
