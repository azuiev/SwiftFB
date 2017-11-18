//
//  Observer.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 26/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import Foundation

func synchronized<T>(lockObject: AnyObject, _ block: () -> T) -> T {
    objc_sync_enter(lockObject)
    defer { objc_sync_exit(lockObject) }
    
    return block()
}

func synchronized(lockObject: AnyObject, _ block: () -> ())  {
    objc_sync_enter(lockObject)
    defer { objc_sync_exit(lockObject) }
    
    block()
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
        
        init(observableObject: ObservableObject, observer: ObserverType) {
            self.observableObject = observableObject
            self.observer = observer
        }
    
        // MARK: Public Methods
        
        func notify(of state: ModelState) {
            if let block = self.relation[state] {
                block(self.observableObject)
            } else {
                print("No block fo state")
            }
        }
        
        subscript(state: ModelState) -> ActionType? {
            get {
                return self.relation[state]
            }
            set {
                self.relation[state] = newValue
            }
        }
    }
}

public class ObservableObject {
    
    typealias ObserverType = AnyObject
    typealias ActionType = (ObservableObject) -> ()
    
    // MARK: Public properties
    
    var state: ModelState = .didUnload {
        didSet {
            if notify {
                self.notifyOfState();
            }
        }
        
    }
    
    var notify: Bool = true;
    
    var observationControllers: NSHashTable<ObservationController>
    
    // MARK: Initialization and deinitialization
    
    init() {
        self.observationControllers = NSHashTable.weakObjects();
    }

    // MARK : Public Methods
    
    func controller(for observer: ObserverType) -> ObservationController {
        let controller = ObservationController(observableObject: self, observer: observer)
        self.observationControllers.add(controller)
        
        return controller
        
    }
    
    func notifyOfState() {
        self.observationControllers.allObjects.forEach {
            $0.notify(of: self.state)
        }
    }
    
    func remove(controller: ObservationController) {
        self.observationControllers.remove(controller)
    }
    
    // TODO
    func isObserved(by object:ObserverType) -> Bool {
        return false;
    }
}
