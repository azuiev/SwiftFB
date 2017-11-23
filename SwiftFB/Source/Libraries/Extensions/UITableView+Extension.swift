//
//  UITableView.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 21/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

extension UITableView {

    func reusableCell<T: UITableViewCell>(with cls: T.Type) -> T? {
        var cell = self.dequeueReusableCell(withIdentifier: String(describing: type(of: cls)))
        
        if cell == nil {
            cell = UINib.object(with: cls)
        }
        
        return cell as? T
    }
    
    func applyChanges(with object: ArrayModelOption) {
        self.beginUpdates()
        
        object.applyChanges(to: self)
        
        self.endUpdates()
    }
}
