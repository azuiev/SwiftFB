//
//  Observer.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 26/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import Foundation

extension ObservableObject {
    class ObservationController: Hashable, Equatable {
        
        // MARL : Protocol Hashable
        
        var hashValue: Int {
            return self.observableObject.hashValue ^ self.observer.hashValue
        }
        
        // MARK: Protocol Equatable
        
        public static func == (lhs: ObservationController, rhs: ObservationController) -> Bool {
            return lhs.hashValue == rhs.hashValue
        }
        
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

public class ObservableObject: Equatable, Hashable {
    
    typealias ObserverType = AnyObject
    typealias ActionType = (ObservableObject, Any?) -> ()
    
    // MARK: Protocol Hashable
    
    public var hashValue: Int {
        return 0
    }
    
    // MARK: Protocol Equatable
    
    public static func == (lhs: ObservableObject, rhs: ObservableObject) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    // MARK: Public properties
    
    var state: ModelState = .didUnload {
        didSet {
            self.notifyOfState();
        }
    }

    var notify: Bool = true;
    
    var observationControllers = Set<WeakReference<ObservationController>>()
    
    // MARK : Public Methods
    
    func controller(for observer: ObserverType) -> ObservationController {
        let controller = ObservationController(observableObject: self, observer: observer)
        self.observationControllers.insert(WeakReference(controller))
        
        return controller
    }
    
    func performNotification(notify: Bool, with block: () -> ()) {
        let currentNotify = self.notify
        self.notify = notify
        
        block()
        
        self.notify = currentNotify
    }
    
    func set(state: ModelState, with object: Any) {
        self.performNotification(notify: false) { [weak self] in
            self?.state = state
        }
        
        self.notifyOfState(with: object)
    }
    
    func remove(controller: ObservationController?) {
        guard let object = controller else { return }
        self.observationControllers.remove(WeakReference(object))
    }
    
    func notifyOfState(with object: Any? = nil) {
        if self.notify {
            self.observationControllers.forEach {
                if let controller = $0.object as? ObservationController {
                    controller.notify(of: self.state, with: object)
                }
            }
        }
    }
    
    // TODO
    func isObserved(by object:ObserverType) -> Bool {
        return false;
    }
}
