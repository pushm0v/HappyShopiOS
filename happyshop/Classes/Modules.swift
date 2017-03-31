//
//  Module.swift
//  happyshop
//
//  Created by Bherly Novrandy on 2/8/17.
//  Copyright © 2017 Bherly Novrandy. All rights reserved.
//

import Foundation

public protocol IModule {
    func presentView(parameters: [String:AnyObject])
}

public protocol Module : Product {
    var routePath : String { get }
}

public protocol Product {
    var productName : String { get }
}


public enum Products {
    case ShopProduct
    
    public var productName: String {
        switch self {
        case .ShopProduct:
            return "Shop"
        }
    }
    
    public enum Shop: Module {
        case HomeModule
        case ItemsModule
        
        public var productName: String {
            return "Shop"
        }
        
        public var routePath: String {
            switch self {
            case .HomeModule:
                return "/shop/home"
            case .ItemsModule:
                return "/shop/items"
            }
        }
        
        static func getModule(routePath: String) -> Shop {
            if routePath.contains(Shop.ItemsModule.routePath) {
                return Shop.ItemsModule
            }
            
            return Shop.HomeModule
        }
    }
}
