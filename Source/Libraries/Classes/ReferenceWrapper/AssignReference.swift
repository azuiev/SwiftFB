//
//  AssignReference.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 26/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import Foundation

class AssignReference: Hashable, Equatable {
    
    // MARK: Public properties
    var target: AnyHashable?;
    
    var hashValue: Int {
        return self.target!.hashValue;
    }
    
    // MARK: Initialization
    init(with target: AnyHashable?) {
        self.target = target;
    }
    
    // MARK: Public methods
    
    static func == (lhs: AssignReference, rhs: AssignReference) -> Bool {
        return lhs.target == rhs.target;
    }
    
    func isEqual(to object:Any?) -> Bool {
        if let extractedObject = object {
            if self == extractedObject as! AssignReference {
                return true;
            }
            
            if object_getClassName(self) != object_getClassName(extractedObject) {
                return false;
            }
            
            return self.target == (extractedObject as! AssignReference).target;
        } else {
            return false;
        }
    }
}
