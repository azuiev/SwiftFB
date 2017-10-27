//
//  Observer.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 26/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import Foundation

public class ObservableObject {
    
    // MARK: Public properties
    var state: ModelState = .ModelDidUnload {
        didSet {
            if notify {
                self.notifyOfState(with: self.selector(for: self.state)!);
            }
        }
        
    }
    var notify: Bool = false;
    
    var observers: Set<AnyHashable>?;
    
    // MARK: Initialization and deinitialization
    deinit {
        self.observers = nil;
    }
    
    init() {
        self.observers = Set<AnyHashable>();
    }
    
    // MARK: Public methods
    func add(_ observer: Model?) {
        if let object = observer {
           _ = self.observers!.insert(AssignReference.init(with: object))
        }
    }
    
    func remove(_ observer:Model?) {
        self.observers!.remove(AssignReference.init(with: observer))
    }
    
    func add(_ observers:Array<Model>) {
        for observer in observers {
            self.add(observer);
        }
    }
    
    func remove(_ observers:Array<Model>) {
        for observer in observers {
            self.remove(observer);
        }
    }
    
    func isObserved(by object:Model) -> Bool {
        return false;
    }
    
    func notifyOfState(with selector:Selector) {
        self.notifyOfState(with: selector, nil);
    }
    
    func set(_ state:ModelState, with object:Model?) {
        self.state = state
        
        if notify {
            self.notifyOfState(with: self.selector(for: state)!, object!)
        }
    }
    
    //- (void)performBlockWithNotification:(void(^)())block;
    //- (void)performBlockWithoutNotification:(void(^)())block;
    
    //this method is intended for subclassing. Never call it directly
    func notify(of state:ModelState) {
        self.notifyOfState(with: self.selector(for: state)!)
    }
    
    func selector(for state:ModelState) -> Selector? {
        return nil;
    }
    
    // MARK: Private methods
    func notifyOfState(with selector:Selector, _ object:Model?) {
        let set = self.observers;
        for target in set! {
            if (target as NSObject).responds(to: selector) {
                (target as NSObject).perform(selector, with: self, with: self);
            }
        }
    }
}
