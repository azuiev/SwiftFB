//
//  LoginViewModel.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 26/12/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    
    // MARK: Public Properties
    
    let subject = PublishSubject<Result<CurrentUserModel>>()
    
    // MARK: Initialization
    
    init(currentUserModel: CurrentUserModel) {
        self.currentUser = currentUserModel
    }
    
    // MARK: Public Functions
    
    func tryLogin() {
        LoginContext(currentUser:self.currentUser, subject: self.subject).execute()
    }
    
    // MARK: Private Properties
    
    private var currentUser: CurrentUserModel
}
