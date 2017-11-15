//
//  UINib+Extension.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 09/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

extension UINib {
    
    static func nib(with type: AnyClass, bundle: Bundle? = nil) -> UINib? {
        return UINib.init(nibName: String(describing: type), bundle: bundle)
    }
    
    static func object(with type: AnyClass, bundle: Bundle? = nil, owner: Any? = nil, options: [AnyHashable : Any]? = nil) -> Any? {
        let nib = self.nib(with: type, bundle: bundle)
        if nib != nil {
            return nib?.object(with: type, owner: owner, options: options)
        }
        
        return nil
    }
    
    func object(with type: Any, owner: Any? = nil, options: [AnyHashable : Any]?) -> Any? {
        let objects = self.instantiate(withOwner: owner, options: options)
        
        return objects.first
    }
}
