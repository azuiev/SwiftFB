//
//  UIWindow+Extension.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 07/12/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

extension UIWindow {
    convenience init(_ controller: UIViewController) {
        self.init()
        
        self.rootViewController = controller
    }
}
