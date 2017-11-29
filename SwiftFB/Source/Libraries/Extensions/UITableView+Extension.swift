//
//  UITableView.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 21/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

extension UITableView {

    func reusableCell<T: UITableViewCell>(with cls: T.Type, indexPath: IndexPath) -> T {
        let cell = self.dequeueReusableCell(withIdentifier: String.toString(cls), for: indexPath)
        
        return cell as! T
    }
    
    func applyChanges(with object: ArrayModelOption) {
        self.beginUpdates()
        
        object.applyChanges(to: self)
        
        self.endUpdates()
    }
}
