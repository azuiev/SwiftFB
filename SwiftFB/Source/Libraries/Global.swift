//
//  Global.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 20/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit


// MARK: Typealias

typealias JSON = [String : String]
typealias JSONArray = [[String : String]]

struct ViewAutoresizing {
    static var resizableWithFixedPosition: UIViewAutoresizing {
        return [UIViewAutoresizing.flexibleLeftMargin,
                UIViewAutoresizing.flexibleWidth,
                UIViewAutoresizing.flexibleRightMargin,
                UIViewAutoresizing.flexibleTopMargin,
                UIViewAutoresizing.flexibleHeight,
                UIViewAutoresizing.flexibleBottomMargin]
    }
    
    static var fixedPosition: UIViewAutoresizing {
        return [UIViewAutoresizing.flexibleLeftMargin,
                UIViewAutoresizing.flexibleRightMargin,
                UIViewAutoresizing.flexibleTopMargin,
                UIViewAutoresizing.flexibleBottomMargin]
    }
    
    static var resizable: UIViewAutoresizing {
        return [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
    }
}

func synchronized<T>(lockObject: AnyObject, _ block: () -> T) -> T {
    objc_sync_enter(lockObject)
    defer { objc_sync_exit(lockObject) }
    
    return block()
}
