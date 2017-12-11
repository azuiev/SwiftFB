//
//  UserContext.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 15/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class UserContext: GetContext {
    
    // MARK: Public Properties
    
    override var parameters: [String : String] {
        return ["fields" : "first_name,last_name,middle_name,birthday,gender,picture.height(9999){url}"]
    }
    
    override var user: UserModel? {
        get {
            return self.model as? UserModel
        }
        set { }
    }
    
    override var graphPath: String {
        return self.user?.userID ?? ""
    }
    
    override func finishLoading(with response: [String : Any]) {
        self.fill(user: self.model as? UserModel, with: response)
    }
    
    func fill(user: UserModel?, with response: [String : Any]) {
        user.map() {
            UserParser.update(user: $0, with: response)
        }
    }
}
