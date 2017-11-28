//
//  Observer.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 26/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import Foundation

extension ObservableObject {
    class ObservationController {
        
        // MARK : Private Properties
        
        typealias ObserverType = AnyObject
        typealias ActionType = (ObservableObject, Any?) -> ()
        
        static var cache = Array<ObservationController>()
        private var observableObject: ObservableObject
        private var observer: ObserverType
        
        private var relation: [ModelState : ActionType] = [:]
        
        // MARK: Initialization
        
        init(observableObject: ObservableObject, observer: ObserverType) {
            self.observableObject = observableObject
            self.observer = observer
        }
    
        // MARK: Public Methods
        
        func notify(of state: ModelState, with object: Any? = nil) {
            if let block = self.relation[state] {
                block(self.observableObject, object)
            } else {
                print("No block fo state \(state) and object - \(object ?? "noObject")")
            }
        }
        
        // MARK: Subscripts
        
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
    typealias ActionType = (ObservableObject, Any?) -> ()
    
    // MARK: Public properties
    
    var state: ModelState = .didUnload {
        didSet {
            self.notifyOfState();
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
    
    func performNotification(notify: Bool, with block: () -> ()) {
        self.notify = notify
        
        block()
        
        self.notify = true
    }
    
    func set(state: ModelState, with object: Any) {
        self.performNotification(notify: false) { [weak self] in
            self?.state = state
        }
        
        self.notifyOfState(with: object)
    }
    
    func remove(controller: ObservationController) {
        self.observationControllers.remove(controller)
    }
    
    func notifyOfState() {
        if self.notify {
            self.observationControllers.allObjects.forEach {
                $0.notify(of: self.state)
            }
        }
    }
    
    func notifyOfState(with object: Any) {
        if self.notify {
            self.observationControllers.allObjects.forEach {
                $0.notify(of: self.state, with: object)
            }
        }
    }
    
    // TODO
    func isObserved(by object:ObserverType) -> Bool {
        return false;
    }
}
