//
//  Context.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 31/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import Foundation

class Context: Model {
    
    // MARK: Public Properties
    
    let model: Model
    var currentUser: CurrentUserModel?
    
    // MARK: Initialization
    
    init(with model: Model) {
        self.model = model

        super.init()
    }
    
    // MARK: Public Methods
    
    func token() -> String? {
        return nil;
    }
    
    func execute() {
        self.execute {
            self.model.state = $0
        }
    }
    
    func execute(with completionHandler: @escaping(ModelState) -> Void) {
        
    }
    
    func cancel() {
        
    }
}
