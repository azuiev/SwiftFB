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
    var state: Int = 0 {
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
    func add(_ observer: Any) {
    
    }
    
    func remove(_ observer:ObservableObject) {
    
    }
    
    func add(_ observers:Array<ObservableObject>) {
        for observer in observers {
            self.add(observer);
        }
    }
    
    func remove(_ observers:Array<ObservableObject>) {
        for observer in observers {
            self.remove(observer);
        }
    }
    
    func isObserved(by object:ObservableObject) -> Bool {
        return false;
    }
    
    func notifyOfState(with selector:Selector) {
        self.notifyOfState(with: selector, nil);
    }
    
    func set(_ state:Int, with object:ObservableObject) {
        
    }
    
    //- (void)performBlockWithNotification:(void(^)())block;
    //- (void)performBlockWithoutNotification:(void(^)())block;
    
    //this method is intended for subclassing. Never call it directly
    func notify(of state:Int) {
        
    }
    
    func selector(for state:Int) -> Selector? {
        return nil;
    }
    // MARK: Private methods
    func notifyOfState(with selector:Selector, _ object:ObservableObject?) {
        let set = self.observers;
        for target in set! {
            if (target as NSObject).responds(to: selector) {
                (target as NSObject).perform(selector, with: self, with: self);
            }
        }
    }
}
