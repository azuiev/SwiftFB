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
    
    // MARK: Public Properties
    
    var user: UserModel
    var friends: UsersModel {
        guard let result = self.model as? UsersModel else { return UsersModel() }
        
        return result
    }
    
    // MARK: Initialization
    
    init(model: Model, user: UserModel, currentUser: CurrentUserModel) {
        self.user = user
        
        super.init(model: model, currentUser: currentUser)
       
        self.parameters = ["fields" : "id,first_name,last_name,picture{url}"]
        let userID = user.userID ?? ""
        self.graphPath = userID + "/friends/"
    }
    
    // MARK: Override Methods
    
    override func finishLoading(with response: [String : Any]) {
        guard let data = response[Constants.DataKey] as? [[String: Any]] else { return }
        //let summary = response[Constants.SummaryKey] as? [String : Any],
        //let count = summary[Constants.TotalCountKey] as? Int,
        
        var users = [UserModel]()
        
        data.forEach {
            users.append(UserParser.user(with: $0))
        }
        
        self.friends.add(objects: users)
    }
}
