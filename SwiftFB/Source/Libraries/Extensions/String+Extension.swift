//
//  String+Extension.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 29/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import Foundation

extension String {
    static func toString<T>(_ cls: T.Type) -> String {
        var result = String(describing: type(of: cls))
        result = result.substring(to: result.index(result.endIndex, offsetBy: -5))
        
        return result
    }
    
    static func removeIllegalSymbols(from string: String) -> String {
        let removal: [Character] = ["/", "\\", "?", "%", "*", "|", "\"", "<", ">"]
        
        return String(string.characters.filter { !removal.contains($0) })
    }
}
