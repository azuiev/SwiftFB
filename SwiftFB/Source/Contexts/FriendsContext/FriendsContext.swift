//
//  FriendsContext.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 22/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class FriendsContext: GetContext {
    
    // MARK: Constants
    
    private enum Constants {
        static let DataKey          = "data"
        static let SummaryKey       = "summary"
        static let TotalCountKey    = "total_count"
    }
    
    // MARK: Private Properties
    
    private var privateUser: UserModel?
    
    // MARK: Public Properties
    
    override var graphPath: String { return self.userID + "/friends/"}
    override var parameters: [String : String] {
        return ["fields" : "id,first_name,last_name,picture{url}"]
    }
    
    override var user: UserModel? {
        get {
            return self.privateUser
        }
        set { privateUser = newValue }
    }
    
    var userID: String { return self.user?.userID ?? "" }
    
    var friends: UsersModel {
        guard let result = self.model as? UsersModel else { return UsersModel() }
        
        return result
    }
    
    // MARK: Initialization
    
    init(model: Model, user: UserModel, currentUser: CurrentUserModel) {
        super.init(model: model, currentUser: currentUser)
        
        self.user = user
    }
    
    // MARK: Override Methods
    
    override func finishLoading(with response: [String : Any]) {
        guard let data = response[Constants.DataKey] as? JSONArray else { return }
        
        var users = [UserModel]()
        
        data.forEach {
            users.append(UserParser.user(with: $0))
        }
        
        self.friends.add(objects: users)
    }
}
