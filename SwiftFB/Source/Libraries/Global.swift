//
//  Global.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 20/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

struct ViewConstants {
    static let ViewResizableWithFixedPosition:UIViewAutoresizing = [.flexibleLeftMargin,
                                                                    .flexibleWidth,
                                                                    .flexibleRightMargin,
                                                                    .flexibleTopMargin,
                                                                    .flexibleHeight,
                                                                    .flexibleBottomMargin]
    
    static let ViewFixedPosition: UIViewAutoresizing = [.flexibleLeftMargin,
                                                        .flexibleRightMargin,
                                                        .flexibleTopMargin,
                                                        .flexibleBottomMargin]
    
    static let ViewResizable: UIViewAutoresizing = [.flexibleWidth, .flexibleHeight]
}

func synchronized<T>(lockObject: AnyObject, _ block: () -> T) -> T {
    objc_sync_enter(lockObject)
    defer { objc_sync_exit(lockObject) }
    
    return block()
}
