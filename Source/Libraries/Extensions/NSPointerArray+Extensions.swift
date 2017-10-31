//
//  NSPointerArray+Extensions.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 31/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import Foundation

extension NSPointerArray {
    
    func addObject(_ object: AnyObject?) {
        if let strongObject = object {
            let pointer = Unmanaged.passUnretained(strongObject).toOpaque()
            addPointer(pointer)
        }
    }
    
    func insertObject(_ object: AnyObject?, at index: Int) {
        if index < count, let strongObject = object {
            let pointer = Unmanaged.passUnretained(strongObject).toOpaque()
            insertPointer(pointer, at: index)
        }
    }
    
    func replaceObject(at index: Int, withObject object: AnyObject?) {
        if index < count, let strongObject = object {
            let pointer = Unmanaged.passUnretained(strongObject).toOpaque()
            replacePointer(at: index, withPointer: pointer)
        }
    }
    
    func object(at index: Int) -> AnyObject? {
        if index < count, let pointer = self.pointer(at: index) {
            return Unmanaged<AnyObject>.fromOpaque(pointer).takeUnretainedValue()
        }
        
        return nil
    }
    
    func removeObject(at index: Int) {
        if index < count {
            removePointer(at: index)
        }
    }
    
    func remove(_ object: AnyObject) {
        for index in 0...self.count - 1 {
            let obj = self.object(at: index)
            if (obj == object as! _OptionalNilComparisonType) {
                self.removeObject(at: index)
                
                return
            }
        }

    }
}
