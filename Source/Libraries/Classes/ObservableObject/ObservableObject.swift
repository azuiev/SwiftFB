//
//  Observer.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 26/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import Foundation

func synchronized<T>(lock: AnyObject, _ block: () -> T) -> T {
    objc_sync_enter(lock)
    defer { objc_sync_exit(lock) }
    
    return block()
}

extension ObservableObject {
    class ObservationController {
        
        // MARK : Private Properties
        
        typealias ObserverType = AnyObject
        typealias ActionType = (ObservableObject) -> ()
        
        static var cache = Array<ObservationController>()
        private var observableObject: ObservableObject
        private var observer: ObserverType
        
        private var relation: [ModelState : ActionType] = [:]
        
        // MARK : Initialization
        
        static func controller(with observableObject: ObservableObject, observer: ObserverType) -> ObservationController {
            var result: ObservationController?
            ObservationController.cache.forEach { controller in
                if controller.observableObject === observableObject
                    && controller.observer === observer {
                    result = controller
                    
                    return
                }
            }
            
            if result == nil {
                result = ObservationController(observableObject: observableObject, observer: observer);
                ObservationController.cache.append(result!)
            }
            
            return result!
        }
        
        private init (observableObject: ObservableObject, observer: ObserverType) {
            self.observableObject = observableObject
            self.observer = observer
        }
    
        // MARK: Public Methods
        
        func set(_ action: @escaping ActionType, for state: ModelState) {
            self.relation[state] = action
        }
        
        func notify(of state: ModelState) {
            if let block = self.relation[state] {
                block(self.observableObject)
            } else {
                print("No block fo state")
            }
        }
    }
}

public class ObservableObject {
    
    typealias ObserverType = AnyObject
    typealias ActionType = (ObservableObject) -> ()
    
    
    // MARK: Public properties
    
    var state: ModelState = .DidUnload {
        didSet {
            if notify {
                self.notifyOfState();
            }
        }
        
    }
    
    var notify: Bool = true;
    
    var observers: NSHashTable<ObserverType>
    
    // MARK: Initialization and deinitialization
    
    init() {
        self.observers = NSHashTable.weakObjects();
    }
    
    // MARK: Public methods
    
    func add(_ observer: ObserverType, for state: ModelState, with block: @escaping ActionType) {
        self.observers.add(observer);
        
        let controller = ObservationController.controller(with: self, observer: observer);
        controller.set(block, for: state)
    }
    
    func add(_ observer: ObserverType?) {
        if let object = observer {
            _ = self.observers.add(object)
        }
    }
    
    func remove(_ observer:ObserverType?) {
        if let object = observer {
            self.observers.remove(object)
        }
    }
    
    func add(_ observers:Array<ObserverType>) {
        for observer in observers {
            self.add(observer);
        }
    }
    
    func remove(_ observers:Array<ObserverType>) {
        for observer in observers {
            self.remove(observer);
        }
    }
    
    func isObserved(by object:ObserverType) -> Bool {
        return false;
    }
    
    // MARK : Private Methods
    
    func controller(for observer: ObserverType) -> ObservationController {
        return ObservationController.controller(with: self, observer: observer)
    }
    
    func notifyOfState() {
        self.observers.allObjects.forEach {
            self.controller(for: $0).notify(of: self.state)
        }
    }
}
