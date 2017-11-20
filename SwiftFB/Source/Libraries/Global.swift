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
