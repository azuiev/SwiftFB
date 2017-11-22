//
//  UserModel.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 03/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

enum Gender: String {
    case male
    case female
};

class UserModel: Model {
    
    // MARK: Constants
    
    private struct Constants {
        static let EmptyValue = "Empty"
    }
   
    // MARK: Public Properties 
    
    var name: String?
    var surname: String?
    var middleName: String?
    var userID: String?
    var birthday: Date? 
    var gender: Gender = .male
 
    var picture: ImageModel? {
        didSet {
            self.picture?.load()
        }
    }
    
    var fullName: String {
        return "\(self.name ?? Constants.EmptyValue) \(self.surname ?? Constants.EmptyValue)"
    }
    
    
    
    // MARK: TODO NSCoding
}
