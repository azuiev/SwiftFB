//
//  UserModel.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 03/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class UserModel: Model {
    struct Constants {
        static let EmptyName = "Empty Empty"
    }
    
    // MARK: Public Properties 
    
    var name: String?
    var surname: String?
    var picture: Any?
    var userID: String?
    
    
    // MARK: Public Properties
    
    func fullName() -> String {
        var result = "";
        if let value = self.name {
            result += value
        }
        
        if let value = self.surname {
            result += value
        }
        
        return result == "" ? Constants.EmptyName : result
    }
    
    // MARK: TODO NSCoding
}
