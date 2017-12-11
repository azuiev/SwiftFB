//
//  UserParser.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 15/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class UserParser {
    
    // MARK: Constants
    
    private struct Constants {
        static let nameKey              = "first_name";
        static let surnameKey           = "last_name";
        static let middleNameKey        = "middle_name";
        static let genderKey            = "gender";
        static let birthdayKey          = "birthday";
        static let pictureKey           = "picture";
        static let dataKey              = "data";
        static let urlKey               = "url";
        static let IDKey                = "id";
    }
    
    // MARK: Public Methods
    
    static func update(user: UserModel, with object: JSON) {
        let pictures = object[Constants.pictureKey] as? JSON
        let data = pictures?[Constants.dataKey] as? [String : String]
        let url = URL(string: data?[Constants.urlKey] ?? "")
        let name = object[Constants.nameKey] as? String
        let surname = object[Constants.surnameKey] as? String
        let dateString = object[Constants.birthdayKey] as? String
        let middleName = object[Constants.middleNameKey] as? String
        let gender = object[Constants.genderKey] as? String
        let id = object[Constants.IDKey] as? String
        
        user.userID = id
        user.name = name
        user.surname = surname
        user.middleName = middleName
        
        if url != nil {
            user.picture = ImageModel.model(with: url!)
        }
        
        if dateString != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            user.birthday = dateFormatter.date(from: dateString!)
        }

        user.gender = gender != nil ? Gender(rawValue: gender!) ?? .female : .female
    }

    static func user(with object: [String : Any]) -> UserModel {
        let user = UserModel()
        self.update(user: user, with: object)
        
        return user
    }
}
