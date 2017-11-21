//
//  UITableView.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 21/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

extension UITableView {

    func reusableCell(with cls: Any) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: String(describing: type(of: cls)))
        
        return cell!
    }
    /*
    - (UITableViewCell *)reusableCellWithClass:(Class)cls {
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:NSStringFromClass(cls)];
    if (!cell) {
    cell = [UINib objectWithClass:cls];
    }
    
    return cell;
    }
    
    - (void)applyChangesWithObject:(AZArrayModelChange *)object {
    [self beginUpdates];
    
    [object applyChangeToTableView:self];
    
    [self endUpdates];
    }
*/
}
