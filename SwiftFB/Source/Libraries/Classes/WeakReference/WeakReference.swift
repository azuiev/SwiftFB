//
//  WeakReference.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 01/12/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import Foundation

struct WeakReference<T: Hashable>: Hashable  {
    
    // MARK: Protocol Hashable
    
    var hashValue: Int
    
    // MARK: Protocol Equatable
    
    public static func ==(lhs: WeakReference, rhs: WeakReference) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    // MARK: Public Properties
    
    weak var object: AnyObject?

    // MARK: Initialization
    
    init(_ object: T) {
        self.hashValue = object.hashValue
        self.object = object as AnyObject
    }
}
