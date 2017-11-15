//
//  CurrentUserModel.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 03/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class CurrentUserModel: UserModel {
    
    // MARK: Public Properties
    
    var token: String?
    
    // MARK: Public Methods
    
    func isAuthorized() -> Bool {
        return false
    }
}
