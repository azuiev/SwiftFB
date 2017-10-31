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

protocol ModelObserver: Hashable {
    func modelDidLoad(_ model:Model)
    func modelWillLoad(_ model:Model)
    func modelDidUnoad(_ model:Model)
    func modelDidFailLoading(_ model:Model)
}

enum ModelState: Int {
    case ModelDidUnload
    case ModelWillLoad
    case ModelDidLoad
    case ModelDidFailLoading
    case ModelStateCount
};

class Model: ObservableObject, Equatable, Hashable {
    var hashValue: Int {
        return self.hashValue;
    }
    
    // MARK: Public methods
    
    static func == (lhs: Model, rhs: Model) -> Bool {
        return lhs.hashValue == rhs.hashValue;
    }
    
    func load() {
        let state = self.state;
        if .ModelWillLoad == state || .ModelDidLoad == state {
            self.notifyOfState(with: self.selector(for: state)!);
            
            return;
        }
        
        self.state = .ModelWillLoad;
        
        //add synchronized above
        
        self.loadObject();
    }
    
    func loadObject() {
        //add background
        self.performLoading();
    }
    
    func performLoading() {
        
    }
    
    // MARK: Model observer 
    
    override func selector(for state: ModelState) -> Selector? {
        switch state {
        case .ModelDidUnload:
            return Selector("modelDidUnload");
        case .ModelDidLoad:
            return Selector("modelDidLoad");
        case .ModelWillLoad:
            return Selector("modelWillLoad");
        case .ModelDidFailLoading:
            return Selector("modelDidFailLoading");
            
        default:
            return super.selector(for: state);
        }
    }
}
