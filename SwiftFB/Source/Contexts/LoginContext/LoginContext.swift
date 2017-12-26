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
import RxSwift
import RxCocoa

class LoginContext: GetContext {
    
    // MARK: Constants
    
    private struct Constants {
        static let TokenStringPath     = "token.tokenString"
        static let UserIDStringPath    = "token.userID"
        static let UserIDString        = "userID"
        static let TokenString         = "token"
    }
    
    // MARK: Public Properties
    
    override var user: UserModel? {
        get {
            guard let result = self.model as? CurrentUserModel else { return nil }
            
            return result
        }
        set { }
    }
    
    // MARK: Initialization
    
    init(currentUser: CurrentUserModel, subject: PublishSubject<Result<CurrentUserModel>>) {
        self.subject = subject
        
        super.init(model: currentUser, currentUser: currentUser)
    }
    
    // MARK: Public Methods
    
    override func execute(withCompletion completionHandler: @escaping(ModelState) -> Void) {
        guard let user = self.model as? CurrentUserModel else { return }
        if !user.isAuthorized() {
            let manager = LoginManager()
            manager.logIn(readPermissions: [.userFriends, .publicProfile]) { loginResult in
                switch loginResult {
                case .failed(let error):
                    self.subject.onNext(Result.Failure(error.localizedDescription))
                case .cancelled:
                    print("User cancelled login.")
                case .success(_, _, let token):
                    self.subject.onNext(self.fillUser(with: token))
                }
            }
        } else {
            self.subject.onNext(Result.Failure("No token"))
        }
    }
    
    // MARK: Private Properties
    
    var subject: PublishSubject<Result<CurrentUserModel>>
    
    // MARK: Private Methods
    
    func fillUser(with token: AccessToken) -> Result<CurrentUserModel> {
        guard let user = self.model as? CurrentUserModel else {
            return Result.Failure("Invalid parameter")
        }
        user.userID = token.userId
        user.token = token.authenticationToken
        
        return Result.Success(user)
    }
    
    
}
