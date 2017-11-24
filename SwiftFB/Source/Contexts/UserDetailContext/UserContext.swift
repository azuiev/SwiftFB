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
            guard let result = self.model as? UserModel else { return nil }
            
            return result
        }
        set { }
    }
    
    override var graphPath: String {
        return self.user?.userID ?? ""
    }
}
