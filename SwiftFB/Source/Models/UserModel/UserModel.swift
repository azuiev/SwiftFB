//
//  UserModel.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 03/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class UserModel: Model {
    
    // MARK: Constants
    
    private struct Constants {
        static let EmptyValue = "Empty"
    }
    
    // MARK: Public Properties 
    
    var name: String?
    var surname: String?
    var picture: Any?
    var userID: String?
    
    
    // MARK: Public Properties
    
    func fullName() -> String {
        return "\(self.name ?? Constants.EmptyValue) \(self.surname ?? Constants.EmptyValue)"
    }
    
    // MARK: TODO NSCoding
}
