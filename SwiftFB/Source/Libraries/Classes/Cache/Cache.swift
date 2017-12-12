//
//  Cache.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 18/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class Cache {
    
    // MARK: Class Methods 
    
    static private var store : [String : Cache] = [:]
    
    static func shared<T>(_ cls: T.Type) -> Cache {
        if let result = self.store[toString(cls)] {
            return result
        } else {
            let result = Cache()
            self.store[toString(cls)] = result
            
            return result
        }
    }
    
    private var cache = [URL : AnyObject]()
    
    // MARK: Initialization
    
    private init() {
        
    }
    
    // MARK: Public Methods
    
    func set(object: AnyObject?, for key: URL) {
        synchronized(lockObject: self) { [weak self] in
            self?.cache[key] = object
        }
    }
    
    func removeObject(for key: URL) -> AnyObject? {
        return synchronized(lockObject: self) { [weak self] in
            return self?.cache.removeValue(forKey: key)
        }
    }
    
    func object(with key: URL) -> AnyObject? {
        return synchronized(lockObject: self) { [weak self] in
            return self?.cache[key]
        }
    }
}
