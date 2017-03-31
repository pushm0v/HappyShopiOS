//
//  ShopService.swift
//  happyshop
//
//  Created by Bherly Novrandy on 2/8/17.
//  Copyright © 2017 Bherly Novrandy. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

protocol IShopService: class {
    var home: String { get }
    func getItems(success: @escaping ([Item])-> Void, failure: @escaping (_ error: NSError) -> Void)
}

class ShopService: IShopService {
    
    var home: String
    let manager = SessionManager()
    
    init(home: String) {
        self.home = home
    }
    
    func getItems(success: @escaping ([Item])-> Void, failure: @escaping (_ error: NSError) -> Void) {
        print(self.home + "items")
        Alamofire.request(self.home + "items", method: .get)
            .responseArray {(response: DataResponse<[Item]>) in
                switch response.result {
                case let .success(result):
                    success(result)
                case let .failure(error):
                    failure(error as NSError)
                }
        }
    }
}
