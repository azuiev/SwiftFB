//
//  LoginContext.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 03/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

class LoginContext: GetContext {
    
    struct Constants {
        static let TokenStringPath     = "token.tokenString"
        static let UserIDStringPath    = "token.userID"
        static let UserIDString        = "userID"
        static let TokenString         = "token"

    }
    
    // MARK: Public Methods
    
    override func execute(with completionHandler: @escaping(ModelState) -> Void) {
        let user = self.model as! CurrentUserModel
        if !user.isAuthorized() {
            let manager = LoginManager()
            manager.logIn([.publicProfile, .userFriends],
                               viewController: nil)
            { loginResult in
                switch loginResult {
                case .failed(let error):
                    print(error)
                case .cancelled:
                    print("User cancelled login.")
                case .success(_,_,let token):
                    self.fillUser(with: token)
                }
            }
        } else {
            completionHandler(.ModelDidLoad)
        }
    }
    
    // MARK: Private Methods
    
    func fillUser(with token: AccessToken) {
        let user = self.model as! CurrentUserModel
        user.token = token.userId
        user.userID = token.authenticationToken
    }
    
}
