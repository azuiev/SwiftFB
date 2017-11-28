//
//  ImageModelCache.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 18/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class ImageModelCache {
    
    // MARK: Public properties
    
    static let shared = ImageModelCache()
    
    private var cache = Dictionary<URL, ImageModel>()
    
    // MARK: Initialization
    
    private init() {
        
    }
    
    // MARK: Public Methods
    
    func set(object: ImageModel, for key: URL) {
        synchronized(lockObject: self) { [weak self] in
            self?.cache[key] = object
        }
    }
    
    func removeObject(for key: URL) -> ImageModel? {
        return synchronized(lockObject: self) { [weak self] in
            return self?.cache.removeValue(forKey: key)
        }
    }
    
    func object(with key: URL) -> ImageModel? {
        return synchronized(lockObject: self) { [weak self] in
            return self?.cache[key]
        }
    }
}
