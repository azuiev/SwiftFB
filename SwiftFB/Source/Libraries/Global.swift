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

enum Result<T> {
    case Success(value: T)
    case Failure()
    
    func map<U>(f: (T) -> U) -> Result<U> {
        switch self {
        case let .Success(value: value):
            return Result<U>.Success(value: f(value))
        case .Failure():
            return Result<U>.Failure()
        }
    }
}

extension UIViewAutoresizing {
    static var resizableWithFixedPosition: UIViewAutoresizing {
        return [.flexibleLeftMargin,
                .flexibleWidth,
                .flexibleRightMargin,
                .flexibleTopMargin,
                .flexibleHeight,
                .flexibleBottomMargin]
    }
    
    var fixedPosition: UIViewAutoresizing {
        return [.flexibleLeftMargin,
                .flexibleRightMargin,
                .flexibleTopMargin,
                .flexibleBottomMargin]
    }
    
    var resizable: UIViewAutoresizing {
        return [.flexibleWidth, .flexibleHeight]
    }
}

func synchronized<T>(lockObject: AnyObject, _ block: () -> T) -> T {
    objc_sync_enter(lockObject)
    defer { objc_sync_exit(lockObject) }
    
    return block()
}
