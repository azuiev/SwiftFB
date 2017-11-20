//
//  myurl.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 20/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import Foundation

extension URL {
    func pathWithRemovingIllegalSymbols() -> String {
        return self.path.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics) ?? ""
    }
}
