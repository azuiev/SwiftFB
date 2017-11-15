//
//  Model.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 25/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import Foundation

protocol Save {
    func save();
}

enum ModelState {
    case didUnload
    case willLoad
    case didLoad
    case didFailLoading
    case stateCount
};

class Model: ObservableObject, Equatable, Hashable {
    
    // MARK: Public properties
    
    var hashValue: Int {
        return self.hashValue
    }
    
    // MARK: Public methods
    
    static func == (lhs: Model, rhs: Model) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func load() {
        let state = self.state;
        if .willLoad == state || .didLoad == state {
            self.notifyOfState()
            
            return;
        }
        
        self.state = .willLoad
        
        //add synchronized above
        
        self.loadObject()
    }
    
    func loadObject() {
        //add background
        self.performLoading()
    }
    
    func performLoading() {
        
    }
}
