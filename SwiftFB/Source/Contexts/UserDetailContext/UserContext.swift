//
//  UserContext.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 15/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class UserContext: GetContext {

    // MARK: Initialization
    
    override init?(model: Model, currentUser: CurrentUserModel) {
        super.init(model: model, currentUser: currentUser)
        
        guard let user = model as? UserModel else { return }
        
        self.parameters = ["fields" : "first_name,last_name,middle_name,birthday,gender,picture.height(9999){url}"]
        self.graphPath = user.userID ?? ""
    }
}
