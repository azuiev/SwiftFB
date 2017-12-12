//
//  Global.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 20/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

// MARK: Typealias

typealias JSON = [String : Any]
typealias JSONArray = [[String : Any]]

// MARK: Global Methods

func toString<T>(_ cls: T.Type) -> String {
    return String(describing: cls)
}

// MARK: Struct Result

enum Result<T> {
    case Success(value: T)
    case Failure()
    
    func map<U>(f: (T) -> U) -> Result<U> {
        switch self {
        case let .Success(value: value):
            return .Success(value: f(value))
        case .Failure():
            return .Failure()
        }
    }
    
    func isSuccess() -> Bool {
        switch self {
        case .Success(value: ):
            return true
        default:
            return false
        }
    }
    
    func isFailure() -> Bool {
        return !self.isSuccess()
    }
}

// MARK: UIViewAutoresizing

extension UIViewAutoresizing {
    static var resizableWithFixedPosition: UIViewAutoresizing {
        return [.flexibleLeftMargin,
                .flexibleWidth,
                .flexibleRightMargin,
                .flexibleTopMargin,
                .flexibleHeight,
                .flexibleBottomMargin]
    }
    
    static var fixedPosition: UIViewAutoresizing {
        return [.flexibleLeftMargin,
                .flexibleRightMargin,
                .flexibleTopMargin,
                .flexibleBottomMargin]
    }
    
    static var resizable: UIViewAutoresizing {
        return [.flexibleWidth, .flexibleHeight]
    }
}

// MARK: Synchronization

func synchronized<T>(lockObject: AnyObject, _ block: () -> T) -> T {
    objc_sync_enter(lockObject)
    defer { objc_sync_exit(lockObject) }
    
    return block()
}
