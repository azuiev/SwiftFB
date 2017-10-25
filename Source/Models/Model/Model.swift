//
//  Model.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 25/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import Foundation

enum ModelState: Int {
    case ModelDidUnload
    case ModelWillLoad
    case ModelDidLoad
    case ModelDidFailLoad
    case ModelStateCount
};

protocol Save {
    func save();
}

class Model {
    var state: ModelState?;
    
    func load() {
        let Int state = self.state;
    }
}
