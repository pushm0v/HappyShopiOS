//
//  Enumerable.swift
//  happyshop
//
//  Created by Bherly Novrandy on 2/10/17.
//  Copyright © 2017 Bherly Novrandy. All rights reserved.
//

import Foundation

protocol EnumerableEnum {
    init?(rawValue: Int)
    static func firstRawValue() -> Int
}

extension EnumerableEnum {
    static func enumerate() -> AnyIterator<Self> {
        var nextIndex = firstRawValue()
        
        let iterator: AnyIterator<Self> = AnyIterator {
            defer { nextIndex = nextIndex + 1 }
            return Self(rawValue: nextIndex)
        }
        
        return iterator
    }
    
    static func firstRawValue() -> Int {
        return 0
    }
}
