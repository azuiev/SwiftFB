//
//  String+Extension.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 29/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import Foundation

extension String {
    static func toString(_ cls: AnyClass) -> String {
        return String(describing: type(of: cls))
    }
 
    static func toString(_ object: AnyObject) -> String {
        return "\(object)"
    }
}
