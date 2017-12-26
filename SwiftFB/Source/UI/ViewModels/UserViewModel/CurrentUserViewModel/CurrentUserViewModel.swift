//
//  CurrentUserViewModel.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 21/12/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import Foundation

class CurrentUserViewModel: UserViewModel {
    
    // MARK: Public Properties
    
    var token: String { return self.currentUser.token ?? "" }
    
    // MARK: Initialization
    
    init(currentUserModel: CurrentUserModel) {
        self.currentUser = currentUserModel
        
        super.init(userModel: currentUserModel)
    }
    
    // MARK: Private Properties
    
    private var currentUser: CurrentUserModel
}
