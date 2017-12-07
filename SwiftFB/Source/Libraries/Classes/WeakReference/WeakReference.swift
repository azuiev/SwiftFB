//
//  WeakReference.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 01/12/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import Foundation

class WeakReference<T: Hashable & Equatable> : Hashable  {
    
    // MARK: Protocol Hashable
    
    var hashValue: Int {
        return self.object?.hashValue ?? 0
    }
    
    // MARK: Protocol Equatable
    
    public static func ==(lhs: WeakReference, rhs: WeakReference) -> Bool {
        if lhs.hashValue != rhs.hashValue {
            return false
        }
        
        return lhs.object as? T == rhs.object as? T
    }
    
    // MARK: Public Properties
    
    weak var object: AnyObject?

    // MARK: Initialization
    
    init(_ object: AnyObject) {
        self.object = object
    }
}
