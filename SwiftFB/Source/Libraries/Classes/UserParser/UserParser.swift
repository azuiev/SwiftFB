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
        static let pictureURLKey        = "picture.data.url";
        static let pictureKey           = "userPicture";
        static let IDKey                = "id";
        static let name                 = "name";
        static let surname              = "surname";
        static let middleName           = "middleName";
    }
    
    // MARK: Public Methods
    static func update(user: UserModel, with object: Dictionary<String, String>) {
        guard let imageURL = URL(string: object[Constants.pictureURLKey]!),
            let name = object[Constants.nameKey],
            let surname = object[Constants.surnameKey]
        else {
            return
        }
        
        user.name = name
        user.surname = surname
        user.picture = imageURL

//        AZImageModel *imageModel = [AZImageModel imageModelWithURL:imageURL];
//        [user setValue:imageModel forKey:AZUserPictureKey];
//        [user setValue:[object valueForKey:AZUserGenderKey] forKey:AZUserGenderKey];
//        [user setValue:[object valueForKey:AZUserBirthdayKey] forKey:AZUserBirthdayKey];
//        [user setValue:[object valueForKey:AZUserMiddleNameKey] forKey:AZUserMiddleName];
    }

    static func user(with object: Dictionary<String, String>) -> UserModel {
        let user = UserModel()
        self.update(user: user, with: object)
        
        return user
    }
}
